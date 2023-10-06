import 'package:btolet/controller/location_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

class MultiMap extends StatefulWidget {
  const MultiMap({super.key});

  @override
  State<MultiMap> createState() => _MultiMapState();
}

class _MultiMapState extends State<MultiMap> {
  LocationController locationController = Get.put(LocationController());
  late String _mapStyle;
  late BitmapDescriptor mapMarker;

  Set<Marker> markers = {};
  GoogleMapController? controller;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller.setMapStyle(_mapStyle);
    });
  }

  addMarker() {
    markers
        .addLabelMarker(
      LabelMarker(
        label: "2,000",
        markerId: const MarkerId("1"),
        position: const LatLng(22.798798, 89.554125),
        backgroundColor: Colors.blue,
        infoWindow: const InfoWindow(title: '1bed,1bath,1kitchen'),
        onTap: () {},
      ),
    )
        .then(
      (value) {
        setState(() {});
      },
    );
  }

  void setCustomeMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/logo/pin.png',
    );
  }

  @override
  void initState() {
    super.initState();
    setCustomeMarker();
    addMarker();
    rootBundle.loadString('assets/map/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        tiltGesturesEnabled: true,
        scrollGesturesEnabled: true,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        zoomGesturesEnabled: true,
        // padding: const EdgeInsets.only(bottom: 20900),
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            locationController.currentlatitude.value,
            locationController.currentlongitude.value,
          ),
          zoom: 16.0,
        ),
        onMapCreated: _onMapCreated,
        markers: markers,
      ),
    );
  }
}
