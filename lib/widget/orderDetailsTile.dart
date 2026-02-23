import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonWidget/reusable_button1.dart';
import 'package:rawabi/widget/commonWidget/reusable_textformfieldbox.dart';
import 'package:rawabi/widget/commonwidget/reusableNetworkImage.dart';
import 'package:rawabi/widget/commonwidget/reusable_text.dart';

import '../controller/myOrderDetailsController.dart';
import '../model/response/myorder/items.dart';
import '../model/response/myorder/myOrderResponse.dart';
import '../utils/commonUtils.dart';

// ignore: must_be_immutable
class OrderDetailsTile extends StatelessWidget {
  Items items;
  Orders myOrder;
  final myOrderDetailController = Get.put(MyOrderDetailController());

  OrderDetailsTile({super.key, required this.items, required this.myOrder});

  void returnPopup(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ReusableText(
                  title: "Enter Return Reason",
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReusableTextFormBox(
                    controller: myOrderDetailController.returnReasonController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 45,
                    child: ReusableButton1(
                      title: "Submit",
                      fontSize: 13,
                      onPressed: () {
                        if (myOrderDetailController
                            .returnReasonController.value.text.isNotEmpty) {
                          Get.back();
                          return myOrderDetailController.returnItem(
                              items.itemId.toString(),
                              items.detailId.toString(),
                              myOrderDetailController
                                  .returnReasonController.text);
                        } else {
                          Get.back();
                          CommonUtils()
                              .messageBox("Please enter the return reason");
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 45,
                )
              ],
            ),
          );
        });
      },
    );
  }

  void showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      // set to false if you want to force a rating
      builder: (context) => RatingDialog(
        initialRating: 1.0,
        // your app's name?
        title: Text(
          'Rate & Review',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        // encourage your user to leave a high rating?
        // message: Text(
        //   'Tap a star to set your rating. Add more description here if you want.',
        //   textAlign: TextAlign.center,
        //   style: const TextStyle(fontSize: 15),
        // ),
        // your app's logo?
        image: ReusableNetworkImage(
          image: items.itemImage.toString(),
          height: 60.0,
        ),
        submitButtonText: 'Submit',
        commentHint: 'Enter your comment here',
        onCancelled: () => print('cancelled'),
        onSubmitted: (response) {
          print('rating: ${response.rating}, comment: ${response.comment}');

          myOrderDetailController.rating(items.itemId.toString(),
              response.rating.toString(), response.comment);

          // if (response.rating < 3.0) {
          //   // send their comments to your email or anywhere you wish
          //   // ask the user to contact you instead of leaving a bad review
          // } else {
          //   // _rateAndReviewApp();
          // }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Checkbox(
          //   checkColor: white,
          //   activeColor: primaryColor,
          //   value: false,
          //   onChanged: (bool? value) {},
          // ),
          SizedBox(
              width: 60,
              child: ReusableNetworkImage(
                image: items.itemImage.toString(),
                height: 60.0,
              )),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  title: items.itemName,
                  size: 10,
                  weight: FontWeight.w600,
                  color: darkGrey,
                ),
                items.delete == "yes"
                    ? ReusableText(
                        title: "(Item Deleted)",
                        size: 10,
                        weight: FontWeight.w600,
                        color: darkGrey,
                      )
                    : items.alter == "yes"
                        ? ReusableText(
                            title: "(Item Replaced)",
                            size: 10,
                            weight: FontWeight.w600,
                            color: darkGrey,
                          )
                        : SizedBox(),

                // ReusableText(
                //   title: "Order #23243",
                //   size: 10,
                //   weight: FontWeight.w600,
                //   color: darkGrey,
                // ),
                // Row(
                //   children: [
                    // CircleAvatar(
                    //   backgroundColor: blue,
                    //   radius: 3,
                    // ),
                    // SizedBox(
                    //   width: 2,
                    // ),
                    // ReusableText(
                    //   title: "Out for delivery".tr,
                    //   color: blue,
                    //   size: 10,
                    //   weight: FontWeight.w400,
                    // ),
                    // SizedBox(
                    //   width: 10,
                    // ),

                    // myOrder.status == "Processing" &&
                    //         myOrder.order_type == "delivery"
                    //     ? ReusableText(
                    //         title: "Arriving in ".tr +
                    //             items.deliveryDays.toString() +
                    //             " days".tr,
                    //         size: 10,
                    //         weight: FontWeight.w400,
                    //       )
                    //     : SizedBox(),
                //   ],
                // ),
                ReusableText(
                  title: items.itemQty! + "x QAR ${items.itemPrice}",
                  size: 10,
                  weight: FontWeight.w600,
                ),
                myOrder.status == "Delivered"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 5,
                            width: double.infinity,
                          ),
                          Container(
                            width: 80,
                            height: 25,
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: ReusableButton1(
                              backgroundColor: Colors.green,
                              onPressed: () {
                                showRatingDialog(context);
                              },
                              title: "Review".tr,
                              fontSize: 10,
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
                myOrder.status == "Delivered" && items.returnEligible == 1
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 5,
                            width: double.infinity,
                          ),
                          Container(
                            width: 70,
                            height: 25,
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: ReusableButton1(
                              onPressed: () {
                                returnPopup(context);
                                // return myOrderDetailController.returnItem(
                                //       items.itemId.toString(),
                                //       items.detailId.toString(),
                                //       "");
                              },
                              title: "Return".tr,
                              fontSize: 10,
                            ),
                          )
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
