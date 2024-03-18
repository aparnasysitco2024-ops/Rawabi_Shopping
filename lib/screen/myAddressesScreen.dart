import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';

import '../controller/myAddressController.dart';
import '../widget/addressTile.dart';
import '../widget/commonwidget/reusable_button1.dart';
import '../widget/commonwidget/reusable_text.dart';

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
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Divider(
                          thickness: 1,
                          color: lightGreyColor,
                        ),
                        SizedBox(
                          height: 45,
                          child: ListTile(
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -3),
                            leading: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: blackLight,
                                size: 24,
                              ),
                            ),
                            title: ReusableText(
                              title: "My Addresses".tr,
                              size: 18,
                              weight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                          color: lightGreyColor,
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
                          ? Container(
                              color: white,
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: ListView.separated(
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    myAddressController.addressListData.length,
                                itemBuilder: (context, index) => AddressTile(
                                    addressList: myAddressController
                                        .addressListData[index]),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                  thickness: 1,
                                  color: lightGreyColor,
                                ),
                              ))
                          : Flexible(
                              child: SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("assets/icons/logo.svg"),
                                      const ReusableText(
                                        title: "No address added!!",
                                      )
                                    ]),
                              ),
                            ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          height: 87,
                          color: white,
                          padding: const EdgeInsets.only(
                              left: 18, top: 10, right: 18, bottom: 33),
                          child: ReusableButton1(
                            onPressed: () {},
                            title: "Add New Address",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
