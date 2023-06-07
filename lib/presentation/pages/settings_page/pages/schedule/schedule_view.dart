import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/schedule_view_model.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/schedule/lesson_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/date.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class SchedulePageView extends StatefulWidget {
  const SchedulePageView({super.key});

  @override
  State<SchedulePageView> createState() => _SchedulePageViewState();
}

class _SchedulePageViewState extends SchedulePageViewModel {
  String pageTitle = LocaleKeys.lessonsPage_appBarTitle.locale;
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
          title: headlineMediumText(
            text: LocaleKeys.lessonsPage_appBarTitle,
            fontSize: 32,
            color: ColorManager.black,
          )),
      body: SafeArea(
        child: ekleniyoMu == true
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                                LocaleKeys.lessonsPage_addLessonTitle.locale),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                width: double.maxFinite,
                                child: TextFormField(
                                  maxLength: 15,
                                  controller: lessonNameEditingController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: LocaleKeys
                                        .lessonsPage_lessonNameHint.locale,
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
                                width: double.maxFinite,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        LocaleKeys
                                            .lessonsPage_lessonDayHint.locale,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                    ),
                                    items: items
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value as String;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorManager.third,
                                            width: 2,
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      height: 40,
                                      width: 140,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                width: double.maxFinite,
                                child: TextFormField(
                                  inputFormatters: [
                                    MaskedInputFormatter("##.##"),
                                  ],
                                  maxLength: 5,
                                  keyboardType: TextInputType.number,
                                  controller: lessonTimeEditingController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: LocaleKeys
                                        .lessonsPage_lessonTimeHint.locale,
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
                                width: double.maxFinite,
                                child: TextFormField(
                                  controller: lessonClassEditingController,
                                  decoration: InputDecoration(
                                    hintText: LocaleKeys
                                        .lessonsPage_lessonClassHint.locale,
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
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: widthSizedButton(
                                  color: ColorManager.primary,
                                  text: LocaleKeys.lessonsPage_addButton.locale,
                                  onPressed: () {
                                    if (lessonNameEditingController.value.text != null &&
                                        selectedValue != null &&
                                        lessonTimeEditingController
                                                .value.text !=
                                            null &&
                                        lessonClassEditingController
                                                .value.text !=
                                            null) {
                                      saveModel(
                                        Lesson(
                                            lessonName:
                                                lessonNameEditingController
                                                    .value.text,
                                            lessonDay: selectedValue,
                                            lessonTime:
                                                lessonTimeEditingController
                                                    .value.text,
                                            lessonClass:
                                                lessonClassEditingController
                                                    .value.text),
                                      );

                                      ekleniyor();
                                    } else {
                                      showAlertDialog(
                                          LocaleKeys.showModelDialog_emptyError
                                              .locale,
                                          context);
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: widthSizedButton(
                                  color: ColorManager.red,
                                  text: LocaleKeys
                                      .lessonsPage_cancelButton.locale,
                                  onPressed: () {
                                    ekleniyor();
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : StreamBuilder<List<Lesson>>(
                stream: streamController.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: lessonList.length,
                      itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: double.maxFinite,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            lessonList[index]
                                                .lessonName
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium
                                                ?.copyWith(
                                                    color: ColorManager.white,
                                                    fontSize: 28),
                                            maxLines: 1,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: ColorManager.red,
                                          ),
                                          onPressed: () {
                                            deleteModel(lessonList[index].id);
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(
                                      lessonList[index].lessonDay.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: ColorManager.white),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      lessonList[index].lessonTime.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: ColorManager.white),
                                      maxLines: 2,
                                    ),
                                    Text(
                                      lessonList[index].lessonClass.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: ColorManager.white),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                },
              ),
      ),
      floatingActionButton: ekleniyoMu
          ? SizedBox()
          : FloatingActionButton(
              onPressed: () {
                ekleniyor();
              },
              child: Icon(Icons.add),
            ),
    );
  }
}

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}
