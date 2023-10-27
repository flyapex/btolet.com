import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/pages/toletpage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:get/get.dart';

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

  Future<void> loadDataAndInitializeMap() async {
    try {
      await locationController.mapApi();
      addMarker();
      rootBundle.loadString('assets/map/map_style.txt').then((string) {
        _mapStyle = string;
      });
      // setState(() {});
    } catch (error) {
      print('Error loading data: $error');
    }
  }

  late int postId;
  void addMarker() async {
    List<Future> markerTasks = [];

    for (var data in locationController.mapToletList) {
      Future markerTask = markers.addLabelMarker(
        LabelMarker(
          label: data.rent.toString(),
          markerId: MarkerId(data.postId.toString()),
          position:
              LatLng(double.parse(data.geolat), double.parse(data.geolon)),
          backgroundColor: Colors.blue,
          // infoWindow: const InfoWindow(title: '1bed,1bath,1kitchen'),
          onTap: () {
            postId = data.postId;
            locationController.showMapBoxTolet.value = true;
          },
        ),
      );
      markerTasks.add(markerTask);
    }

    await Future.wait(markerTasks);

    setState(() {});
  }

  // void setCustomeMarker() async {
  //   mapMarker = await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(),
  //     'assets/logo/pin.png',
  //   );
  // }

  @override
  void initState() {
    super.initState();
    loadDataAndInitializeMap();
    // rootBundle.loadString('assets/map/map_style.txt').then((string) {
    //   _mapStyle = string;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => locationController.mapLoding.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  GoogleMap(
                    mapToolbarEnabled: false,
                    tiltGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    zoomGesturesEnabled: true,
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
                  locationController.showMapBoxTolet.value
                      ? InkWell(
                          onTap: () {
                            locationController.showMapBoxTolet.value =
                                !locationController.showMapBoxTolet.value;
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: MapBoxTolet(postId: postId),
                                );
                              },
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
      ),
    );
  }
}

class MapBoxTolet extends StatelessWidget {
  final int postId;
  const MapBoxTolet({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              Get.to(ToletPage(
                postid: postId,
              ));
            },
            child: Container(
              height: 100,
              width: Get.width / 1.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 130,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1554995207-c18c203602cb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "৳ 2,000",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xff083437),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset(
                                    'assets/icons/bed.svg',
                                    colorFilter: const ColorFilter.mode(
                                      // Color(0xff083437),
                                      Colors.black87,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "  2 ",
                                  style: TextStyle(
                                    color: Color(0xff083437),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: SvgPicture.asset(
                                    'assets/icons/bath.svg',
                                    colorFilter: const ColorFilter.mode(
                                      // Color(0xff083437),
                                      Colors.black87,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "  2  ",
                                  style: TextStyle(
                                    color: Color(0xff083437),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: SvgPicture.asset(
                                    'assets/icons/size.svg',
                                    colorFilter: const ColorFilter.mode(
                                      // Color(0xff083437),
                                      Colors.black87,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "  2,450 ft\u00b2",
                                  style: TextStyle(
                                    color: Color(0xff083437),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Nirala Khulna',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
