import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';
import '../utils/colors.dart';
import 'commonwidget/reusable_text.dart';

class WishlistGridItem extends StatelessWidget {
  final String? title;
  final String image;

  const WishlistGridItem({super.key, this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      width: 183,
      color: white,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title == null
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 2),
                        decoration: const BoxDecoration(
                            color: lightPink,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: ReusableText(
                          title: title,
                          color: primaryColor,
                          size: 12,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
              SvgPicture.asset(
                "assets/icons/heart.svg",
                fit: BoxFit.fill,
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            image,
            fit: BoxFit.fill,
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/fastdelivery.svg",
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const ReusableText(
                title: "KFMBC Pizza Mix 1 kg",
                size: 14,
                weight: FontWeight.w600,
              ),
              const SizedBox(
                height: 5,
              ),
              const ReusableText(
                title: "30 gm",
                size: 10,
                weight: FontWeight.w400,
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "QAR 30.55",
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: "OpenSans",
                          decoration: TextDecoration.lineThrough
                        ),
                      ),
                      ReusableText(
                        title: "QAR 22.50",
                        size: 12,
                        weight: FontWeight.w700,
                      ),

                    ],
                  ),
                  ReusableButton1(
                    title: "Add",
                    size: Size(70,27),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
