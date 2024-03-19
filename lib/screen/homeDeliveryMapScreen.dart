import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';

class HomeDeliveryMapScreen extends StatefulWidget {
  const HomeDeliveryMapScreen({super.key});

  @override
  State<HomeDeliveryMapScreen> createState() => HomeDeliveryMapScreenState();
}

class HomeDeliveryMapScreenState extends State<HomeDeliveryMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late Position _currentPosition;
  late CameraPosition _kGooglePlex;
  double lat = 25.2854;
  double lng = 51.5310;

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 18,
    );
    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _kGooglePlex = CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 18,
      );
      print(
          "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Container(
            width: 380,
            height: 45,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(right: 10),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: white,
                hintText: "Search Location".tr,
                contentPadding: const EdgeInsets.only(left: 10),
                prefixIcon: const Icon(
                  Icons.search,
                  color: blackLight,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 180,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/location.svg",
                          fit: BoxFit.contain,
                          width: 25,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Flexible(
                          child: Text(
                            'Al Wakra, Doha,\n Qatar.',
                            softWrap: true,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "OpenSans",
                              color: blackLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // _currentPosition != null
                  //     ? ReusableText(title:
                  //     "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}")
                  //     : CircularProgressIndicator(),
                  SizedBox(
                    height: 40,
                    child: ReusableButton1(
                      title: "Confirm Location",
                      onPressed: () {},
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
