import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/posts_page/comments/post_comments_view_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:social_media_app_demo/sources/loading_bar.dart';

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
                                    onPressed: (context) {},
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
                                  commentView(snapshot, index, context),
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

Container commentView(
    AsyncSnapshot<List<Comment>> resources, int index, BuildContext context) {
  String src =
      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';
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
    ),
    width: double.maxFinite,
    child: Container(
      decoration: BoxDecoration(
          color: ColorManager.primary, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 3.w,
                      ),
                      Container(
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorManager.primary,
                          child: CircleAvatar(
                            radius: 35,
                            child: ClipOval(
                              child: Image.network(
                                src,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Container(
                        child: Text(
                          resources.data![index].email.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: ColorManager.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                resources.data![index].description ?? "HATA",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 17, color: ColorManager.white),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
