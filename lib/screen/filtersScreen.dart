// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/widget/productTypeFilterTile.dart';

import '../../utils/colors.dart';
import '../../widget/commonwidget/reusable_text.dart';
import '../controller/homeController.dart';
import '../model/request/filterRequest.dart';
import '../model/response/productsResponse.dart';
import '../widget/commonwidget/reusable_button1.dart';

class FiltersScreen extends StatefulWidget {
  List<Brands> brandList;
  List<Subcategory> subCategoryListFilter;
  Price price;
  List<String> selectedBrands = [];
  FilterRequest filterRequest = FilterRequest();
  Function(FilterRequest) selectedItem;
  var minController = TextEditingController();
  var maxController = TextEditingController();
  var minAmount = 0;
  var maxAmount = 200;
  RangeValues currentRangeValues = RangeValues(0, 200);
  final homeController = Get.put(HomeController());
  FiltersScreen(
      {super.key,
      required this.brandList,
      required this.selectedItem,
      required this.subCategoryListFilter,
      required this.price});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  int selectedIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    widget.minAmount = widget.price.min!.contains(".")
        ? int.parse(widget.price.min!.split(".").first)
        : int.parse(widget.price.min.toString());
    widget.maxAmount = widget.price.max!.contains(".")
        ? int.parse(widget.price.max!.split(".").first)
        : int.parse(widget.price.max.toString());
    widget.minController.text = widget.minAmount.toString();
    widget.maxController.text = widget.maxAmount.toString();
    widget.currentRangeValues = RangeValues(
        double.parse(widget.minAmount.toString()),
        double.parse(widget.maxAmount.toString()));
    super.initState();
  }

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
                  height: 100,
                  color: white,
                  width: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
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
                                title: widget.homeController.languageParam.value.filters,
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
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // GestureDetector(
                          //   onTap: () {
                          //     if (mounted) {
                          //       setState(() {
                          //         selectedIndex = 0;
                          //         _controller.jumpToPage(0);
                          //       });
                          //     }
                          //   },
                          //   child: Container(
                          //     alignment: Alignment.centerLeft,
                          //     height: 50,
                          //     width: 90,
                          //     decoration: BoxDecoration(
                          //       color: selectedIndex == 0 ? white : silver,
                          //       border:
                          //           Border.all(color: lightGreyColor, width: 1),
                          //     ),
                          //     child: Padding(
                          //       padding: EdgeInsets.only(left: 15),
                          //       child: ReusableText(
                          //         title: "Category".tr,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          GestureDetector(
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  selectedIndex = 0;
                                  _controller.jumpToPage(0);
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                color: selectedIndex == 0 ? white : silver,
                                border:
                                    Border.all(color: lightGreyColor, width: 1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: ReusableText(
                                  title: widget.homeController.languageParam.value.brand,
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
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 50,
                              width: 90,
                              decoration: BoxDecoration(
                                color: selectedIndex == 1 ? white : silver,
                                border:
                                    Border.all(color: lightGreyColor, width: 1),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: ReusableText(
                                  title: widget.homeController.languageParam.value.price,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                          child: Container(
                        color: white,
                        child: PageView(
                          onPageChanged: (value) {
                            setState(() {
                              selectedIndex=value;
                            });
                          },
                          controller: _controller,
                          children: [
                            // ListView.builder(
                            //     padding: const EdgeInsets.only(top: 0),
                            //     physics: const BouncingScrollPhysics(),
                            //     shrinkWrap: true,
                            //     itemCount: widget.subCategoryListFilter.length,
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return ProductTypeFilterTile(
                            //         title: widget.subCategoryListFilter[index].subcatName.toString(),
                            //         isChecked: false,
                            //         checked: (bool) {},
                            //       );
                            //     }),
                            ListView.builder(
                                padding: const EdgeInsets.only(top: 0),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: widget.brandList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductTypeFilterTile(
                                    checked: (p0) {
                                      setState(() {
                                        if (p0)
                                          widget.selectedBrands.add(widget
                                              .brandList[index].id
                                              .toString());
                                        else
                                          widget.selectedBrands.remove(widget
                                              .brandList[index].id
                                              .toString());
                                      });
                                    },
                                    title:
                                        widget.brandList[index].name.toString(),
                                    isChecked: widget.selectedBrands
                                        .contains(widget.brandList[index].id),
                                  );
                                }),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.homeController.languageParam.value.choosePriceRange.toString(),
                                        style: const TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      ReusableButton1(
                                        onPressed: () {
                                          setState(() {
                                            widget.currentRangeValues =
                                                RangeValues(
                                                    double.parse(
                                                        widget
                                                            .minAmount
                                                            .toString()),
                                                    double.parse(widget
                                                        .maxAmount
                                                        .toString()));
                                            widget.minController.text =
                                                widget.minAmount.toString();
                                            widget.maxController.text =
                                                widget.maxAmount.toString();
                                          });
                                        },
                                        title: widget.homeController.languageParam.value.reset,
                                        size: Size(48, 22),
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 36,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: silver,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: ReusableText(
                                            title: "QAR " +
                                                widget.minController.text,
                                          ),
                                        ),
                                      ),
                                     SizedBox(width: 10,),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          height: 36,
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: silver,
                                              borderRadius:
                                                  BorderRadius.circular(7)),
                                          child: ReusableText(
                                            title: "QAR " +
                                                widget.maxController.text,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.homeController.languageParam.value.min.toString(),
                                        style: const TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        widget.homeController.languageParam.value.max.toString(),
                                        style: const TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RangeSlider(
                                  values: widget.currentRangeValues,
                                  min:
                                      double.parse(widget.minAmount.toString()),
                                  max:
                                      double.parse(widget.maxAmount.toString()),
                                  divisions: 20,
                                  activeColor: primaryColor,
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      widget.currentRangeValues = values;
                                      widget.minController.text =
                                          values.start.toInt().toString();
                                      widget.maxController.text =
                                          values.end.toInt().toString();
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
                            onPressed: () {
                              setState(() {
                                widget.selectedBrands.clear();
                                //resret price
                                widget.currentRangeValues = RangeValues(
                                    double.parse(widget.minAmount.toString()),
                                    double.parse(widget.maxAmount.toString()));
                                widget.minController.text =
                                    widget.minAmount.toString();
                                widget.maxController.text =
                                    widget.maxAmount.toString();
                              });
                            },
                            backgroundColor: white,
                            txtColor: blackLight,
                            size: const Size(160, 44),
                            title: widget.homeController.languageParam.value.clear,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            isOutlineButton: true,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 3,
                          child: ReusableButton1(
                            onPressed: () {
                              widget.filterRequest.brand = widget.selectedBrands
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", "");

                              //set price
                              widget.filterRequest.min =
                                  widget.minController.text;
                              widget.filterRequest.price =
                                  widget.maxController.text;

                              widget.selectedItem(widget.filterRequest);
                              Navigator.of(context).pop(context);
                            },
                            size: const Size(200, 44),
                            title: widget.homeController.languageParam.value.apply,
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
