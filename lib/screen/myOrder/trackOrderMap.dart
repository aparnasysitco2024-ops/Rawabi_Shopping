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
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
// Starting point latitude
  double _originLatitude =25.2854;
// Starting point longitude
  double _originLongitude = 51.5310;
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
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/driving_pin.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
        'assets/destination_map_marker.png')
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
      PointLatLng(_originLatitude, _originLongitude),
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


 /* void _addPolyline() {
    final PolylineId polylineId = PolylineId('polyline_id');
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      color: Colors.blue,
      points: [
        LatLng(25.2854, 51.5310),
        LatLng(25.1881567, 51.5465687),
        // Add more LatLng points for your polyline here
      ],
      width: 5,
    );

    setState(() {
      _polylines[polylineId] = polyline;
    });
  }

  void _updatePolyline(*//* parameters for new points *//*) {
    final PolylineId polylineId = PolylineId('polyline_id');
    final Polyline? polyline = _polylines[polylineId]?.copyWith(
      pointsParam: [
        // New list of LatLng points
      ],
    );

    setState(() {
      _polylines[polylineId] = polyline!;
    });
  }*/

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 18,
    );

    _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

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
          .doc('54')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          lat = data['latitude'];
          lng = data['longitude'];
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
                        zoomControlsEnabled: false,
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          //_addPolyline();
                        },polylines: Set<Polyline>.of(polylines.values), // Add this line

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
