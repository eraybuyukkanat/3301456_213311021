import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/config/file_utils.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/calculator/calculator_view_model.dart';
import 'package:social_media_app_demo/sources/buttons.dart';
import 'package:social_media_app_demo/sources/colors.dart';
import 'package:social_media_app_demo/sources/showalertdialog.dart';
import 'package:social_media_app_demo/sources/texts.dart';

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
          title: Text(
            pageTitle,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: ColorManager.black),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          bodyMediumText(
                            text: "Vize",
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
                              text: "Final",
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
                    text: "Notları Kaydet",
                    onPressed: () {
                      vizeNotuController.text != "" &&
                              finalNotuController.text != ""
                          ? FileUtils.saveToFile(vizeNotuController.text +
                              "," +
                              finalNotuController.text)
                          : showAlertDialog("Boş bırakamazsınız", context);
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
                    text: "Sonuçları Getir",
                    onPressed: () {
                      vizeNotuController.text != "" &&
                              finalNotuController.text != ""
                          ? FileUtils.readFromFile().then(
                              (value) {
                                setState(() {
                                  inputVizeValue = value.split(",").first;
                                  inputFinalValue = value.split(",").last;
                                });
                              },
                            )
                          : showAlertDialog("Boş bırakamazsınız", context);
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
                          bodyMediumText(text: "Vize", fontSize: 18),
                          bodyMediumText(
                            text: "${inputVizeValue ?? ""}",
                            fontSize: 25,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          bodyMediumText(text: "Final", fontSize: 18),
                          bodyMediumText(
                            text: "${inputFinalValue ?? ""} ",
                            fontSize: 25,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          bodyMediumText(text: "Ortalama", fontSize: 18),
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
                            text: "Harf",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
