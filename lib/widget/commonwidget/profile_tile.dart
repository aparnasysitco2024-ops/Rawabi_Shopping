import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

class ProfileTile extends StatelessWidget {
  final String image;
  final String title;
  const ProfileTile({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.maxFinite,
      padding: const EdgeInsets.only(top: 17,bottom: 15),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            image,
            fit: BoxFit.fill,
            width: 20,
            height: 20,
          ),
          SizedBox(width: 15,),
          ReusableText(title: title.tr, size: 16, weight: FontWeight.w600),
          Spacer(),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFB0B0B0),
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
