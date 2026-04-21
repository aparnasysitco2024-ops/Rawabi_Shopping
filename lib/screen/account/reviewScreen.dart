import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radio_group_v2/widgets/views/radio_group.dart';
import 'package:radio_group_v2/widgets/views/radio_group.dart' as custom;
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';

import '../../controller/reviewController.dart';
import '../../widget/Commonwidget/reusable_text.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({super.key});

  final reviewController = Get.put(ReviewController());

  List<String> selectedReportList = [];

  @override
  Widget build(BuildContext context) {
    // profileController.getMyProfile();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: white,
              padding: const EdgeInsets.only(bottom: 0),
              width: double.maxFinite,
              child: Column(
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
                            title: "Review".tr,
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
                  const Divider(
                    thickness: 2,
                    color: lightGreyColor,
                  ),
                ],
              ),
            ),
            Obx(() => reviewController.loading.value
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        color: white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ReusableText(
                                    title:
                                        "We are here to improve your experience!",
                                    weight: FontWeight.bold,
                                    textAlign: TextAlign.center,
                                    size: 14,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ReusableText(
                                    title:
                                        "Your feedback matters! Please tell us what you think of our app below.",
                                    textAlign: TextAlign.center,
                                    size: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ReusableText(
                                title:
                                    "How do you feel about your visit on our app today?",
                                textAlign: TextAlign.center,
                                weight: FontWeight.bold,
                                size: 14,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              custom.RadioGroup(
                                orientation: custom.RadioGroupOrientation.vertical,
                                controller: reviewController.radioController,
                                values: [
                                  "Very Poor",
                                  "Poor",
                                  "Fair",
                                  "Good",
                                  "Excellent"
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ReusableText(
                                title:
                                    "Sorry to here that! What was the problem",
                                textAlign: TextAlign.center,
                                weight: FontWeight.bold,
                                size: 14,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MultiSelectChip(
                                reviewController.reportList,
                                onSelectionChanged: (selectedList) {
                                  // setState(() {
                                  selectedReportList = selectedList;
                                  // });
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 74,
                                width: double.maxFinite,
                                color: white,
                                padding: const EdgeInsets.only(
                                    left: 0, right: 0, top: 10, bottom: 20),
                                child: ReusableButton1(
                                  title: "Share with us",
                                  onPressed: () {
                                    reviewController.submitReview();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),

            // Container(
            //   color: silver,
            //   height: 3,
            // ),
          ],
        ),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {required this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  final reviewController = Get.put(ReviewController());

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: reviewController.selectedChoices!.contains(item),
          onSelected: (selected) {
            setState(() {
              reviewController.selectedChoices!.contains(item)
                  ? reviewController.selectedChoices!.remove(item)
                  : reviewController.selectedChoices!.add(item);
              widget.onSelectionChanged(reviewController.selectedChoices!);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
