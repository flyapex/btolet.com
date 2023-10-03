import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class MultiMap extends StatefulWidget {
  const MultiMap({super.key});

  @override
  State<MultiMap> createState() => _MultiMapState();
}

class _MultiMapState extends State<MultiMap> {
  MapController controller = Get.put(MapController());
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kYeditepe =
      CameraPosition(target: LatLng(40.971991, 29.152793), zoom: 17, tilt: 17);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kYeditepe,
        markers: Set<Marker>.of(controller.markers.values),
        onMapCreated: (GoogleMapController mapController) {
          rootBundle.loadString('assets/map_styles.txt').then((string) {
            String mapStyle = string;
            mapController.setMapStyle(mapStyle);
            _controller.complete(mapController);
          });
        },
      ),
    );
  }
}

class MapController extends GetxController {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    generateMarkers();
  }

  generateMarkers() {
    int count = 0;
    for (var item in _markers) {
      count += 1;
      final String markerIdVal = 'marker_id_$count';
      final MarkerId markerId = MarkerId(markerIdVal);

      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          double.parse(item[1].toString()),
          double.parse(item[2].toString()),
        ),
        infoWindow: InfoWindow(title: item[0].toString(), snippet: 'Content'),
      );

      markers[markerId] = marker;
    }
  }

  final _markers = [
    [
      'Nirala Residential Area',
      22.798499,
      89.552697,
      '/assets/icons/logo.png',
      'Khulna'
    ],
    [
      'Khulna',
      22.798222,
      89.555208,
      '/assets/icons/logo.png',
      'Khulna',
    ]
  ];
}
