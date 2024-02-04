import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/property_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

import 'widget/post_pro.dart';

class MapProperty extends StatefulWidget {
  const MapProperty({super.key});

  @override
  State<MapProperty> createState() => _MapPropertyState();
}

class _MapPropertyState extends State<MapProperty>
    with AutomaticKeepAliveClientMixin {
  LocationController locationController = Get.find();

  UserController userController = Get.find();
  ProController proController = Get.find();
  late String _mapStyle;

  Set<Marker> markers = {};
  GoogleMapController? controller;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      controller.setMapStyle(_mapStyle);
    });
  }

  Future<void> loadDataAndInitializeMap() async {
    try {
      await proController.mapAllPost();
      addMarker();
      await rootBundle.loadString('assets/map/map_style.txt').then((string) {
        _mapStyle = string;
      });
      // setState(() {});
    } catch (error) {
      print('Error loading data: $error');
    }
  }

  void addMarker() async {
    List<Future> markerTasks = [];

    for (var data in proController.mapProList) {
      Future markerTask = markers.addLabelMarker(
        LabelMarker(
          label: data.price == 0
              ? "Price On Call"
              : "৳ ${userController.currency(data.price)}",
          // label: data.rent.toString(),
          markerId: MarkerId(data.pid.toString()),
          position:
              LatLng(double.parse(data.geolat), double.parse(data.geolon)),
          backgroundColor: Colors.orange,
          // infoWindow: const InfoWindow(title: '1bed,1bath,1kitchen'),
          onTap: () async {
            proController.showMapBoxPro.value = true;
            await proController.mapPostList(data.geolat, data.geolon);
          },
        ),
      );
      markerTasks.add(markerTask);
    }

    await Future.wait(markerTasks);

    setState(() {});
  }

  @override
  void initState() {
    proController.showMapBoxPro(false);
    super.initState();
    loadDataAndInitializeMap();
    // locationController.getCurrnetlanlongLocation(true, 'Property');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          locationController.resetAnimation(false);
        }

        return;
      },
      child: Scaffold(
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Align(
        //     alignment: Alignment.bottomRight,
        //     child: SizedBox(
        //       height: 40,
        //       child: FloatingActionButton.extended(
        //         backgroundColor: Colors.blue,
        //         onPressed: () async {
        //           // final coords = Coords(
        //           //   double.parse(proController.singlepost.geolat),
        //           //   double.parse(proController.singlepost.geolon),
        //           // );
        //           // var title =
        //           //     "Price ৳ ${NumberFormat.decimalPattern().format(proController.singlepost.price)}";
        //           // final availableMaps = await MapLauncher.installedMaps;
        //           // print(availableMaps.length);
        //           // if (availableMaps.length == 1) {
        //           //   await availableMaps.first.showMarker(
        //           //     coords: coords,
        //           //     title: title,
        //           //     description: "description",
        //           //   );
        //           // } else {
        //           //   Get.bottomSheet(
        //           //     SafeArea(
        //           //       child: SingleChildScrollView(
        //           //         child: Wrap(
        //           //           children: <Widget>[
        //           //             for (var map in availableMaps)
        //           //               ListTile(
        //           //                 onTap: () => map.showMarker(
        //           //                   coords: coords,
        //           //                   title: title,
        //           //                 ),
        //           //                 title: Text(map.mapName),
        //           //                 leading: SvgPicture.asset(
        //           //                   map.icon,
        //           //                   height: 30.0,
        //           //                   width: 30.0,
        //           //                 ),
        //           //               ),
        //           //           ],
        //           //         ),
        //           //       ),
        //           //     ),
        //           //   );
        //           // }
        //         },
        //         shape: RoundedRectangleBorder(
        //           // side: const BorderSide(
        //           //     width: 3,
        //           //     color: Colors.brown),
        //           borderRadius: BorderRadius.circular(
        //             100,
        //           ),
        //         ),
        //         label: const Row(
        //           children: [
        //             Text(
        //               'Map',
        //               style: TextStyle(
        //                 fontSize: 14,
        //                 color: Colors.white,
        //               ),
        //             ),
        //             SizedBox(width: 10),
        //             Icon(
        //               Feather.navigation,
        //               color: Colors.white,
        //               size: 18,
        //             ),
        //           ],
        //         ),
        //         elevation: 0,
        //       ),
        //     ),
        //   ),
        // ),
        body: Obx(
          () => proController.mapLoding.value
              ? const MapLodingShimmer()
              : Stack(
                  children: [
                    GoogleMap(
                      mapToolbarEnabled: false,
                      tiltGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      gestureRecognizers: <Factory<
                          OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                      zoomGesturesEnabled: true,
                      // mapType: MapType.normal,
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
                    proController.showMapBoxPro.value
                        ? InkWell(
                            onTap: () {
                              proController.showMapBoxPro.value =
                                  !proController.showMapBoxPro.value;
                            },
                            child: proController.mapAllPostLoding.value
                                ? const MultiMapShimmer()
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 40,
                                      ),
                                      child: CarouselSlider.builder(
                                        options: CarouselOptions(
                                          height: 120,
                                          autoPlay: false,
                                          enlargeCenterPage: true,
                                          enableInfiniteScroll: false,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 900),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                        ),
                                        itemCount:
                                            proController.mapAllPostPro.length,
                                        itemBuilder: (BuildContext context,
                                            int index, int pageViewIndex) {
                                          return PostsProMap(
                                            wid: Get.width,
                                            mar: const EdgeInsets.symmetric(
                                              horizontal: 1.0,
                                            ),
                                            postData: proController
                                                .mapAllPostPro[index],
                                          );
                                        },
                                      ),
                                    ),
                                    // ListView.builder(
                                    //   padding: const EdgeInsets.only(
                                    //     left: 30,
                                    //     right: 10,
                                    //   ),
                                    //   itemCount:
                                    //       proController.mapAllPostPro.length,
                                    //   scrollDirection: Axis.horizontal,
                                    //   // physics: const NeverScrollableScrollPhysics(),
                                    //   itemBuilder:
                                    //       (BuildContext context, int index) {
                                    //     return PostsProMap(
                                    //       postData: proController
                                    //           .mapAllPostPro[index],
                                    //     );
                                    //   },
                                    // ),
                                  ),
                          )
                        : const SizedBox(),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
