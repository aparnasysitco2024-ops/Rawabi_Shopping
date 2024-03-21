import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/commonwidget/reusable_textformfield.dart';
import 'package:rawabi/widget/productTypeFilterTile.dart';
import '../../utils/colors.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../widget/commonwidget/reusable_button1.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  int selectedIndex = 0;
  RangeValues _currentRangeValues = const RangeValues(0, 200);
  List<String> dummyProductType = [
    "Apple",
    "Tomato",
    "Berries",
    "Carrot",
    "Grapes",
    "Onion",
    "Potato",
    "Herbs",
    "Leaves",
    "Bananas",
    "Cabbage",
    "Chilly",
    "Cucumber",
    "Garlic",
    "Capsicum",
    "Mushrooms"
  ];
  List<bool> dummyProductSelected = [
    true,
    false,
    false,
    false,
    false,
    true,
    false,
    false,
    false,
    false,
    true,
    false,
    false,
    false,
    false,
    false,
  ];
  List<String> dummyCategoryType = [
    "Category 1",
    "Category 2",
    "Category 3",
    "Category 4",
    "Category 5",
  ];
  List<bool> dummyCategorySelected = [
    true,
    false,
    false,
    false,
    false,
  ];
  List<String> dummyBrandType = [
    "Brand 1",
    "Brand 2",
    "Brand 3",
    "Brand 4",
    "Brand 5",
  ];
  List<bool> dummyBrandSelected = [
    true,
    false,
    false,
    false,
    false,
  ];
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: silver,
        body: SingleChildScrollView(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 120,
                  color: white,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Divider(
                        thickness: 1,
                        color: lightGreyColor,
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
                                title: "Filters".tr,
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
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                flex: 18,
                child: Container(
                  color: silver,
                  child: Expanded(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    selectedIndex = 0;
                                    _controller.jumpToPage(0);
                                  });
                                }
                              },
                              child: Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 0 ? white : silver,
                                    border: Border.all(
                                        color: lightGreyColor, width: 1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: ReusableText(
                                      title: "Product Type",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    selectedIndex = 1;
                                    _controller.jumpToPage(1);
                                  });
                                }
                              },
                              child: Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 1 ? white : silver,
                                    border: Border.all(
                                        color: lightGreyColor, width: 1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: ReusableText(
                                      title: "Category",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    selectedIndex = 2;
                                    _controller.jumpToPage(2);
                                  });
                                }
                              },
                              child: Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 2 ? white : silver,
                                    border: Border.all(
                                        color: lightGreyColor, width: 1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: ReusableText(
                                      title: "Brand",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    selectedIndex = 3;
                                    _controller.jumpToPage(3);
                                  });
                                }
                              },
                              child: Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 50,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: selectedIndex == 3 ? white : silver,
                                    border: Border.all(
                                        color: lightGreyColor, width: 1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: ReusableText(
                                      title: "Price",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Container(
                          color: white,
                          child: PageView(
                            controller: _controller,
                            children: [
                              ListView.builder(
                                padding: const EdgeInsets.only(top: 0),
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: dummyProductType.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductTypeFilterTile(
                                      title: dummyProductType[index],
                                      isChecked: dummyProductSelected[index],
                                    );
                                  }),
                              ListView.builder(
                                  padding: const EdgeInsets.only(top: 0),
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: dummyCategoryType.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductTypeFilterTile(
                                      title: dummyCategoryType[index],
                                      isChecked: dummyCategorySelected[index],
                                    );
                                  }),
                              ListView.builder(
                                  padding: const EdgeInsets.only(top: 0),
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: dummyBrandType.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductTypeFilterTile(
                                      title: dummyBrandType[index],
                                      isChecked: dummyBrandSelected[index],
                                    );
                                  }),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Choose price Range".tr,
                                          style: const TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),

                                          textAlign: TextAlign.left,
                                        ),
                                        const ReusableButton1(
                                          title:"Reset",
                                          size: Size(48,22),
                                          fontSize: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(

                                          alignment: Alignment.centerLeft,
                                          height: 36,
                                          width: 130,

                                          child: const ReusableTextForm(
                                            contentPadding: EdgeInsets.all(5),
                                            hintText: "AED 0",
                                            borderRadius: 6.0,
                                            fillColor: silver,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          height: 36,
                                          width: 130,
                                          child:  const ReusableTextForm(
                                            contentPadding: EdgeInsets.all(5),
                                            hintText: "AED 200",
                                            borderRadius: 6.0,
                                            fillColor: silver,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Min".tr,
                                          style: const TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),),
                                      Text(
                                        "Max".tr,
                                        style: const TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      ],
                                    ),
                                  ),
                                  RangeSlider(
                                    values: _currentRangeValues,
                                    min: 0,
                                    max: 1000,
                                    divisions: 20,
                              activeColor: primaryColor,
                                    onChanged: (RangeValues values) {
                                      setState(() {
                                        _currentRangeValues = values;
                                      });
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 80,
                    color: white,
                    padding: const EdgeInsets.only(
                        left: 18, top: 10, right: 18, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: ReusableButton1(
                            onPressed: () {},
                            backgroundColor: white,
                            txtColor: blackLight,
                            size: const Size(160, 44),
                            title: "Clear",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            isOutlineButton: true,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          flex: 3,
                          child: ReusableButton1(
                            onPressed: () {},
                            size: const Size(200, 44),
                            title: "Apply",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        )));
  }
}
