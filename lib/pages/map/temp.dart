
// class MapController extends GetxController {
//   Map<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

//   @override
//   void onInit() {
//     generateMarkers();
//     super.onInit();
//   }

//   // Future<BitmapDescriptor> _createMarkerImageFromAsset(String imagePath) async {
//   //   final ByteData data = await rootBundle.load(imagePath);
//   //   final Uint8List bytes = data.buffer.asUint8List();
//   //   return BitmapDescriptor.fromBytes(bytes);
//   // }

//   Future<Uint8List> _createMarkerImageFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }

//   generateMarkers() async {
//     int count = 0;
//     for (var item in _markers) {
//       count += 1;
//       final String markerIdVal = 'marker_id_$count';
//       final MarkerId markerId = MarkerId(markerIdVal);

//       // Load the marker icon from the asset path
//       final Uint8List markerIcon = await _createMarkerImageFromAsset(
//         'assets/logo/pin.png',
//         200,
//       );

//       final Marker marker = Marker(
//         markerId: markerId,
//         position: LatLng(
//           double.parse(item[1].toString()),
//           double.parse(item[2].toString()),
//         ),
//         infoWindow: InfoWindow(
//           title: item[0].toString(),
//           snippet: 'Content',
//         ),
//         icon: BitmapDescriptor.fromBytes(markerIcon),
//       );

//       markers[markerId] = marker;
//     }
//   }
// }











// import 'dart:async';
// import 'package:btolet/controller/location_controller.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MultiMap extends StatefulWidget {
//   const MultiMap({super.key});

//   @override
//   State<MultiMap> createState() => _MultiMapState();
// }

// class _MultiMapState extends State<MultiMap> {
//   LocationController locationController = Get.put(LocationController());
//   final Completer<GoogleMapController> _controller = Completer();

//   Iterable markers = [];

//   final Iterable _markers = Iterable.generate(AppConstant.list.length, (index) {
//     return Marker(
//       markerId: MarkerId(AppConstant.list[index]['id']),
//       position: LatLng(
//         AppConstant.list[index]['lat'],
//         AppConstant.list[index]['lon'],
//       ),
//       infoWindow: InfoWindow(
//         title: AppConstant.list[index]["title"],
//       ),
//     );
//   });

//   @override
//   void initState() {
//     setState(() {
//       markers = _markers;
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             tiltGesturesEnabled: true,
//             scrollGesturesEnabled: true,
//             gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//               Factory<OneSequenceGestureRecognizer>(
//                 () => EagerGestureRecognizer(),
//               ),
//             },
//             zoomGesturesEnabled: true,
//             // padding: const EdgeInsets.only(bottom: 20900),
//             mapType: MapType.normal,
//             zoomControlsEnabled: true,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             initialCameraPosition: CameraPosition(
//               target: LatLng(
//                 locationController.currentlatitude.value,
//                 locationController.currentlongitude.value,
//               ),
//               zoom: 16.0,
//             ),
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//             markers: Set.from(markers),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AppConstant {
//   static List<Map<String, dynamic>> list = [
//     {"title": "one", "id": "1", "lat": 22.798222, "lon": 89.555208},
//     {"title": "two", "id": "2", "lat": 22.798499, "lon": 89.552697},
//     {"title": "three", "id": "3", "lat": 23.8061939, "lon": 90.3771193},
//   ];
// }
