import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/schedule_view_model.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/lesson_model.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:sqflite_common/sqlite_api.dart';

class SchedulePageView extends StatefulWidget {
  const SchedulePageView({super.key});

  @override
  State<SchedulePageView> createState() => _SchedulePageViewState();
}

class _SchedulePageViewState extends SchedulePageViewModel {
  String pageTitle = "Ders Programı";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
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
            pageTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.black),
          )),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text("Ders Ekle"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 70.w,
                            height: 9.h,
                            child: TextFormField(
                              controller: lessonNameEditingController,
                              decoration: InputDecoration(
                                hintText: "Dersin Adı..",
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 70.w,
                            height: 9.h,
                            child: TextFormField(
                              controller: lessonDayEditingController,
                              decoration: InputDecoration(
                                hintText: "Dersin Günü..",
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 70.w,
                            height: 9.h,
                            child: TextFormField(
                              controller: lessonTimeEditingController,
                              decoration: InputDecoration(
                                hintText: "Dersin Saati..",
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: 70.w,
                            height: 9.h,
                            child: TextFormField(
                              controller: lessonClassEditingController,
                              decoration: InputDecoration(
                                hintText: "Dersin Sınıfı..",
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
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            saveModel(Lesson(
                                lessonName:
                                    lessonNameEditingController.value.text,
                                lessonDay:
                                    lessonDayEditingController.value.text,
                                lessonTime:
                                    lessonTimeEditingController.value.text,
                                lessonClass:
                                    lessonClassEditingController.value.text));
                          },
                          icon: Icon(Icons.send))
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: StreamBuilder<List<Lesson>>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: lessonList.length,
                    itemBuilder: (_, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(lessonList[index].lessonName.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      fontSize: 18, color: ColorManager.black)),
                          subtitle: Text(
                              lessonList[index].lessonClass.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      fontSize: 16, color: ColorManager.black)),
                          leading: Text(
                            lessonList[index].id.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 22),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: ColorManager.red,
                            ),
                            onPressed: () {
                              deleteModel(lessonList[index].id);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
