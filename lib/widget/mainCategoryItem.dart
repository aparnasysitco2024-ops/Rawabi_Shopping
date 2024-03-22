import 'package:flutter/material.dart';

import '../model/homeResponse.dart';
import '../screen/productsByCategoryScreen.dart';
import '../utils/app_utils.dart';
import 'commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class MainCategoryItem extends StatelessWidget {
  Category category;
   MainCategoryItem({super.key,required this.category});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/ProductsByCategory',
          arguments: category.catId,
        );

        /*AppUtils.navigateToPage(ProductsByCategory(
          catID: category.catId,
        ));*/
      },
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x332BAAE2),
                        Color(0x339EB9E0),
                        Color(0x33F1C4DE)
                      ]),
                  borderRadius:
                  BorderRadius.circular(10)),
              height: 90,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white),
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder:
                    'assets/images/logo.png',
                    image: category.catIcon
                        .toString()),
              )

            // Image.network(homeController.categoryList[index].catIcon.toString()),
          ),
          const SizedBox(
            height: 5,
          ),
          ReusableText(
            title: category.catName,
            size: 11,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
