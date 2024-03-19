import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/homeDeliveryMapScreen.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/storeTile.dart';

import '../widget/commonwidget/reusable_text.dart';

class DeliveryModeScreen extends StatefulWidget {
  const DeliveryModeScreen({super.key});

  @override
  State<DeliveryModeScreen> createState() => _DeliveryModeScreenState();
}

class _DeliveryModeScreenState extends State<DeliveryModeScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: silver,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: white,
              padding: const EdgeInsets.all(0),
              width: double.maxFinite,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),

                  SizedBox(
                    height: 45,
                    child: ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -3),
                      leading: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: blackLight,
                          size: 24,
                        ),
                      ),
                      title: ReusableText(
                        title: "Delivery Mode".tr,
                        size: 18,
                        weight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: lightGreyColor,
                  ),
                  SizedBox(
                    height: 33,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: primaryColor,
                        unselectedLabelColor: blackLight,
                        labelColor: primaryColor,
                        controller: _tabController,
                        tabs: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: ReusableText(
                              title: "Home Delivery".tr,
                              size: 14,
                              weight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: ReusableText(
                              title: "Store Pickup".tr,
                              size: 14,
                              weight: FontWeight.w600,
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

        Expanded(

          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                const HomeDeliveryMapScreen(),
                // Stack(
                //   children: [
                //     Container(
                //       height: MediaQuery.of(context).size.height,
                //       width: MediaQuery.of(context).size.width,
                //       decoration: const BoxDecoration(
                //         image: DecorationImage(
                //           fit: BoxFit.cover,
                //           image: AssetImage("assets/images/map.png"),
                //         ),
                //       ),
                //       child: SafeArea(
                //           child: Align(
                //             alignment: Alignment.bottomCenter,
                //             child: Container(
                //               height: 210,
                //               width: double.maxFinite,
                //               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                //               alignment: Alignment.bottomLeft,
                //               decoration: BoxDecoration(
                //                 color: white,
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               child: Column(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //
                //                   Padding(
                //                     padding: const EdgeInsets.only(top:18.0),
                //                     child: Row(
                //                       crossAxisAlignment: CrossAxisAlignment.start,
                //                       children: [
                //                         SvgPicture.asset(
                //                           "assets/icons/location.svg",
                //                           fit: BoxFit.contain,
                //                           width: 25,
                //                           height: 25,
                //                         ),
                //                         const SizedBox(
                //                           width: 10,
                //                         ),
                //                         const Flexible(
                //                           child: Text(
                //                             'Al Wakra, Doha,\n Qatar.',
                //                             softWrap: true,
                //                             maxLines: 2,
                //                             style: TextStyle(
                //                               fontSize: 18,
                //                               fontWeight: FontWeight.w600,
                //                               fontFamily: "OpenSans",
                //                               color: blackLight,
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //
                //                   ReusableButton(borderRadius:4.0,onTap: () {}, title: "Confirm Location"),
                //                 ],
                //               ),
                //             ),
                //           )),
                //     ),
                //     Container(
                //       width: 380,
                //       height: 45,
                //       alignment: Alignment.center,
                //       decoration: const BoxDecoration(
                //           color: white,
                //           borderRadius: BorderRadius.all(Radius.circular(4))),
                //       margin: const EdgeInsets.all(10) ,
                //       padding: const EdgeInsets.only(right: 10),
                //       child:  TextField(
                //         decoration: InputDecoration(
                //           filled: true,
                //           fillColor: white,
                //           hintText: "Search Location".tr,
                //           contentPadding: const EdgeInsets.only(left: 10),
                //           prefixIcon: const Icon(Icons.search,color: blackLight,),
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(4),
                //             borderSide: BorderSide.none,
                //           ),
                //           focusedBorder: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(4),
                //             borderSide: BorderSide.none,
                //           ),
                //         ),
                //       ),
                //     )
                //   ]
                // ),
                ListView.separated(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) =>  const StoreTile(title: "Rawabi Al khor, T tower Building"),
                    separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 5,)
                ),

              ],
            ),
          ),),
          ],
        ),
      ),
    );
  }
}
