import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/homeController.dart';
import '../../controller/languageController.dart';
import '../../utils/colors.dart';
import '../../utils/storage_manager.dart';
import '../../widget/commonWidget/reusable_text.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final languageController = Get.put(LanguageController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // updateLanguage(Locale locale) {
    //   Get.updateLocale(locale);
    //   AppUtils.navigateToPageRemoveUntil(BottomNavBar());
    // }

    languageController.getLanguages();
    return Obx(() => PopScope(
          onPopInvoked: (didPop) {
            Get.delete<LanguageController>();
          },
          child: Scaffold(
              backgroundColor: silver,
              body: Column(
                children: [
                  Container(
                    color: white,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 45,
                        ),
                        Container(
                          height: 40,
                          width: double.maxFinite,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Stack(
                            children: [
                              Center(
                                child: ReusableText(
                                  title: "Language".tr,
                                  size: 18,
                                  weight: FontWeight.bold,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Positioned(
                                left: 20,
                                top: 0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    // Get.delete<WishListController>();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: blackLight,
                                    size: 24,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  languageController.loading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 280,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: languageController.languageList.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  // StorageManager.saveData(
                                  //     StorageManager.keyLanguage,
                                  //     languageController
                                  //         .languageList[index].language);
                                  StorageManager.saveData(
                                      StorageManager.keyLanguageID,
                                      languageController
                                          .languageList[index].id);

                                  // if (languageController
                                  //         .languageList[index].language ==
                                  //     "Arabic")
                                  //   updateLanguage(Locale('ar', 'SA'));
                                  // else
                                  //   updateLanguage(Locale('en', 'US'));

                                  StorageManager.setAndReturnLang(
                                      languageController
                                          .languageList[index].language
                                          .toString());
                                  homeController.getLanguageParam(
                                      languageController
                                          .languageList[index].language
                                          .toString(),
                                      languageController.languageList[index].id
                                          .toString());
                                  // Get.deleteAll();
                                },
                                child: Container(
                                  height: 52,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ReusableText(
                                          title: languageController
                                              .languageList[index].language
                                              .toString(),
                                          size: 12,
                                          weight: FontWeight.w600),
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: languageController
                                                    .selectedLanguage.value ==
                                                languageController
                                                    .languageList[index]
                                                    .language
                                            ? Icon(
                                                Icons.check,
                                                color: primaryColor,
                                                size: 18,
                                              )
                                            : SizedBox(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                height: 5,
                              ))
                ],
              )),
        ));
  }
}
