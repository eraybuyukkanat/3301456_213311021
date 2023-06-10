import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/pages/posts_page/comments/post_comments_view.dart';
import 'package:social_media_app_demo/presentation/pages/posts_page/posts/posts_page_view_model.dart';
import 'package:social_media_app_demo/sources/customformfield.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';
import 'package:social_media_app_demo/sources/post/post_model.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import '../../../../sources/buttons.dart';
import '../../../../sources/colors.dart';

class PostsPageView extends StatefulWidget {
  const PostsPageView({super.key});

  @override
  State<PostsPageView> createState() => _PostsPageViewState();
}

class _PostsPageViewState extends State<PostsPageView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostsPageViewModel>(
      create: (context) => PostsPageViewModel(context),
      builder: (context, child) => Scaffold(
        //APPBAR
        appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 5.w,
            elevation: 10,
            backgroundColor: ColorManager.white,
            toolbarHeight: 10.h,
            centerTitle: false,
            title: headlineMediumText(
              text: context.read<PostsPageViewModel>().appBarTitle,
              color: ColorManager.black,
              fontSize: 32,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    addPostPage(context);
                  },
                  icon: Icon(
                    Icons.add,
                    color: ColorManager.black,
                  ),
                ),
              )
            ]),

        //BODY
        body: StreamBuilder<List<Post>>(
            stream: context.watch<PostsPageViewModel>().streamController.stream,
            builder: (context, resources) {
              if (context.watch<PostsPageViewModel>().isLoading) {
                return Center(child: loadingWidget());
              }
              return resources.data?.length != 0
                  ? RefreshIndicator(
                      color: ColorManager.primary,
                      strokeWidth: 3,
                      onRefresh: context.read<PostsPageViewModel>().bind,
                      child: ListView.builder(
                        itemCount: resources.data!.length,
                        itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              postView(resources, index, context),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(LocaleKeys.postsPage_emptyPostList.locale));
            }),
      ),
    );
  }

  Container postView(
      AsyncSnapshot<List<Post>> resources, int index, BuildContext context) {
    String year = resources.data![index].createdAt!.substring(0, 4).toString();
    String month = resources.data![index].createdAt!.substring(4, 8).toString();
    String day = resources.data![index].createdAt!.substring(8, 10).toString();
    String date = ("${day}" + "${month}" + "${year}");

    String date2 = resources.data![index].createdAt!.substring(11, 19);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.secondary,
      ),
      width: double.maxFinite,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(5)),
                  //POST TITLE
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: ColorManager.primary,
                              child: CircleAvatar(
                                radius: 35,
                                child: ClipOval(
                                  child: Image.network(
                                    context.read<PostsPageViewModel>().src,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          context.read<PostsPageViewModel>().isEditingNow ==
                                  resources.data![index].sId
                              ? Container(
                                  padding: EdgeInsets.all(5),
                                  width: 60.w,
                                  child: editPostTitleFormField(
                                      postEditTitleTextEditingController: context
                                          .read<PostsPageViewModel>()
                                          .postEditTitleTextEditingController),
                                )
                              : bodyLargeText(
                                  text: resources.data![index].title ?? "HATA",
                                  fontSize: 17,
                                  color: ColorManager.white,
                                )
                        ],
                      ),
                      Row(
                        children: [
                          if (resources.data![index].email ==
                              FirebaseAuth.instance.currentUser!.email)
                            context.read<PostsPageViewModel>().isEditingNow ==
                                    resources.data![index].sId
                                ? IconButton(
                                    onPressed: () {
                                      if (context
                                                  .read<PostsPageViewModel>()
                                                  .postEditTitleTextEditingController!
                                                  .value
                                                  .text
                                                  .length !=
                                              0 &&
                                          context
                                                  .read<PostsPageViewModel>()
                                                  .postEditDescriptionTextEditingController!
                                                  .value
                                                  .text
                                                  .length !=
                                              0) {
                                        context.read<PostsPageViewModel>().updatePost(
                                            resources.data![index].sId,
                                            context
                                                .read<PostsPageViewModel>()
                                                .postEditTitleTextEditingController!
                                                .value
                                                .text,
                                            context
                                                .read<PostsPageViewModel>()
                                                .postEditDescriptionTextEditingController!
                                                .value
                                                .text,
                                            FirebaseAuth
                                                .instance.currentUser!.email,
                                            FirebaseAuth.instance.currentUser!
                                                .displayName,
                                            resources.data![index].description);
                                      } else {
                                        context
                                            .read<PostsPageViewModel>()
                                            .changeIsEditingNow("", "", "");
                                        showAlertDialog(
                                            LocaleKeys
                                                .showModelDialog_emptyError
                                                .locale,
                                            context);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.done,
                                      color: ColorManager.white,
                                    ))
                                : PopupMenuButton<String>(
                                    color: ColorManager.white,
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          child: Text(LocaleKeys
                                              .postsPage_deletePostText.locale),
                                          onTap: () {
                                            context
                                                .read<PostsPageViewModel>()
                                                .deletePost(
                                                    resources.data![index].sId);
                                          },
                                        ),
                                        PopupMenuItem(
                                          child: Text(LocaleKeys
                                              .postsPage_editPostText.locale),
                                          onTap: () {
                                            context
                                                .read<PostsPageViewModel>()
                                                .changeIsEditingNow(
                                                    resources.data![index].sId,
                                                    resources
                                                        .data![index].title,
                                                    resources.data![index]
                                                        .description);
                                          },
                                        )
                                      ];
                                    }),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            context.read<PostsPageViewModel>().isEditingNow ==
                    resources.data![index].sId
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    width: double.maxFinite,
                    child: editPostDescriptionFormField(
                        postEditDescriptionTextEditingController: context
                            .read<PostsPageViewModel>()
                            .postEditDescriptionTextEditingController),
                  )
                : bodyMediumText(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    text: "${resources.data![index].description}",
                    fontSize: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bodyMediumText(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      text: resources.data![index].creator ?? "HATA",
                      color: ColorManager.black,
                      fontSize: 15,
                    ),
                    bodyMediumText(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      text: resources.data![index].email ?? "HATA",
                      fontSize: 15,
                      color: ColorManager.black,
                    ),
                    Row(
                      children: [
                        bodyMediumText(
                          padding: EdgeInsets.only(right: 4.w, top: 3),
                          text: date,
                          fontSize: 15,
                          color: ColorManager.black,
                        ),
                        bodyMediumText(
                          text: date2,
                          fontSize: 15,
                        )
                      ],
                    ),
                  ],
                ),
                commentIcon(context, resources, index)
              ],
            )
          ],
        ),
      ),
    );
  }

  Padding commentIcon(
      BuildContext context, AsyncSnapshot<List<Post>> resources, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 20),
      child: IconButton(
        icon: Icon(Icons.comment),
        iconSize: 30,
        color: ColorManager.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => PostCommentsView(
                id: resources.data![index].sId.toString(),
                index: index,
                title: resources.data![index].title.toString(),
                description: resources.data![index].description.toString(),
                email: resources.data![index].email.toString(),
                createdAt: resources.data![index].createdAt.toString(),
              ),
            ),
          );
          context.read<PostsPageViewModel>().changeIsEditingNow("", "", "");
        },
      ),
    );
  }

  Future<dynamic> addPostPage(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(top: 60, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleLargeText(
                  text: context.read<PostsPageViewModel>().pageTitle,
                  fontSize: 25,
                  padding: EdgeInsets.only(bottom: 30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    bodyMediumText(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      text: context.read<PostsPageViewModel>().title,
                      fontSize: 20,
                    ),
                    postTitleInputFormField(
                        postTitleTextEditingController: context
                            .watch<PostsPageViewModel>()
                            .postTitleTextEditingController),
                  ],
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bodyMediumText(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        text: context.read<PostsPageViewModel>().description,
                        fontSize: 20,
                      ),
                      postDescriptionInputFormField(
                          scrollController: context
                              .watch<PostsPageViewModel>()
                              .scrollController,
                          postDescriptionTextEditingController: context
                              .watch<PostsPageViewModel>()
                              .postDescriptionTextEditingController),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: widthSizedButton(
                    color: ColorManager.primary,
                    text: context.read<PostsPageViewModel>().buttonText,
                    onPressed: () {
                      context.read<PostsPageViewModel>().postValues();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
