import 'package:btolet/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:vibration/vibration.dart';

class LocationSheet extends StatefulWidget {
  const LocationSheet({
    super.key,
  });

  @override
  State<LocationSheet> createState() => _LocationSheetState();
}

class _LocationSheetState extends State<LocationSheet> {
  double latitude = 0;
  double longitude = 0;
  LocationController locationController = Get.put(LocationController());
  bool rippleAnimation = true;
  late String _mapStyle;

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(_mapStyle);
    locationController.mapController = controller;
  }

  // openSearchSheet() async {
  //   await Get.bottomSheet(
  //     const LocationSheetMap(),
  //     elevation: 20.0,
  //     enableDrag: true,
  //     backgroundColor: Colors.white,
  //     isScrollControlled: true,
  //     ignoreSafeArea: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20.0),
  //         topRight: Radius.circular(20.0),
  //       ),
  //     ),
  //     enterBottomSheetDuration: const Duration(milliseconds: 170),
  //   );
  // }

  @override
  void initState() {
    rootBundle.loadString('assets/map/map_style.txt').then((string) {
      _mapStyle = string;
    });

    super.initState();
    locationController.getCurrnetlanlongLocation();
  }

  @override
  Widget build(BuildContext context) {
    var htt = Get.height;

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.small(
            heroTag: 'topBtn',
            elevation: 0,
            // backgroundColor: const Color(0xff0166EE),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            onPressed: () {
              Get.back();
            },
            child: const Icon(
              Feather.arrow_left,
              color: Color(0xff0166EE),
            ),
          ),
        ),
        body: locationController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        locationController.currentlatitude.value,
                        locationController.currentlongitude.value,
                      ),
                      // zoom: 8.0,
                      zoom: 16.0,
                    ),
                    onTap: (x) {},
                    onCameraIdle: () {
                      if (latitude != 0) {
                        Vibration.vibrate(pattern: [10, 30, 10]);
                        locationController.coordinateToLocationDetails(
                          latitude,
                          longitude,
                        );
                      }
                      setState(() {
                        rippleAnimation = true;
                      });
                    },
                    onCameraMoveStarted: () {},
                    onCameraMove: (position) {
                      setState(() {
                        latitude = position.target.latitude;
                        longitude = position.target.longitude;
                        rippleAnimation = false;
                      });
                    },
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          height: 40,
                          width: 40,
                          child: Image.asset('assets/map/pin.png'),
                        ),
                      ),
                      rippleAnimation
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: RippleAnimation(
                                  color: Colors.black.withOpacity(0.01),
                                  repeat: false,
                                  minRadius: 40,
                                  ripplesCount: 3,
                                  duration: const Duration(milliseconds: 1400),
                                  child: const SizedBox(),
                                ),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // openSearchSheet();
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: htt / 5.4,
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 8,
                          bottom: 10,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Container(
                            //   height: 4,
                            //   width: 40,
                            //   decoration: BoxDecoration(
                            //     color: Colors.black.withOpacity(0.4),
                            //     borderRadius: BorderRadius.circular(10),
                            //   ),
                            // ),
                            const SizedBox(height: 8),
                            Material(
                              elevation: 0.0,
                              shadowColor: Colors.black.withOpacity(0.3),
                              child: Container(
                                height: (htt / 6) / 3,
                                decoration: BoxDecoration(
                                  color: const Color(0xffECECEC),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(width: 18),
                                    Icon(
                                      Feather.search,
                                      color: Colors.black.withOpacity(0.5),
                                      size: 25,
                                    ),
                                    const SizedBox(width: 18),
                                    SizedBox(
                                      width: (Get.width - 100),
                                      child: Text(
                                        locationController
                                            .locationAddress.value,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.4),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      locationController
                                          .onMyLocationButtonPressed();
                                    },
                                    icon: const Icon(
                                      Icons.share_location_outlined,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    label: const Text(
                                      'Use My Current Location',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(
                                        double.infinity,
                                        htt / 17,
                                      ),
                                      backgroundColor: Colors.red,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: htt / 17,
                                  // width: 50,
                                  padding:
                                      const EdgeInsets.only(left: 1, right: 1),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffE7E8EC),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // locationController
                                      //       .locationAddress.value=
                                      // locationController.locationAddress.value
                                      Get.back();
                                    },
                                    icon: Icon(
                                      Feather.check,
                                      color: Colors.black.withOpacity(0.5),
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: htt / 5, right: 12),
                      child: SizedBox(
                        width: 53,
                        height: 53,
                        child: FittedBox(
                          child: FloatingActionButton(
                            backgroundColor: const Color(0xff0166EE),
                            onPressed: () {},
                            child: const Icon(
                              Feather.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class LocationSheetMap extends StatefulWidget {
  const LocationSheetMap({
    super.key,
  });

  @override
  State<LocationSheetMap> createState() => _LocationSheetMapState();
}

class _LocationSheetMapState extends State<LocationSheetMap> {
  LocationController locationController = Get.put(LocationController());
  bool focus = false;
  FocusNode focusNode = FocusNode();
  bool iconColor = false;

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // locationController.searchSuggstion();
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var htt = Get.height;
    return Obx(
      () => GestureDetector(
        onTap: () {
          // focusNode.unfocus();
        },
        child: SingleChildScrollView(
          // controller: scrollController,
          child: Container(
            height: focus
                ? (htt / 1.3) - MediaQuery.of(context).viewInsets.bottom
                : (htt / 1.3),
            width: Get.width,
            padding: const EdgeInsets.only(left: 20, right: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(top: 10, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: htt / 17,
                        child: Form(
                          child: Material(
                            color: const Color(0xffECECEC),
                            borderRadius: BorderRadius.circular(6),
                            // elevation: 1.0,
                            // shadowColor: const Color(0xffECECEC),
                            child: Focus(
                              onFocusChange: (value) {
                                setState(() {
                                  focus = value;
                                });
                                if (focus) {
                                  // locationController.searchSuggstion();
                                }
                              },
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  textSelectionTheme: TextSelectionThemeData(
                                    selectionColor:
                                        Colors.black.withOpacity(0.2),
                                    selectionHandleColor: Colors.red,
                                  ),
                                ),
                                child: TextFormField(
                                  controller:
                                      locationController.searchController,
                                  onChanged: (value) async {
                                    // locationController.suggstions.clear();

                                    // locationController.searchText.value = value;
                                    // locationController.searchSuggstion();
                                  },
                                  onEditingComplete: () {
                                    //  locationController.suggstions.clear();
                                  },
                                  onFieldSubmitted: (value) {
                                    // locationController.searchSuggstion();
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Nirala, Khulna, Bangladesh',
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    isDense: true,
                                    prefixIcon: const Icon(
                                      Feather.search,
                                      // color: Colors.black.withOpacity(0.6),
                                      // prefixIconColor: Color(0xff374957),
                                      size: 25,
                                    ),

                                    // suffixIcon: Icon(
                                    //   Icons.search,
                                    //   color: Colors.black.withOpacity(0.2),
                                    //   size: 24,
                                    // ),
                                  ),
                                  focusNode: focusNode,
                                  cursorHeight: 22,
                                  cursorWidth: 1.8,
                                  cursorRadius: const Radius.circular(10),
                                  textInputAction: TextInputAction.search,
                                  keyboardType: TextInputType.streetAddress,
                                  maxLines: 1,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          locationController.onMyLocationButtonPressed();
                        },
                        icon: const Icon(Icons.near_me),
                        label: const Text('Use My Current Location'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            double.infinity,
                            htt / 17,
                          ),
                          backgroundColor: Colors.red,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocationListTail extends StatelessWidget {
  const LocationListTail({
    super.key,
    required this.location,
    required this.press,
  });
  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          horizontalTitleGap: 0,
          leading: const Icon(
            Icons.near_me,
            color: Colors.red,
          ),
          title: Text(
            location,
            style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w400),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Colors.black.withOpacity(0.05),
        )
      ],
    );
  }
}
