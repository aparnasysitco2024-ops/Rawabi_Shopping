import 'package:flutter/material.dart';
import '../model/response/homeResponse.dart';
import 'commonwidget/reusable_text.dart';

// ignore: must_be_immutable
class CategoryGroupItem extends StatelessWidget {
  Category category;

  CategoryGroupItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/ProductsByCategory',
          arguments: {
            'catId': category.catId,
            'subCatId': "0",
            'subSubCatId': "0",
            'subSubSubCatId': "0"
          },
        );


      },
      child: SizedBox(
        width: 90,
        child: Column(
          children: [
            Container(
              height: 80,
              // width: double.infinity,
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(10.0),
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/images/logo.png',
                    image: category.catIcon.toString()),
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
      ),
    );
  }
}
