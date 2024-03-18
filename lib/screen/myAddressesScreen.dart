import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_button.dart';

import '../widget/addressTile.dart';
import '../widget/commonwidget/reusable_text.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: silver,
      body: SingleChildScrollView(
        child: Container(
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
                    const Divider(thickness: 1,color: lightGreyColor,),
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
                    const Divider(thickness: 2,color: lightGreyColor,),
                  ],
                ),
              ),
              Container(
                  color: white,
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10),
                  child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount:2,
                      itemBuilder: (context, index) =>
                          const AddressTile(),
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(thickness: 1,color: lightGreyColor,),
                          )),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 87,
                      color: white,
                      padding: const EdgeInsets.only(left: 18,top: 10,right: 18,bottom: 33),
                      child: ReusableButton(onTap: (){}, title: "Add New Address",borderRadius: 4.0,)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
