import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawabi/screen/navigator/bottomNavBar.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/utils/storage_manager.dart';
import 'package:rawabi/widget/commonwidget/reusable_button1.dart';

import '../controller/homeController.dart';

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
  late Position position;
  double lat = 25.2854;
  double lng = 51.5310;
  String address = "";
  late Placemark place;
  late CameraPosition selectedPosition;
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 18,
    );
    _determinePosition();
  }

  _getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // setState(() {
    _currentPosition = position;
    _kGooglePlex = CameraPosition(
      target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
      zoom: 18,
    );
    _getAddressFromLatLng(_kGooglePlex);
    _goToThePlace();
    print(
        "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}");
    // });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return _getCurrentLocation();
    // return await Geolocator.getCurrentPosition();
  }

  Future<void> _goToThePlace() async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  Future<void> _getAddressFromLatLng(CameraPosition position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.target.latitude, position.target.longitude);
    place = placemarks.length > 1 ? placemarks[1] : placemarks[0];
    setState(() {
      address = "${place.subLocality!}, ${place.locality}";
      print(address);
      // _currentAddress =
      // '${place.street}, ${place.subLocality},
      // ${place.subAdministrativeArea}, ${place.postalCode}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 145),
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMove: (position) {
                selectedPosition = position;
              },
              onCameraIdle: () {
                _getAddressFromLatLng(selectedPosition);
              },
            ),
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
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 185),
              child: SvgPicture.asset(
                "assets/icons/marker.svg",
                height: 35,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
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
                        Flexible(
                          child: Text(
                            address,
                            softWrap: true,
                            maxLines: 2,
                            style: const TextStyle(
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
                      onPressed: () {
                        if (address.isNotEmpty) {
                          homeController.storeAddress.value = address;
                          StorageManager.saveData(
                              StorageManager.keyStoreAddress, address);
                          AppUtils.navigateToPageRemoveUntil(
                               BottomNavBar());
                        }
                      },
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
