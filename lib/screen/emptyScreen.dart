// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/headerWidget.dart';

import '../widget/commonWidget/reusable_text.dart';

class EmptyScreen extends StatelessWidget {
  var title;

  EmptyScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(
            onBack: () {},
            title: title,
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/logo.svg"),
                    ReusableText(
                      title: "No data found!!".tr,
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
