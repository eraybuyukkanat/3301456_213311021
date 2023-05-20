import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/posts_page/comments/post_comments_view_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';

import '../../../../sources/colors.dart';
import '../../../../sources/comment/comment_model.dart';

class PostCommentsView extends StatefulWidget {
  const PostCommentsView(
      {super.key,
      required this.index,
      required this.id,
      required this.title,
      required this.description,
      required this.email,
      required this.createdAt});
  final int index;
  final String title;
  final String id;
  final String description;
  final String email;
  final String createdAt;
  @override
  State<PostCommentsView> createState() => _PostCommentsViewState();
}

class _PostCommentsViewState extends PostCommentsViewModel {
  String src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            titleSpacing: 3.h,
            elevation: 10,
            backgroundColor: ColorManager.white,
            toolbarHeight: 10.h,
            centerTitle: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.black,
              ),
            ),
            title: Text(
              pageTitle!,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: ColorManager.black),
            )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text("Yorum Ekle"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70.w,
                            child: TextFormField(
                              controller: commentTextEditingController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: ColorManager.third,
                                      width: 2.0,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: ColorManager.primary,
                                      width: 2.0,
                                    )),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                postComments();
                              },
                              icon: Icon(Icons.send))
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: StreamBuilder<List<Comment>>(
                      stream: streamController.stream,
                      builder: (context, snapshot) {
                        if (isLoading) {
                          return Center(child: loadingWidget());
                        }
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.35,
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      changeIsEditingNow(
                                          snapshot.data![index].sId,
                                          snapshot.data![index].description);
                                    },
                                    foregroundColor: Colors.black,
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      deleteComment(snapshot.data![index].sId);
                                    },
                                    foregroundColor: Colors.red,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
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
                                    ),
                                    width: double.maxFinite,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorManager.primary,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        child: CircleAvatar(
                                                          radius: 18,
                                                          backgroundColor:
                                                              ColorManager
                                                                  .primary,
                                                          child: CircleAvatar(
                                                            radius: 35,
                                                            child: ClipOval(
                                                              child:
                                                                  Image.network(
                                                                src,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .email
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                                  color:
                                                                      ColorManager
                                                                          .white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  isEditingNow ==
                                                          snapshot
                                                              .data![index].sId
                                                      ? IconButton(
                                                          onPressed: () {
                                                            if (commentEditEditingController
                                                                    .value
                                                                    .text
                                                                    .length !=
                                                                0) {
                                                              updateComment(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .sId,
                                                                  commentEditEditingController
                                                                      .value
                                                                      .text);
                                                            } else {
                                                              changeIsEditingNow(
                                                                  "", "");
                                                              showAlertDialog(
                                                                  "Boş bırakamazsınız",
                                                                  context);
                                                            }
                                                          },
                                                          icon: Icon(
                                                            Icons.done,
                                                            color: ColorManager
                                                                .white,
                                                          ))
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: isEditingNow ==
                                                      snapshot.data![index].sId
                                                  ? SizedBox(
                                                      height: 10.h,
                                                      child: Container(
                                                        height: 10.h,
                                                        width: double.maxFinite,
                                                        child: TextFormField(
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .displayMedium
                                                              ?.copyWith(
                                                                  color:
                                                                      ColorManager
                                                                          .white,
                                                                  fontSize: 20),
                                                          decoration:
                                                              InputDecoration(
                                                            counterText: "",
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                              color:
                                                                  ColorManager
                                                                      .white,
                                                              width: 2.0,
                                                            )),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: ColorManager
                                                                          .secondary,
                                                                      width:
                                                                          2.0,
                                                                    )),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                              color:
                                                                  Colors.white,
                                                              width: 2.0,
                                                            )),
                                                          ),
                                                          maxLength: 100,
                                                          maxLines: null,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          controller:
                                                              commentEditEditingController,
                                                        ),
                                                      ),
                                                    )
                                                  : Text(
                                                      snapshot.data![index]
                                                              .description ??
                                                          "HATA",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium
                                                          ?.copyWith(
                                                              fontSize: 17,
                                                              color:
                                                                  ColorManager
                                                                      .white),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ));
  }
}
