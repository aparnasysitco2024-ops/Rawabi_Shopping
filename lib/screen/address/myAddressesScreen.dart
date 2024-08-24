import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/address/addNewAddressMapScreen.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/colors.dart';

import '../../controller/myAddressController.dart';
import '../../widget/addressTile.dart';
import '../../widget/commonwidget/reusable_button1.dart';
import '../../widget/commonwidget/reusable_text.dart';

class MyAddressesScreen extends StatelessWidget {
  MyAddressesScreen({super.key});

  final myAddressController = Get.put(MyAddressController());

  @override
  Widget build(BuildContext context) {
    myAddressController.getAddressList();
    return Obx(() => Scaffold(
          backgroundColor: silver,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: white,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        // const Divider(
                        //   thickness: 1,
                        //   color: lightGreyColor,
                        // ),
                        Container(
                          height: 40,
                          width: double.maxFinite,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Stack(
                            children: [
                              Center(
                                child: ReusableText(
                                  title: "My Addresses".tr,
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
                  myAddressController.loading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height - 280,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        )
                      : myAddressController.addressListData.isNotEmpty
                          ? Flexible(
                              child: Container(
                                  color: white,
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    // physics: const NeverScrollableScrollPhysics(),
                                    itemCount: myAddressController
                                        .addressListData.length,
                                    itemBuilder: (context, index) =>
                                        AddressTile(
                                            addressList: myAddressController
                                                .addressListData[index]),
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(
                                      thickness: 1,
                                      color: lightGreyColor,
                                    ),
                                  )),
                            )
                          : Expanded(
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("assets/icons/logo.svg",height: 80,),
                                      ReusableText(
                                        title: "No address added!!".tr,
                                      )
                                    ]),
                              ),
                            ),
                  myAddressController.loading.value
                      ? SizedBox()
                      : Row(
                          children: [
                            myAddressController.defaultAddressId.isNotEmpty
                                ? Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          height: 87,
                                          color: white,
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              top: 10,
                                              right: 5,
                                              bottom: 33),
                                          child: ReusableButton1(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            title: "Deliver To This Address".tr,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  )
                                : SizedBox(),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    height: 87,
                                    color: white,
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        top: 10,
                                        right: 15,
                                        bottom: 33),
                                    child: ReusableButton1(
                                      onPressed: () {
                                        AppUtils.navigateToPage(
                                            AddNewAddressesMapScreen());
                                      },
                                      title: "Add New Address".tr,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
