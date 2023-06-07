import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/config/extensions.dart';
import 'package:social_media_app_demo/config/file_utils.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/calculator/calculator_view_model.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/calculator/graphic.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/lang/locale_keys.g.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';
import 'package:social_media_app_demo/sources/texts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_demo/sources/colors.dart';

class CalculatorViewPage extends StatefulWidget {
  const CalculatorViewPage({super.key});

  @override
  State<CalculatorViewPage> createState() => _CalculatorViewPageState();
}

class _CalculatorViewPageState extends CalculatorViewModel {
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
            text: pageTitle,
            fontSize: 32,
            color: ColorManager.black,
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          bodyMediumText(
                            text: LocaleKeys.calculatePage_midtermText,
                            fontSize: 20,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                CustomRangeTextInputFormatter()
                              ],
                              controller: vizeNotuController,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                counterText: "",
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
                          bodyMediumText(
                              text: LocaleKeys.calculatePage_finalText,
                              fontSize: 20,
                              padding: EdgeInsets.symmetric(vertical: 10)),
                          Container(
                            height: 60,
                            width: 60,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                CustomRangeTextInputFormatter()
                              ], //
                              controller: finalNotuController,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                counterText: "",
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: widthSizedButton(
                    color: ColorManager.primary,
                    text: LocaleKeys.calculatePage_saveButton,
                    onPressed: () {
                      vizeNotuController.text != "" &&
                              finalNotuController.text != ""
                          ? FileUtils.saveToFile(vizeNotuController.text +
                              "," +
                              finalNotuController.text)
                          : showAlertDialog(
                              LocaleKeys.showModelDialog_emptyError.locale,
                              context);
                    },
                  ),
                ),
                Row(
                  children: [Container()],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: widthSizedButton(
                    color: ColorManager.primary,
                    text: LocaleKeys.calculatePage_getDatasButton,
                    onPressed: () {
                      vizeNotuController.text != "" &&
                              finalNotuController.text != ""
                          ? FileUtils.readFromFile().then(
                              (value) {
                                setState(() {
                                  inputVizeValue = value.split(",").first;
                                  inputFinalValue = value.split(",").last;
                                  chartIsVisible = true;
                                });
                              },
                            )
                          : showAlertDialog(
                              LocaleKeys.showModelDialog_emptyError.locale,
                              context);
                      vizeNotuController.clear();
                      finalNotuController.clear();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          bodyMediumText(
                              text: LocaleKeys.calculatePage_midtermText,
                              fontSize: 18),
                          bodyMediumText(
                            text: "${inputVizeValue ?? ""}",
                            fontSize: 25,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          bodyMediumText(
                              text: LocaleKeys.calculatePage_finalText,
                              fontSize: 18),
                          bodyMediumText(
                            text: "${inputFinalValue ?? ""} ",
                            fontSize: 25,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          bodyMediumText(
                              text: LocaleKeys.calculatePage_avgText,
                              fontSize: 18),
                          bodyMediumText(
                            text:
                                "${calculateAvg(inputVizeValue, inputFinalValue).toStringAsFixed(3)}",
                            fontSize: 25,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          bodyMediumText(
                            text: LocaleKeys.calculatePage_letterText,
                            fontSize: 18,
                          ),
                          bodyMediumText(
                            text: "${calculateLetter()}",
                            fontSize: 18,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                chartIsVisible ? LineChartSample2() : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
