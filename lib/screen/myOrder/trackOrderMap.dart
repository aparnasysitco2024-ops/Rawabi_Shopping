import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/commonWidget/reusable_text.dart';
import 'package:rawabi/widget/headerWidget.dart';

import '../../utils/constants.dart';

class TrackOrderMap extends StatefulWidget {
  final String id;
  TrackOrderMap({super.key, required this.id});
  @override
  _TrackOrderMapState createState() => _TrackOrderMapState();
}

late CollectionReference orderTrackingCollection;


class _TrackOrderMapState extends State<TrackOrderMap> {
  double lat = 0.0;
  double lng = 0.0;
  late CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  late BitmapDescriptor sourceIcon=BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
  late BitmapDescriptor destinationIcon=BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta);
// Starting point latitude
  double _deliveryBoyLatitude =25.2854;
// Starting point longitude
  double _deliveryBoyLongitude = 51.5310;
// Destination latitude
  double _destLatitude = 25.1881567;
// Destination Longitude
  double _destLongitude = 51.5465687;
// Markers to show points on the map

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  Map<MarkerId, Marker> markers = {};

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0,size: Size(0,0)), 'assets/icons/image.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
        'assets/icons/destination_marker.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }


  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      API_KEY,
      PointLatLng(_deliveryBoyLatitude, _deliveryBoyLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: primaryColor,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  LatLngBounds _bounds(Set<Marker> markers) {
    //if (markers == null || markers.isEmpty) return null;
    return _createBounds(markers.map((m) => m.position).toList());
  }


  LatLngBounds _createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((p) => p.latitude).reduce((value, element) => value < element ? value : element); // smallest
    final southwestLon = positions.map((p) => p.longitude).reduce((value, element) => value < element ? value : element);
    final northeastLat = positions.map((p) => p.latitude).reduce((value, element) => value > element ? value : element); // biggest
    final northeastLon = positions.map((p) => p.longitude).reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLon),
        northeast: LatLng(northeastLat, northeastLon)
    );
  }

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 18,
    );

   setSourceAndDestinationIcons();

    _getPolyline();

    super.initState();
  }
  Future<void> _goToThePlace() async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Location")
          .doc(widget.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          lat = data['latitude'];
          lng = data['longitude'];
          _deliveryBoyLatitude=lat;
          _deliveryBoyLongitude=lng;
          print(data['latitude'].toString());
          print(data['longitude'].toString());
          _kGooglePlex = CameraPosition(
            target: LatLng(lat, lng),
            zoom: 12
          );
          _goToThePlace();
        }
        return Scaffold(
          body: Column(
            children: [
              HeaderWidget(
                title: "Track",
                onBack: () {},
              ),
              ReusableText(
                title: "lat: " + lat.toString(),
              ),
              ReusableText(
                title: "lng: " + lng.toString(),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: GoogleMap(
                        myLocationEnabled: true,
                        zoomControlsEnabled: true,
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        polylines: Set<Polyline>.of(polylines.values), // Add this line
                        markers: {

                           Marker(
                        markerId: MarkerId("Delivery Boy"),
                        position: LatLng(_deliveryBoyLatitude, _deliveryBoyLongitude),
                             icon: sourceIcon,
                             infoWindow: InfoWindow(
                               title:"Delivery Boy"
                             ),
                      ),
                          Marker(
                        markerId: const MarkerId("destination"),
                        position: LatLng(_destLatitude, _destLongitude),
                            icon: destinationIcon,
                      ),
                        },
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(bottom:20),
                    //     child: SvgPicture.asset(
                    //       "assets/icons/marker.svg",
                    //       height: 35,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
