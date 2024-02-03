import 'package:btolet/view/map/widget/post_tolet.dart';
import 'package:btolet/view/shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/tolet_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:label_marker/label_marker.dart';

class MapTolet extends StatefulWidget {
  const MapTolet({super.key});

  @override
  State<MapTolet> createState() => _MapToletState();
}

class _MapToletState extends State<MapTolet>
    with AutomaticKeepAliveClientMixin {
  LocationController locationController = Get.find();

  ToletController toletController = Get.find();
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
      await toletController.mapAllPost();
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

    for (var data in toletController.mapToletList) {
      Future markerTask = markers.addLabelMarker(
        LabelMarker(
          label: "৳ ${NumberFormat.decimalPattern().format(data.rent)}",
          // label: data.rent.toString(),
          markerId: MarkerId(data.postId.toString()),
          position:
              LatLng(double.parse(data.geolat), double.parse(data.geolon)),
          backgroundColor: Colors.blue,
          // infoWindow: const InfoWindow(title: '1bed,1bath,1kitchen'),
          onTap: () async {
            toletController.showMapBoxTolet.value = true;
            await toletController.mapPostList(data.geolat, data.geolon);
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
    toletController.showMapBoxTolet(false);
    super.initState();
    loadDataAndInitializeMap();
    // locationController.getCurrnetlanlongLocation(true, 'Tolet');
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
        body: Obx(
          () => toletController.mapLoding.value
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
                    // toletController.showMapBoxTolet.value
                    //     ? InkWell(
                    //         onTap: () {
                    //           toletController.showMapBoxTolet.value =
                    //               !toletController.showMapBoxTolet.value;
                    //         },
                    //         child: toletController.mapPostLoding.value
                    //             ? const MultiMapShimmer()
                    //             : Align(
                    //                 alignment: Alignment.bottomCenter,
                    //                 child: ListView.builder(
                    //                   padding: const EdgeInsets.only(
                    //                     left: 30,
                    //                     right: 10,
                    //                   ),
                    //                   itemCount: toletController
                    //                       .mapPostToletList.length,
                    //                   scrollDirection: Axis.horizontal,
                    //                   // physics: const NeverScrollableScrollPhysics(),
                    //                   itemBuilder:
                    //                       (BuildContext context, int index) {
                    //                     return PostsToletMap(
                    //                       postData: toletController
                    //                           .mapPostToletList[index],
                    //                     );
                    //                   },
                    //                 ),
                    //               ),
                    //       )
                    //     : const SizedBox(),
                    toletController.showMapBoxTolet.value
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                toletController.showMapBoxTolet.value =
                                    !toletController.showMapBoxTolet.value;
                              },
                              child: toletController.mapPostLoding.value
                                  ? const MultiMapShimmer()
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 40,
                                      ),
                                      child: CarouselSlider.builder(
                                        options: CarouselOptions(
                                          height: 120,
                                          autoPlay: false,
                                          enlargeCenterPage: true,
                                          enableInfiniteScroll: true,
                                          autoPlayInterval:
                                              const Duration(seconds: 3),
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 900),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                        ),
                                        itemCount: toletController
                                            .mapPostToletList.length,
                                        itemBuilder: (BuildContext context,
                                            int index, int pageViewIndex) {
                                          return PostsToletMap(
                                            wid: Get.width,
                                            mar: const EdgeInsets.symmetric(
                                              horizontal: 1.0,
                                            ),
                                            postData: toletController
                                                .mapPostToletList[index],
                                          );
                                        },
                                      ),
                                    ),
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
