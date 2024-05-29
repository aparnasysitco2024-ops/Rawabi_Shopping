import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rawabi/utils/colors.dart';
import 'package:rawabi/widget/headerWidget.dart';
import '../../utils/constants.dart';

class TrackOrderMap extends StatefulWidget {
  final String id;
  final String? destinationLatLng;
  TrackOrderMap({super.key, required this.id, required this.destinationLatLng});
  @override
  _TrackOrderMapState createState() => _TrackOrderMapState();
}

late CollectionReference orderTrackingCollection;


class _TrackOrderMapState extends State<TrackOrderMap> {
 // double lat = 0.0;
  //double lng = 0.0;
  late CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  late BitmapDescriptor sourceIcon=BitmapDescriptor.defaultMarker;
  late BitmapDescriptor destinationIcon=BitmapDescriptor.defaultMarker;
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
        ImageConfiguration(devicePixelRatio: 2.0), 'assets/icons/driverIcon150.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
        'assets/icons/destination_marker.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void getDestinationLocation() {
    if (widget.destinationLatLng == null) {
      //print("destination is null");
      _destLatitude = 0.00;
      _destLongitude=0.00;

    } else {
      //print("destination is not null");
      print(widget.destinationLatLng);
      List<String>? latLng = widget.destinationLatLng!.split(",");
      _destLatitude = double.parse(latLng[0]);
      _destLongitude = double.parse(latLng[1]);

    }
  }

  /*_addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }*/
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
  Future<void> updateCameraLocation(
      LatLng source,
      LatLng destination,
      GoogleMapController mapController,
      ) async {
    //if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  @override
  void initState() {
    _kGooglePlex = CameraPosition(
      target: LatLng(_deliveryBoyLatitude, _deliveryBoyLongitude),
      zoom: 12,
    );
    getDestinationLocation();
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
          _deliveryBoyLatitude= data['latitude'];
          _deliveryBoyLongitude= data['longitude'];
          print(data['latitude'].toString());
          print(data['longitude'].toString());
          _kGooglePlex = CameraPosition(
            target: LatLng(_deliveryBoyLatitude, _deliveryBoyLongitude),
            zoom: 12
          );
          _getPolyline();
          //_goToThePlace();

        }
        return Scaffold(
          body: Column(
            children: [
              HeaderWidget(
                title: "Track",
                onBack: () {},
              ),
              // ReusableText(
              //   title: "lat: " + _deliveryBoyLatitude.toString(),
              // ),
              // ReusableText(
              //   title: "lng: " + _deliveryBoyLongitude.toString(),
              // ),
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
                        onMapCreated: (GoogleMapController controller) async {
                          _controller.complete(controller);
                          await updateCameraLocation(LatLng(_deliveryBoyLatitude, _deliveryBoyLongitude), LatLng(_destLatitude, _destLongitude), controller);

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
                            infoWindow: InfoWindow(
                                title:"Destination",
                            ),
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
