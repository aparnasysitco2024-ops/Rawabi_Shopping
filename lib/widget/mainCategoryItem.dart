import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/response/homeResponse.dart';
import 'commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class MainCategoryItem extends StatelessWidget {
  Category category;

  MainCategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/ProductsByCategory',
          arguments: {
            'catId': category.catId,
            'subCatId': category.sub_cat_id,
            'subSubCatId': category.sub_sub_cat_id,
            'subSubSubCatId': category.sub_sub_sub_cat_id,
          },
        );

        /*AppUtils.navigateToPage(ProductsByCategory(
          catID: category.catId,
        ));*/
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green),
            height: 83,
            width: 90,
            child: ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, url) =>
                    Center(child: Image.asset('assets/images/logo.png')),
                imageUrl: category.catIcon.toString(),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          ReusableText(
            title: category.catName,
            size: 11,
            maxLine: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
