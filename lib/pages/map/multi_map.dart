// import 'dart:math';

// import 'package:btolet/controller/location_controller.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:label_marker/label_marker.dart';

// class MultiMap extends StatefulWidget {
//   const MultiMap({super.key});

//   @override
//   State<MultiMap> createState() => _MultiMapState();
// }

// class _MultiMapState extends State<MultiMap> {
//   LocationController locationController = Get.put(LocationController());
//   late String _mapStyle;
//   late BitmapDescriptor mapMarker;

//   Set<Marker> markers = {};

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       controller.setMapStyle(_mapStyle);
//     });
//   }

//   void setCustomeMarker() async {
//     mapMarker = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(),
//       'assets/logo/pin.png',
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     setCustomeMarker();
//     rootBundle.loadString('assets/map/map_style.txt').then((string) {
//       _mapStyle = string;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButton: FloatingActionButton(
//       //   child: const Icon(Icons.add),
//       //   onPressed: (() {
//       //     final lat = (Random().nextDouble() * 180) - 90;
//       //     final lng = (Random().nextDouble() * 360) - 180;
//       //     final title = "title${Random().nextInt(1000)}";
//       //     mapMarker
//       //         .addLabelMarker(LabelMarker(
//       //       label: title,
//       //       markerId: MarkerId(title),
//       //       position: LatLng(lat, lng),
//       //       backgroundColor: Colors.green,
//       //     ))
//       //         .then(
//       //       (value) {
//       //         setState(() {});
//       //       },
//       //     );
//       //   }),
//       // ),
//       body: _GoogleMap(
//         tiltGesturesEnabled: true,
//         scrollGesturesEnabled: true,
//         gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
//           Factory<OneSequenceGestureRecognizer>(
//             () => EagerGestureRecognizer(),
//           ),
//         },
//         zoomGesturesEnabled: true,
//         // padding: const EdgeInsets.only(bottom: 20900),
//         mapType: MapType.normal,
//         zoomControlsEnabled: true,
//         myLocationEnabled: true,
//         myLocationButtonEnabled: false,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(
//             locationController.currentlatitude.value,
//             locationController.currentlongitude.value,
//           ),
//           zoom: 16.0,
//         ),
//         onMapCreated: _onMapCreated,
//         // onMapCreated: (GoogleMapController controller) {
//         //   _controller.complete(controller);
//         // },
//         markers: _markers.values.toSet(),
//       ),
//     );
//   }
// }

// List<Map<String, dynamic>> data = [
//   {
//     'id': '1',
//     'position': const LatLng(22.798222, 89.555208),
//     'widget': const CustomeMarker(price: 200)
//   },
//   {
//     'id': '2',
//     'position': const LatLng(22.798499, 89.552697),
//     'widget': const CustomeMarker(price: 100)
//   },
// ];

// class CustomeMarker extends StatelessWidget {
//   final double price;
//   const CustomeMarker({super.key, required this.price});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 75,
//       width: 75,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           const Icon(
//             Icons.arrow_downward,
//             color: Colors.black,
//             size: 50,
//           ),
//           Container(
//             margin: const EdgeInsets.only(bottom: 15),
//             padding: const EdgeInsets.all(5),
//             color: Colors.black,
//             child: Text(
//               '$price',
//               style: const TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
