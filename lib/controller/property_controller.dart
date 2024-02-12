import 'dart:convert';
import 'package:btolet/api/api_property.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/model/pro_model.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';
import 'db_controller.dart';
import 'location_controller.dart';
import 'user_controller.dart';

class ProController extends GetxController {
  final refreshkey = GlobalKey<CustomRefreshIndicatorState>();

  var currentPostCount = 999.obs;
  var currentPostCountLoding = true.obs;

  Future getCurrentPostCount() async {
    try {
      currentPostCountLoding(true);

      var data = await ApiServicePro.postCountArea(
          locationController.locationAddressShort.split(',')[0],
          locationController.locationAddressShort.split(',')[1]);
      if (data != null) {
        currentPostCount.value = data;
        currentPostCountLoding(false);
      }
    } finally {}
  }

  LocationController locationController = Get.find();
  var page = 1.obs;
  var lodingPosts = true.obs;
  var allPost = [].obs;

  void getAllPost() async {
    lodingPosts(true);
    try {
      var response = await ApiServicePro.getPost(
        page.value,
        locationController.currentlatitude,
        locationController.currentlongitude,
      );

      if (response != null) {
        allPost.addAll(response);
        print(allPost.length);
        if (response.isEmpty || response.length < 4) {
          lodingPosts(false);
        }
        page = page + 1;
      }
    } finally {}
  }

  var singlePostNull = false.obs;
  var singlePostloding = true.obs;
  getSinglePost(postid) async {
    // print("get Data");
    singlePostNull(false);
    singlePostloding(true);
    try {
      var response = await ApiServicePro.getSinglePost(postid);
      if (response != null) {
        return response;
      } else {
        singlePostNull(true);
        return null;
      }
    } finally {
      singlePostloding(false);
    }
  }

  // var imageList = [].obs;
  // getImageList() {
  //   if (singlepost.image1 != '') {
  //     imageList.add(singlepost.image1);
  //   }
  //   if (singlepost.image2 != '') {
  //     imageList.add(singlepost.image2);
  //   }
  //   if (singlepost.image3 != '') {
  //     imageList.add(singlepost.image3);
  //   }
  //   if (singlepost.image4 != '') {
  //     imageList.add(singlepost.image4);
  //   }
  //   if (singlepost.image5 != '') {
  //     imageList.add(singlepost.image5);
  //   }
  //   if (singlepost.image6 != '') {
  //     imageList.add(singlepost.image6);
  //   }
  //   if (singlepost.image7 != '') {
  //     imageList.add(singlepost.image7);
  //   }
  //   if (singlepost.image8 != '') {
  //     imageList.add(singlepost.image8);
  //   }
  //   if (singlepost.image9 != '') {
  //     imageList.add(singlepost.image9);
  //   }
  //   if (singlepost.image10 != '') {
  //     imageList.add(singlepost.image10);
  //   }
  //   if (singlepost.image11 != '') {
  //     imageList.add(singlepost.image11);
  //   }
  //   if (singlepost.image12 != '') {
  //     imageList.add(singlepost.image12);
  //   }
  //   return imageList;
  // }
//*---------------------- More Post

  // var lodingmorePosts = true.obs;
  // var morePost = [].obs;
  // var lodeOneTime = true.obs;

  // void getMorePost(postid, category, page, latitude, longitude) async {
  //   lodeOneTime(false);
  //   lodingmorePosts(true);
  //   print(postid);
  //   print(category);
  //   try {
  //     var response = await ApiServicePro.getMorePost(
  //       postid,
  //       category,
  //       page,
  //       latitude,
  //       longitude,
  //     );

  //     if (response != null) {
  //       morePost.addAll(response);
  //       print(morePost.length);
  //       if (response.isEmpty) {
  //         lodingmorePosts(false);
  //       }
  //     }
  //   } finally {
  //     lodingmorePosts(false);
  //   }
  // }

//*----------------------Post
  var pageController = PageController();
  late DateTime sellFrom = DateTime(DateTime.now().year, DateTime.now().month);

  List<HLPickerItem> selectedImageProFloorplan = [];
  List<HLPickerItem> selectedImagePro = [];

  var fasalitis = {
    'Parking': FasalitisModel(state: false.obs, icon: Icons.directions_bike),
    'CCTV': FasalitisModel(state: false.obs, icon: Icons.photo_camera),
    'GAS': FasalitisModel(
        state: false.obs, icon: Icons.local_fire_department_outlined),
    'Giser': FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Elevator': FasalitisModel(state: false.obs, icon: Icons.elevator_outlined),
    'Fire Alarm': FasalitisModel(
        state: false.obs, icon: Icons.fire_extinguisher_outlined),
    'Wasa Connection':
        FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Fire exit': FasalitisModel(state: false.obs, icon: Icons.exit_to_app),
    'Security Guard':
        FasalitisModel(state: false.obs, icon: Icons.security_outlined),
    "Garden": FasalitisModel(state: false.obs, icon: Icons.grass_rounded),
    'Power Backup': FasalitisModel(
        state: false.obs, icon: Icons.power_settings_new_rounded),
    "Waste Disposal":
        FasalitisModel(state: false.obs, icon: Icons.fire_truck_sharp),
    "Earthquake Resistant":
        FasalitisModel(state: false.obs, icon: Icons.verified_user_outlined),
    "Swimming pool": FasalitisModel(state: false.obs, icon: Icons.pool),
    "Telephone": FasalitisModel(state: false.obs, icon: Icons.phone),
    "Water supply": FasalitisModel(state: false.obs, icon: Icons.water),
    "Internet": FasalitisModel(state: false.obs, icon: Icons.wifi),
    "Cable TV": FasalitisModel(state: false.obs, icon: Icons.live_tv_outlined),
  };
  var fasalitis2 = {
    'Electricity':
        FasalitisModel(state: false.obs, icon: Icons.power_settings_new),
    'Drain':
        FasalitisModel(state: false.obs, icon: Icons.turn_sharp_right_sharp),
  };

  getFasalities() {
    final selectedCategories = fasalitis.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    // String jsonStringArray = jsonEncode(selectedCategories);
    return selectedCategories;
  }

  getFasalities2() {
    final selectedCategories = fasalitis2.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    // String jsonStringArray = jsonEncode(selectedCategories);
    return selectedCategories;
  }

  var selectedCategory = category[0].obs;
  var selectedType = type[0].obs;
  var selectedPriceType = priceType[0].obs;
  var selectedEMIType = emi[0].obs;

  var selectedRooms = bed[0].obs;
  var selectedBath = bath[0].obs;
  var selectedDining = diningPro[0].obs;
  var selectedDrawing = drawingPro[0].obs;

  var selectedLandTypes = ['Residential'].obs;
  var selectedPostedBy = 'Owner'.obs;

  String getlandType() {
    final selectedCategories = fasalitis2.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    String jsonStringArray = jsonEncode(selectedCategories);
    return jsonStringArray;
  }

  TextEditingController name = TextEditingController();
  TextEditingController totalFloor = TextEditingController();
  TextEditingController floorNumber = TextEditingController();
  TextEditingController totalUnit = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController totalSize = TextEditingController();
  TextEditingController ytVideo = TextEditingController();

  TextEditingController mesurement = TextEditingController();
  TextEditingController roadSize = TextEditingController();

  final FocusNode namefocusNode = FocusNode();
  final FocusNode totalFloorfocusNode = FocusNode();
  final FocusNode floorNumberfocusNode = FocusNode();
  final FocusNode totalUnitfocusNode = FocusNode();
  final FocusNode totalSizefocusNode = FocusNode();
  final FocusNode pricefocusNode = FocusNode();
  final FocusNode ytVideofocusNode = FocusNode();
  final FocusNode mesurementfocusNode = FocusNode();
  final FocusNode roadSizefocusNode = FocusNode();

  final balcony = 'select'.obs;
  final kitchen = 'select'.obs;
  final facing = 'select'.obs;
  final area = 'শতাংশ'.obs;

  String getCategoryValue(CategoryPro category) {
    switch (category) {
      case CategoryPro.balcony:
        return balcony.value;
      case CategoryPro.kitchen:
        return kitchen.value;
      case CategoryPro.facing:
        return facing.value;
      case CategoryPro.area:
        return area.value;
    }
  }

  void setCategoryValue(CategoryPro category, String value) {
    switch (category) {
      case CategoryPro.balcony:
        balcony.value = value;
        break;
      case CategoryPro.kitchen:
        kitchen.value = value;
        break;
      case CategoryPro.facing:
        facing.value = value;
        break;
      case CategoryPro.area:
        area.value = value;
        break;
      default:
        throw ArgumentError('Invalid category');
    }
  }

  //*----------------------Post Selected Check
  final ScrollController scrollControllerPost = ScrollController();

  var activeFlag = false.obs;

  // var diningFlag = false.obs;
  var balconyFlag = false.obs;
  var kitchenFlag = false.obs;
  var facingFlag = false.obs;
  var totalUnitFlag = false.obs;
  var totalsizeFlag = false.obs;
  var totalfloorFlag = false.obs;
  var floornumberFlag = false.obs;
  var priceFlag = false.obs;
  var imageFlag = false.obs;
  // different category
  var protypeFlag = false.obs;
  // var areaFlag = false.obs;
  var mesurementFlag = false.obs;
  var rodeSizeFlag = false.obs;

  // var postedByFlag = false.obs;
  var allFlag = false.obs;

  resetAllflag() {
    activeFlag(false);
    balconyFlag(false);
    kitchenFlag(false);
    facingFlag(false);
    totalUnitFlag(false);
    totalsizeFlag(false);
    totalfloorFlag(false);
    floornumberFlag(false);
    priceFlag(false);
    imageFlag(false);
    protypeFlag(false);
    // areaFlag(false);
    mesurementFlag(false);
    rodeSizeFlag(false);

    balcony.value = 'select';
    kitchen.value = 'select';
    facing.value = 'select';
    area.value = 'শতাংশ';

    name.clear();
    totalFloor.clear();
    floorNumber.clear();
    totalSize.clear();
    totalUnit.clear();
    price.clear();

    ytVideo.clear();

    mesurement.clear();
    roadSize.clear();

    selectedImageProFloorplan.clear();
    selectedImagePro.clear();
    fasalitis.forEach((key, value) {
      value.state.value = false;
    });
    fasalitis2.forEach((key, value) {
      value.state.value = false;
    });

    allFlag(false);
  }

  void animateToPage(val) {
    pageController.animateToPage(
      val,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
  }

  animateToEnd() {
    pageController
        .animateToPage(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    )
        .then((_) {
      scrollControllerPost.animateTo(
        scrollControllerPost.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  UserController userController = Get.find();

  checkAllCatagory() {
    balconyFlag.value = balcony.value != "select";
    kitchenFlag.value = kitchen.value != "select";
    facingFlag.value = facing.value != "select";
    totalfloorFlag.value = totalFloor.text.isNotEmpty;
    floornumberFlag.value = floorNumber.text.isNotEmpty;
    totalsizeFlag.value = totalSize.text.isNotEmpty;
    totalUnitFlag.value = totalUnit.text.isNotEmpty;
    mesurementFlag.value = mesurement.text.isNotEmpty;
    rodeSizeFlag.value = roadSize.text.isNotEmpty;
    priceFlag.value =
        price.text.isNotEmpty || selectedPriceType.value != priceType[0];
    imageFlag.value = selectedImagePro.isNotEmpty;

    userController.phoneFlag.value =
        userController.phonenumber.text.isNotEmpty ||
            userController.wappnumber.text.isNotEmpty;

    var c = selectedCategory.value;
    if (c == category[0] || c == category[1]) {
      mesurementFlag(true);
      rodeSizeFlag(true);
    } else {
      balconyFlag(true);
      kitchenFlag(true);
      facingFlag(true);
      totalfloorFlag(true);
      floornumberFlag(true);
      totalsizeFlag(true);
      totalUnitFlag(true);
    }
  }

  flagCheck() {
    if (selectedCategory.value == category[0] ||
        selectedCategory.value == category[1]) {
      if (balcony.value != "select") {
        balconyFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (kitchen.value != "select") {
        kitchenFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (facing.value != "select") {
        facingFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (totalFloor.text.isNotEmpty) {
        totalfloorFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (floorNumber.text.isNotEmpty) {
        floornumberFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (totalSize.text.isNotEmpty) {
        totalsizeFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (totalUnit.text.isNotEmpty) {
        totalUnitFlag.value = true;
      } else {
        animateToPage(0);
      }

      if (price.text.isNotEmpty || selectedPriceType.value != priceType[0]) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }

      if (selectedImagePro.isNotEmpty) {
        imageFlag.value = true;
      } else {
        if (balconyFlag.value == true &&
            kitchenFlag.value &&
            facingFlag.value &&
            totalfloorFlag.value &&
            floornumberFlag.value &&
            totalsizeFlag.value &&
            totalUnitFlag.value &&
            priceFlag.value &&
            !imageFlag.value) {
          animateToEnd();
        }
      }
      userController.phoneFlag.value =
          userController.phonenumber.text.isNotEmpty ||
              userController.wappnumber.text.isNotEmpty;

      allFlag.value = balconyFlag.value &&
          kitchenFlag.value &&
          facingFlag.value &&
          totalfloorFlag.value &&
          floornumberFlag.value &&
          totalsizeFlag.value &&
          totalUnitFlag.value &&
          priceFlag.value &&
          imageFlag.value &&
          userController.phoneFlag.value;
    } else {
      if (mesurement.text.isNotEmpty) {
        mesurementFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (roadSize.text.isNotEmpty) {
        rodeSizeFlag.value = true;
      } else {
        animateToPage(0);
      }

      if (price.text.isNotEmpty || selectedPriceType.value != priceType[0]) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImagePro.isNotEmpty) {
        imageFlag.value = true;
      } else {
        animateToPage(0);
      }
      userController.phoneFlag.value =
          userController.phonenumber.text.isNotEmpty ||
              userController.wappnumber.text.isNotEmpty;

      allFlag.value = rodeSizeFlag.value &&
          mesurementFlag.value &&
          priceFlag.value &&
          imageFlag.value &&
          userController.phoneFlag.value;
    }
  }

  //* ---------------------------- New Post
  final DBController dbController = Get.put(DBController());

  newpost() async {
    List<String> imageBase64List = [];

    for (int i = 0; i < 12; i++) {
      if (i < selectedImagePro.length) {
        Uint8List? compressedImage =
            await FlutterImageCompress.compressWithFile(
          selectedImagePro[i].path,
          minHeight: 1200,
          minWidth: 800,
          quality: 20,
          rotate: 0,
        );
        String base64Image = base64Encode(compressedImage!);
        imageBase64List.add(base64Image);
      } else {
        imageBase64List.add("");
      }
    }
    String floorplan = '';
    if (selectedImageProFloorplan.isNotEmpty) {
      Uint8List? compressedImage = await FlutterImageCompress.compressWithFile(
        selectedImageProFloorplan[0].path,
        minHeight: 1200,
        minWidth: 800,
        quality: 20,
        rotate: 0,
      );
      floorplan = base64Encode(compressedImage!);
    }

    // ignore: prefer_typing_uninitialized_variables
    var response;
    try {
      if (selectedCategory.value == category[0] ||
          selectedCategory.value == category[1]) {
        response = await ApiServicePro.newPost(
          NewPostPro(
            uid: dbController.getUserID(),
            category: selectedCategory.value,
            name: name.text,
            procondition: selectedType.value,
            bed: selectedRooms.value,
            bath: selectedBath.value,
            balcony: balcony.value == "select" ? "" : balcony.value,
            drawing: selectedDrawing.value,
            dining: selectedDining.value,
            kitchen: kitchen.value == "select" ? "" : kitchen.value,
            size: totalSize.text,
            sellfrom: sellFrom,
            totalFloor: totalFloor.text,
            floornumber: floorNumber.text,
            facing: facing.value == "select" ? "" : facing.value,
            totalUnit: totalUnit.text,
            price: selectedPriceType.value == priceType[0]
                ? int.parse(price.text.replaceAll(",", ""))
                : 0,
            amenities: getFasalities(),
            floorPlan: floorplan,
            ytVideo: ytVideo.text,
            image1: imageBase64List[0],
            image2: imageBase64List[1],
            image3: imageBase64List[2],
            image4: imageBase64List[3],
            image5: imageBase64List[4],
            image6: imageBase64List[5],
            image7: imageBase64List[6],
            image8: imageBase64List[7],
            image9: imageBase64List[8],
            image10: imageBase64List[9],
            image11: imageBase64List[10],
            image12: imageBase64List[11],
            location: locationController.locationAddressShort.value.toString(),
            locationfull: locationController.locationAddress.value.toString(),
            shortaddress: userController.shortAddress.text,
            description: userController.description.text,
            ownertype: selectedPostedBy.value,
            geolat: locationController.currentlatitude.value.toString(),
            geolon: locationController.currentlongitude.value.toString(),
            phone: userController.codePhone.value +
                userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.codeWapp.value +
                    userController.wappnumber.text,
            landType: [],
            area: '',
            measurement: '',
            roadSize: '',
            emi: selectedEMIType.value,
          ),
        );
      } else {
        response = await ApiServicePro.newPost(
          NewPostPro(
            uid: dbController.getUserID(),
            category: selectedCategory.value,
            name: name.text,
            procondition: '',
            bed: '',
            bath: '',
            balcony: '',
            drawing: '',
            dining: '',
            kitchen: '',
            size: '',
            sellfrom: sellFrom,
            totalFloor: '',
            floornumber: '',
            facing: '',
            totalUnit: '',
            price: selectedPriceType.value == priceType[0]
                ? int.parse(price.text.replaceAll(",", ""))
                : 0,
            amenities: getFasalities2(),
            floorPlan: '',
            ytVideo: ytVideo.text,
            image1: imageBase64List[0],
            image2: imageBase64List[1],
            image3: imageBase64List[2],
            image4: imageBase64List[3],
            image5: imageBase64List[4],
            image6: imageBase64List[5],
            image7: imageBase64List[6],
            image8: imageBase64List[7],
            image9: imageBase64List[8],
            image10: imageBase64List[9],
            image11: imageBase64List[10],
            image12: imageBase64List[11],
            location: locationController.locationAddressShort.value.toString(),
            locationfull: locationController.locationAddress.value.toString(),
            shortaddress: userController.shortAddress.text,
            description: userController.description.text,
            ownertype: selectedPostedBy.value,
            geolat: locationController.currentlatitude.value.toString(),
            geolon: locationController.currentlongitude.value.toString(),
            phone: userController.codePhone.value +
                userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.codeWapp.value +
                    userController.wappnumber.text,
            landType: selectedLandTypes,
            area: area.value,
            measurement: mesurement.text,
            roadSize: roadSize.text,
            emi: selectedEMIType.value,
          ),
        );
      }
      if (response != null) {
        userController.updateProfile();
        return response;
      } else {
        return null;
      }
    } finally {}
  }

  //*----------------- Sort Post
  var bedSort = [].obs;
  var bathSort = [].obs;
  var kitchenSort = [].obs;
  var diningSort = [].obs;

  var priceText = "Any Price".obs;

  var startval1 = 100000.0.obs, endval1 = 10000000.0.obs;

  var rentmin = 100000.obs;
  var rentmax = 10000000.obs;

  TextEditingController pricemin = TextEditingController();
  TextEditingController pricemax = TextEditingController();

  final FocusNode priceminfocusNode = FocusNode();
  final FocusNode pricemaxfocusNode = FocusNode();

  getSort(List<dynamic> mainList) {
    List<String> stringList = mainList
        .map((element) => element is String ? element : element.toString())
        .toList();

    return stringList;
  }

  var categoriesSort = {
    'House': false.obs,
    'Flat': false.obs,
    'Land': false.obs,
    'Plot': false.obs,
  };
  getCategorySort() {
    final selectedCategories = categoriesSort.entries
        .where((entry) => entry.value.value)
        .map((entry) => entry.key)
        .toList();

    // String jsonStringArray = jsonEncode(selectedCategories);
    return selectedCategories;
  }

  var fasalitisSort = {
    'Parking': FasalitisModel(state: false.obs, icon: Icons.directions_bike),
    'CCTV': FasalitisModel(state: false.obs, icon: Icons.photo_camera),
    'GAS': FasalitisModel(
        state: false.obs, icon: Icons.local_fire_department_outlined),
    'Giser': FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Elevator': FasalitisModel(state: false.obs, icon: Icons.elevator_outlined),
    'Fire Alarm': FasalitisModel(
        state: false.obs, icon: Icons.fire_extinguisher_outlined),
    'Wasa Connection':
        FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Fire exit': FasalitisModel(state: false.obs, icon: Icons.exit_to_app),
    'Security Guard':
        FasalitisModel(state: false.obs, icon: Icons.security_outlined),
    "Garden": FasalitisModel(state: false.obs, icon: Icons.grass_rounded),
    'Power Backup': FasalitisModel(
        state: false.obs, icon: Icons.power_settings_new_rounded),
    "Waste Disposal":
        FasalitisModel(state: false.obs, icon: Icons.fire_truck_sharp),
    "Earthquake Resistant":
        FasalitisModel(state: false.obs, icon: Icons.verified_user_outlined),
    "Swimming pool": FasalitisModel(state: false.obs, icon: Icons.pool),
    "Telephone": FasalitisModel(state: false.obs, icon: Icons.phone),
    "Water supply": FasalitisModel(state: false.obs, icon: Icons.water),
    "Internet": FasalitisModel(state: false.obs, icon: Icons.wifi),
    "Cable TV": FasalitisModel(state: false.obs, icon: Icons.live_tv_outlined),
    'Electricity':
        FasalitisModel(state: false.obs, icon: Icons.power_settings_new),
    'Drain':
        FasalitisModel(state: false.obs, icon: Icons.turn_sharp_right_sharp),
  };

  getFasalitiesSort() {
    final selectedCategories = fasalitisSort.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    // String jsonStringArray = jsonEncode(selectedCategories);
    return selectedCategories;
  }

  var totalResult = 0.obs;
  var totalResultloding = false.obs;
  void sortingPostCount() async {
    try {
      totalResultloding(true);

      var response = await ApiServicePro.sortingPostCount(
        SortPostPro(
          geolon: locationController.currentlongitude.value.toString(),
          geolat: locationController.currentlatitude.value.toString(),
          page: 1,
          category: getCategorySort(),
          fasalitis: getFasalitiesSort(),
          rentmin: rentmin.value,
          rentmax: rentmax.value,
          bed: getSort(bedSort),
          bath: getSort(bathSort),
        ),
      );

      if (response != null) {
        totalResult.value = response;
        totalResultloding(false);
      }
    } finally {}
  }

  var sortpage = 1.obs;
  var sortloding = true.obs;
  var allSortedPost = [].obs;
  void sortedPostList() async {
    // print("object");
    sortloding(true);
    try {
      var response = await ApiServicePro.sortingPost(
        SortPostPro(
          geolon: locationController.currentlongitude.value.toString(),
          geolat: locationController.currentlatitude.value.toString(),
          page: sortpage.value,
          category: getCategorySort(),
          fasalitis: getFasalitiesSort(),
          rentmin: rentmin.value,
          rentmax: rentmax.value,
          bed: getSort(bedSort),
          bath: getSort(bathSort),
        ),
      );

      if (response != null) {
        allSortedPost.addAll(response);
        if (response.isEmpty) {
          sortloding(false);
        }
        sortpage = sortpage + 1;
      }
    } finally {}
  }

  //*--------------------------------------Saved
  late TabController tabControllerDrawer;
  final GlobalKey<AnimatedListState> deleteKeySaved = GlobalKey();

  void savePost(int pid, bool status) async {
    try {
      var response = await ApiServicePro.savedPost(
          await dbController.getUserID(), pid, status);
      if (response != null) {
        print(response);
      }
    } finally {}
  }

  var savedPage = 1.obs;
  var savedPostloding = true.obs;
  var allSavedPost = [].obs;
  void getSave() async {
    savedPostloding(true);
    try {
      var response = await ApiServicePro.getSaved(
        await dbController.getUserID(),
        savedPage.value,
      );
      if (response != null) {
        allSavedPost.addAll(response);

        if (response.isEmpty) {
          savedPostloding(false);
        }
        savedPage = savedPage + 1;
      }
    } finally {}
  }

  var mypostPage = 1.obs;
  var mypostPageloding = true.obs;
  var mypostList = [].obs;
  void myPost() async {
    mypostPageloding(true);
    try {
      var response = await ApiServicePro.myPostList(
        await dbController.getUserID(),
        mypostPage.value,
      );
      if (response != null) {
        mypostList.addAll(response);
        if (response.isEmpty) {
          mypostPageloding(false);
        }
        mypostPage = mypostPage + 1;
      }
    } finally {
      // mypostPageloding(false);
    }
  }

  final GlobalKey<AnimatedListState> deleteKeyMypost = GlobalKey();

  void deleteMypost(int postid) async {
    try {
      var response = await ApiServicePro.deletePost(
        await dbController.getUserID(),
        postid,
      );
      if (response != null) {}
    } finally {}
  }

  //*--------------- MAP

  var mapProList = [].obs;
  var mapLoding = true.obs;
  Future mapAllPost() async {
    try {
      mapProList.clear();
      mapLoding(true);
      var response = await ApiServicePro.map();
      if (response != null) {
        mapProList.addAll(response);
        mapLoding(false);
        return response;
      }
    } finally {}
  }

  RxBool showMapBoxPro = false.obs;

  var mapAllPostPro = [].obs;
  var mapAllPostLoding = true.obs;
  Future mapPostList(geolat, geolon) async {
    try {
      mapAllPostPro.clear();
      mapAllPostLoding(true);
      var response = await ApiServicePro.codinateTopost(geolat, geolon);
      if (response != null) {
        mapAllPostPro.addAll(response);
        mapAllPostLoding(false);
        return response;
      }
    } finally {}
  }
}
