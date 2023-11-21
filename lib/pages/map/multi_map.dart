import 'dart:convert';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/apimodel.dart';
import 'package:btolet/pages/toletpage.dart';
import 'package:btolet/widget/shimmer/shimmer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:label_marker/label_marker.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;

class MultiMap extends StatefulWidget {
  const MultiMap({super.key});

  @override
  State<MultiMap> createState() => _MultiMapState();
}

class _MultiMapState extends State<MultiMap> {
  LocationController locationController = Get.put(LocationController());
  late String _mapStyle;
  // late BitmapDescriptor mapMarker;

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

  void addMarker() async {
    List<Future> markerTasks = [];

    for (var data in locationController.mapToletList) {
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
            locationController.showMapBoxTolet.value = true;
            await locationController.mapPostApi(data.geolat, data.geolon);
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
    super.initState();
    loadDataAndInitializeMap();
    // rootBundle.loadString('assets/map/map_style.txt').then((string) {
    //   _mapStyle = string;
    // });
  }

  Future<bool> _onWillPop() async {
    locationController.mapMode.value = !locationController.mapMode.value;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Obx(
          () => locationController.mapLoding.value
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
                    locationController.showMapBoxTolet.value
                        ? InkWell(
                            onTap: () {
                              locationController.showMapBoxTolet.value =
                                  !locationController.showMapBoxTolet.value;
                            },
                            child: locationController.mapPostLoding.value
                                ? const MultiMapShimmer()
                                : Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ListView.builder(
                                      itemCount: locationController
                                          .mapPostToletList.length,
                                      scrollDirection: Axis.horizontal,
                                      // physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            left: index == 0 ? 40 : 28,
                                            right: index == 2 ? 40 : 0,
                                          ),
                                          child: MapBoxTolet(
                                            data: locationController
                                                .mapPostToletList[index],
                                          ),
                                        );
                                      },
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
}

class MapBoxTolet extends StatelessWidget {
  final MapPostTolet data;
  const MapBoxTolet({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    getDay() {
      String myString = timeago.format(data.time, locale: 'en_short');

      if (myString.contains("~")) {
        myString = myString.replaceAll("~", "");
        return myString;
      } else {
        return myString;
      }
    }

    UserController userController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              Get.to(
                ToletPage(
                  postid: data.postId,
                ),
              );
            },
            child: Container(
              height: 100,
              width: 300,
              // margin: const EdgeInsets.only(left: 10,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, spreadRadius: 1.1),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        image: DecorationImage(
                          image: MemoryImage(
                            base64Decode(
                              data.image1,
                            ),
                          ),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "৳ ${NumberFormat.decimalPattern().format(data.rent)}",
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Color(0xff083437),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              LikeButton(
                                size: 22,
                                isLiked: false,
                                mainAxisAlignment: MainAxisAlignment.end,
                                circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc),
                                ),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Color(0xff33b5e5),
                                  dotSecondaryColor: Color(0xff0099cc),
                                ),
                                // likeCount: 665,
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: isLiked
                                        ? Colors.blue.withOpacity(0.9)
                                        : Colors.grey,
                                  );
                                },
                                animationDuration:
                                    const Duration(milliseconds: 400),
                                onTap: (isLiked) async {
                                  print(!isLiked);
                                  userController.savedFavPostTolet(
                                    data.postId,
                                    !isLiked,
                                  );
                                  return !isLiked;
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Text(
                                    "  ${data.bath} ",
                                    style: const TextStyle(
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
                                  Text(
                                    "  ${data.bath}  ",
                                    style: const TextStyle(
                                      color: Color(0xff083437),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              data.roomsize == ''
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          height: 12,
                                          width: 12,
                                          child: SvgPicture.asset(
                                            'assets/icons/property/kitchen.svg',
                                            colorFilter: const ColorFilter.mode(
                                              // Color(0xff083437),
                                              Colors.black87,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "  ${data.kitchen}",
                                          style: const TextStyle(
                                            color: Color(0xff083437),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
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
                                        Text(
                                          "  ${NumberFormat.decimalPattern().format(int.parse(data.roomsize))} ft\u00b2",
                                          style: const TextStyle(
                                            color: Color(0xff083437),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                              const SizedBox(height: 20),
                              const SizedBox(height: 20),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.location,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                '${getDay()} ago',
                                style: TextStyle(
                                  color:
                                      const Color(0xff083437).withOpacity(0.3),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 0),
                        ],
                      ),
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
