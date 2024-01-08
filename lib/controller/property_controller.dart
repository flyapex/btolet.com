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

  Future getCurrentPostCount(location) async {
    try {
      currentPostCountLoding(true);
      var data = await ApiServicePro.postCountArea(location);
      if (data != null) {
        currentPostCount.value = data;
        currentPostCountLoding(false); //false
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

  var singlePostloding = true.obs;
  late SinglePostModel singlepost;
  getSinglePost(postid) async {
    imageList.clear();
    singlePostloding(true);
    try {
      var response = await ApiServicePro.getSinglePost(postid);
      if (response != null) {
        singlepost = response;
        getImageList();
        return true;
      } else {
        return false;
      }
    } finally {
      singlePostloding(false);
    }
  }

  var imageList = [].obs;
  getImageList() {
    if (singlepost.image1 != '') {
      imageList.add(singlepost.image1);
    }
    if (singlepost.image2 != '') {
      imageList.add(singlepost.image2);
    }
    if (singlepost.image3 != '') {
      imageList.add(singlepost.image3);
    }
    if (singlepost.image4 != '') {
      imageList.add(singlepost.image4);
    }
    if (singlepost.image5 != '') {
      imageList.add(singlepost.image5);
    }
    if (singlepost.image6 != '') {
      imageList.add(singlepost.image6);
    }
    if (singlepost.image7 != '') {
      imageList.add(singlepost.image7);
    }
    if (singlepost.image8 != '') {
      imageList.add(singlepost.image8);
    }
    if (singlepost.image9 != '') {
      imageList.add(singlepost.image9);
    }
    if (singlepost.image10 != '') {
      imageList.add(singlepost.image10);
    }
    if (singlepost.image11 != '') {
      imageList.add(singlepost.image11);
    }
    if (singlepost.image12 != '') {
      imageList.add(singlepost.image12);
    }
    return imageList;
  }

//*----------------------Post
  var pageController = PageController();
  late DateTime sellFrom = DateTime(DateTime.now().year, DateTime.now().month);

  List<HLPickerItem> selectedImageProFloorplan = [];
  List<HLPickerItem> selectedImagePro = [];

  var fasalitis = {
    'Balcony': FasalitisModel(state: false.obs, icon: Icons.balcony_rounded),
    'Parking': FasalitisModel(state: false.obs, icon: Icons.directions_bike),
    'CCTV': FasalitisModel(state: false.obs, icon: Icons.photo_camera),
    'GAS': FasalitisModel(
        state: false.obs, icon: Icons.local_fire_department_outlined),
    'Elevator': FasalitisModel(state: false.obs, icon: Icons.elevator_outlined),
    'Security Guard':
        FasalitisModel(state: false.obs, icon: Icons.security_rounded),
    'Power Backup': FasalitisModel(
        state: false.obs, icon: Icons.power_settings_new_rounded),
    'Fire Alarm':
        FasalitisModel(state: false.obs, icon: Icons.fire_extinguisher),
    'Drain':
        FasalitisModel(state: false.obs, icon: Icons.turn_sharp_right_sharp),
    'Giser': FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Wasa Connection':
        FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Fire exit': FasalitisModel(state: false.obs, icon: Icons.exit_to_app),
    "West Disposal":
        FasalitisModel(state: false.obs, icon: Icons.fire_truck_sharp),
    "Garden": FasalitisModel(state: false.obs, icon: Icons.grass_rounded),
  };
  var fasalitis2 = {
    'Electricity':
        FasalitisModel(state: false.obs, icon: Icons.power_settings_new),
  };

  String getFasalities() {
    final selectedCategories = fasalitis.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    String jsonStringArray = jsonEncode(selectedCategories);
    return jsonStringArray;
  }

  String getFasalities2() {
    final selectedCategories = fasalitis2.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    String jsonStringArray = jsonEncode(selectedCategories);
    return jsonStringArray;
  }

  var selectedCategory = category[0].obs;
  var selectedType = type[0].obs;
  var selectedPriceType = priceType[0].obs;

  var selectedRooms = bed[0].obs;
  var selectedBath = bath[0].obs;

  var selectedLandTypes = ['Residential'].obs;
  var selectedPostedBy = 'Owner'.obs;

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

  final dining = 'select'.obs;
  final kitchen = 'select'.obs;
  final facing = 'select'.obs;
  final area = 'শতাংশ'.obs;

  String getCategoryValue(CategoryPro category) {
    switch (category) {
      case CategoryPro.dining:
        return dining.value;
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
      case CategoryPro.dining:
        dining.value = value;
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

  var diningFlag = false.obs;
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
  var areaFlag = false.obs;
  var mesurementFlag = false.obs;
  var rodeSizeFlag = false.obs;

  var postedByFlag = false.obs;
  var allFlag = false.obs;

  void animateToPage(val) {
    pageController.animateToPage(
      val,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
  }

  animateToEnd(val) {
    pageController
        .animateToPage(
      val,
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
  flagCheck() {
    if (selectedCategory.value == category[0] ||
        selectedCategory.value == category[1]) {
      protypeFlag(true);
      areaFlag(true);
      rodeSizeFlag(true);

      if (selectedPriceType.value == priceType[1]) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }

      if (dining.value != "select") {
        diningFlag.value = true;
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
      if (totalUnit.text.isNotEmpty) {
        totalUnitFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (totalSize.text.isNotEmpty) {
        totalsizeFlag.value = true;
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
      if (price.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }

      if (selectedImagePro.isNotEmpty) {
        imageFlag.value = true;
      } else {
        if (diningFlag.value == true &&
            kitchenFlag.value &&
            totalSize.text.isEmpty) {
          animateToEnd(0);
        }
      }
      // if (selectedPostedBy.isNotEmpty) {
      //   postedByFlag.value = true;
      // } else {
      //   animateToEnd(1);
      // }

      // if (diningFlag.value &&
      //     kitchenFlag.value &&
      //     facingFlag.value &&
      //     totalUnitFlag.value &&
      //     totalsizeFlag.value &&
      //     totalfloorFlag.value &&
      //     floornumberFlag.value &&
      //     priceFlag.value &&
      //     imageFlag.value &&
      //     userController.phoneFlag.value) {
      //   allFlag.value = true;
      // }
      if ([
        diningFlag,
        kitchenFlag,
        facingFlag,
        totalUnitFlag,
        totalsizeFlag,
        totalfloorFlag,
        floornumberFlag,
        priceFlag,
        imageFlag,
        userController.phoneFlag,
      ].every((flag) => flag.value)) {
        allFlag.value = true;
      }
    } else {
      diningFlag(true);
      kitchenFlag(true);
      facingFlag(true);
      totalfloorFlag(true);
      floornumberFlag(true);
      totalsizeFlag(true);
      totalUnitFlag(true);
      floornumberFlag(true);

      if (selectedPriceType.value == priceType[1]) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }

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
      if (price.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImagePro.isNotEmpty) {
        imageFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (userController.phonenumber.text != "" ||
          userController.wappnumber.text != "") {
        userController.phoneFlag.value = true;
      } else {
        // animateToPage(1);
      }

      if (rodeSizeFlag.value &&
          mesurementFlag.value &&
          priceFlag.value &&
          userController.phoneFlag.value &&
          imageFlag.value) {
        allFlag.value = true;
      }
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
            dining: dining.value == "select" ? "" : dining.value,
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
            shortaddress: userController.shortAddress.text,
            description: userController.description.text,
            ownertype: selectedPostedBy.value,
            geolat: locationController.currentlatitude.value.toString(),
            geolon: locationController.currentlongitude.value.toString(),
            phone: userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.phonenumber.text,
            landType: '',
            area: '',
            measurement: '',
            roadSize: '',
          ),
        );
      } else {
        response = await ApiServicePro.newPost(
          NewPostPro(
            uid: dbController.getUserID(),
            category: selectedCategory.value,
            name: '',
            procondition: '',
            bed: '',
            bath: '',
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
            shortaddress: userController.shortAddress.text,
            description: userController.description.text,
            ownertype: selectedPostedBy.value,
            geolat: locationController.currentlatitude.value.toString(),
            geolon: locationController.currentlongitude.value.toString(),
            phone: userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.phonenumber.text,
            landType: "",
            area: area.value,
            measurement: mesurement.text,
            roadSize: roadSize.text,
          ),
        );
      }
      if (response != null) {
        // updateProfile();
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

  var rentmin = 100000.obs;
  var rentmax = 10000000.obs;

  String getSort(mainList) {
    String jsonStringArray = jsonEncode(mainList
        .map((element) => element is String ? element : element.toString())
        .toList());

    return mainList.isEmpty ? '' : jsonStringArray;
  }

  var categoriesSort = {
    'House': false.obs,
    'Flat/Appartment': false.obs,
    'Land': false.obs,
    'Plot': false.obs,
  };
  String getCategorySort() {
    final selectedCategories = categoriesSort.entries
        .where((entry) => entry.value.value)
        .map((entry) => entry.key)
        .toList();

    String jsonStringArray = jsonEncode(selectedCategories);
    return jsonStringArray;
  }

  var fasalitisSort = {
    'Balcony': FasalitisModel(state: false.obs, icon: Icons.balcony_rounded),
    'Parking': FasalitisModel(state: false.obs, icon: Icons.directions_bike),
    'CCTV': FasalitisModel(state: false.obs, icon: Icons.photo_camera),
    'GAS': FasalitisModel(
        state: false.obs, icon: Icons.local_fire_department_outlined),
    'Elevator': FasalitisModel(state: false.obs, icon: Icons.elevator_outlined),
    'Security Guard':
        FasalitisModel(state: false.obs, icon: Icons.security_rounded),
    'Power Backup': FasalitisModel(
        state: false.obs, icon: Icons.power_settings_new_rounded),
    'Fire Alarm':
        FasalitisModel(state: false.obs, icon: Icons.fire_extinguisher),
    'Drain':
        FasalitisModel(state: false.obs, icon: Icons.turn_sharp_right_sharp),
    'Giser': FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Wasa Connection':
        FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    "Garden": FasalitisModel(state: false.obs, icon: Icons.grass_rounded),
    'Fire exit': FasalitisModel(state: false.obs, icon: Icons.exit_to_app),
    "West Disposal":
        FasalitisModel(state: false.obs, icon: Icons.fire_truck_sharp),
    'Electricity':
        FasalitisModel(state: false.obs, icon: Icons.power_settings_new),
  };

  String getFasalitiesSort() {
    final selectedCategories = fasalitis.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    String jsonStringArray = jsonEncode(selectedCategories);
    return jsonStringArray;
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
}
