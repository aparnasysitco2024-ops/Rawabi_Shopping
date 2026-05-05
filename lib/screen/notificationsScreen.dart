// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rawabi/widget/notificationTile.dart';
// import 'package:rawabi/widget/searchOrderWidget.dart';
//
// import '../utils/colors.dart';
// import '../widget/commonwidget/reusable_text.dart';
//
// // ignore: must_be_immutable
// class NotificationsScreen extends StatelessWidget {
//
//   NotificationsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: silver,
//         body: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   color: white,
//                   width: double.maxFinite,
//                   padding: const EdgeInsets.only(bottom: 10),
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       const Divider(
//                         thickness: 1,
//                         color: lightGreyColor,
//                       ),
//                       Container(
//                         height: 60,
//                         width: double.maxFinite,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.only(top: 5, bottom: 5),
//                         child: Stack(
//                           children: [
//                             Center(
//                               child: ReusableText(
//                                 title: "Notifications".tr,
//                                 size: 18,
//                                 weight: FontWeight.bold,
//                                 textAlign: TextAlign.left,
//                               ),
//                             ),
//                             Positioned(
//                               left: 20,
//                               top: 10,
//                               child: InkWell(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Icon(
//                                   Icons.arrow_back_ios,
//                                   color: blackLight,
//                                   size: 24,
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                        SearchOrdersWidget(hintText: "Search notification".tr,),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 18.0, vertical: 8),
//                     child: ListView.separated(
//                         padding: const EdgeInsets.all(0),
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: 5,
//                         itemBuilder: (context, index) => const NotificationTile()
//                             ,
//                         separatorBuilder:
//                             (BuildContext context, int index) =>
//                         const SizedBox(height: 5,)),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
