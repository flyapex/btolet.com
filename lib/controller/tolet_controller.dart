import 'dart:convert';

import 'package:btolet/api/api_tolet.dart';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/model/tolet_model.dart';
import 'package:btolet/view/post/tolet%20widget/dropdown.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';

import 'db_controller.dart';

class ToletController extends GetxController {
  final refreshkey = GlobalKey<CustomRefreshIndicatorState>();
  var currentPostCount = 999.obs;
  var currentPostCountLoding = true.obs;
  Future getCurrentPostCount(location) async {
    try {
      currentPostCountLoding(true);
      var data = await ApiServiceTolet.postCountArea(location);
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
      var response = await ApiServiceTolet.getPost(
        page.value,
        locationController.currentlatitude,
        locationController.currentlongitude,
      );

      if (response != null) {
        allPost.addAll(response);
        if (response.isEmpty || response.length < 4) {
          lodingPosts(false);
        }
        page = page + 1;
      }
    } finally {}
  }

  var singlePostloding = true.obs;
  late SingleToletPostModel singlepost;
  getSinglePost(postid) async {
    imageList.clear();
    singlePostloding(true);
    try {
      var response = await ApiServiceTolet.getSinglePost(postid);
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

//*---------------------- More Post

  var lodingmorePosts = true.obs;
  var morePost = [].obs;
  var lodeOneTime = true.obs;

  void getMorePost(page, latitude, longitude) async {
    lodeOneTime(false);
    // morePost.clear();
    lodingmorePosts(true);
    try {
      var response = await ApiServiceTolet.getPost(
        page,
        latitude,
        longitude,
      );

      if (response != null) {
        morePost.addAll(response);
        if (response.isEmpty) {
          lodingmorePosts(false);
        }
      }
    } finally {
      lodingmorePosts(false);
    }
  }

//*----------------------Post
  var pageController = PageController();

  late DateTime rentFrom = DateTime(DateTime.now().year, DateTime.now().month);
  TextEditingController nameController = TextEditingController();
  TextEditingController roomSize = TextEditingController();
  TextEditingController maintenance = TextEditingController();
  TextEditingController rent = TextEditingController();

  final FocusNode namefocusNode = FocusNode();
  final FocusNode roomSizefocusNode = FocusNode();
  final FocusNode maintenancefocusNode = FocusNode();
  final FocusNode rentfocusNode = FocusNode();

  List<HLPickerItem> selectedImages = [];
  var categories = {
    'Family': false.obs,
    'Bachelor': false.obs,
    'Male Sit': false.obs,
    'Female Sit': false.obs,
    'Sub-let': false.obs,
    'Hostel': false.obs,
    'Shop': false.obs,
    'Office': false.obs,
    'Only Garage': false.obs,
  };

  String getCategory() {
    final selectedCategories = categories.entries
        .where((entry) => entry.value.value)
        .map((entry) => entry.key)
        .toList();
    String jsonStringArray = jsonEncode(selectedCategories);
    return jsonStringArray;
  }

  var fasalitis = {
    'Balcony': FasalitisModel(state: false.obs, icon: Icons.balcony_rounded),
    'Parking': FasalitisModel(state: false.obs, icon: Icons.directions_bike),
    'CCTV': FasalitisModel(state: false.obs, icon: Icons.photo_camera),
    'GAS': FasalitisModel(
        state: false.obs, icon: Icons.local_fire_department_outlined),
    'Lift': FasalitisModel(state: false.obs, icon: Icons.elevator_outlined),
    'Security Guard':
        FasalitisModel(state: false.obs, icon: Icons.security_rounded),
    'WIFI': FasalitisModel(state: false.obs, icon: Icons.wifi_rounded),
    'Power Backup': FasalitisModel(
        state: false.obs, icon: Icons.power_settings_new_rounded),
    'Giser': FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Fire Alarm':
        FasalitisModel(state: false.obs, icon: Icons.fire_extinguisher),
  };

  String getFasalities() {
    final selectedCategories = fasalitis.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    String jsonStringArray = jsonEncode(selectedCategories);
    return jsonStringArray;
  }

  // Drop Down

  final bedrooms = 'select'.obs;
  final bathrooms = 'select'.obs;
  final dining = 'select'.obs;
  final kitchen = 'select'.obs;
  final floorno = 'select'.obs;
  final facing = 'select'.obs;
  final garage = 'select'.obs;

  String getCategoryValue(Category category) {
    switch (category) {
      case Category.bedrooms:
        return bedrooms.value;
      case Category.bathrooms:
        return bathrooms.value;
      case Category.dining:
        return dining.value;
      case Category.kitchen:
        return kitchen.value;
      case Category.floorno:
        return floorno.value;
      case Category.facing:
        return facing.value;
      case Category.garage:
        return garage.value;
    }
  }

  void setCategoryValue(Category category, String value) {
    switch (category) {
      case Category.bedrooms:
        bedrooms.value = value;
        break;
      case Category.bathrooms:
        bathrooms.value = value;
        break;
      case Category.dining:
        dining.value = value;
        break;
      case Category.kitchen:
        kitchen.value = value;
        break;
      case Category.floorno:
        floorno.value = value;
        break;
      case Category.facing:
        facing.value = value;
        break;
      case Category.garage:
        garage.value = value;
        break;
      default:
        throw ArgumentError('Invalid category');
    }
  }

  //*----------------------Post Selected Check

  UserController userController = Get.find();

  final ScrollController scrollControllerPost = ScrollController();

  var activeFlag = false.obs;

  var categoryFlag = false.obs;
  var bedFlag = false.obs;
  var bathFlag = false.obs;
  var kitchenFlag = false.obs;
  var priceFlag = false.obs;
  var imageFlag = false.obs;
  var floorFlag = false.obs;
  var garageFlag = false.obs;

  var allFlag = false.obs;

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

  flagCheck() {
    if (categories['Only Garage']!.value) {
      print("object");
      categoryFlag.value = true;
      bedFlag.value = true;
      bathFlag.value = true;
      kitchenFlag.value = true;
      floorFlag.value = true;

      if (garage.value != "select") {
        garageFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (rent.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        // animateToPage(0);
        if (garageFlag.value == true && rent.text.isEmpty) {
          animateToEnd();
        }
      }
      if (userController.phonenumber.text != "" ||
          userController.wappnumber.text != "") {
        userController.phoneFlag.value = true; //xxx
      }

      if (garageFlag.value &&
          imageFlag.value &&
          priceFlag.value &&
          userController.phoneFlag.value) {
        allFlag.value = true;
      }
    } else if (categories['Office']!.value && categories['Family']!.value) {
      bedFlag(true);
      bathFlag(true);
      kitchenFlag(true);
      floorFlag(true);
      if (rent.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        // animateToPage(0);
        imageFlag.value = true;
      } else {
        // animateToPage(0);
        animateToEnd();
      }
      if (userController.phonenumber.text != "" ||
          userController.wappnumber.text != "") {
        userController.phoneFlag.value = true; //xxx
      }
      if (priceFlag.value &&
          imageFlag.value &&
          userController.phoneFlag.value) {
        allFlag.value = true;
      }
    } else if (categories['Office']!.value) {
      bedFlag(true);
      bathFlag(true);
      kitchenFlag(true);
      floorFlag(true);
      if (rent.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        if (!rent.text.isNotEmpty) {
          animateToEnd();
        }
      }
      if (userController.phonenumber.text != "" ||
          userController.wappnumber.text != "") {
        userController.phoneFlag.value = true; //xxx
      }
      if (priceFlag.value &&
          imageFlag.value &&
          userController.phoneFlag.value) {
        allFlag.value = true;
      }
    } else if (categories['Shop']!.value) {
      categoryFlag.value = true;
      bedFlag.value = true;
      bathFlag.value = true;
      kitchenFlag.value = true;
      if (floorno.value != "select") {
        floorFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (rent.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }

      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        animateToEnd();
      }
      if (userController.phonenumber.text != "" ||
          userController.wappnumber.text != "") {
        userController.phoneFlag.value = true; //xxx
      }
      if (imageFlag.value &&
          priceFlag.value &&
          userController.phoneFlag.value &&
          floorFlag.value) {
        allFlag.value = true;
      }
    } else {
      floorFlag(true);
      if (categoryFlag.value == false || getCategory().isEmpty) {
        animateToPage(0);
        categoryFlag.value = false;
      } else {
        categoryFlag.value = true;
      }
      if (bedrooms.value != "select") {
        bedFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (bathrooms.value != "select") {
        bathFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (kitchen.value != "select") {
        kitchenFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (rent.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        if ((categoryFlag.value &&
                bedFlag.value &&
                bathFlag.value &&
                kitchenFlag.value) &&
            !priceFlag.value) {
          animateToEnd();
        } else {}
      }
      if (userController.phonenumber.text != "" ||
          userController.wappnumber.text != "") {
        userController.phoneFlag.value = true; //xxx
      } else {
        // animateToPage(1);
      }
      if ([
        categoryFlag,
        bedFlag,
        bathFlag,
        kitchenFlag,
        priceFlag,
        imageFlag,
        userController.phoneFlag
      ].every((flag) => flag.value)) {
        allFlag.value = true;
      }
    }
  }

  //* ---------------------------- New Post
  final DBController dbController = Get.put(DBController());

  newpost() async {
    List<String> imageBase64List = [];

    for (int i = 0; i < 12; i++) {
      if (i < selectedImages.length) {
        Uint8List? compressedImage =
            await FlutterImageCompress.compressWithFile(
          selectedImages[i].path,
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
    // ignore: prefer_typing_uninitialized_variables
    var response;
    try {
      if (categories['Only Garage']!.value) {
        print("Only Garage");
        response = await ApiServiceTolet.newPost(
          NewPostTolet(
            uid: dbController.getUserID(),
            propertyname: nameController.text,
            category: getCategory(),
            bed: "",
            bath: "",
            dining: "",
            kitchen: "",
            floornumber: "",
            facing: "",
            roomsize: "",
            rentfrom: rentFrom,
            mentenance: 0,
            rent: int.parse(rent.text.replaceAll(",", "")),
            garagetype: garage.value,
            fasalitis: "",
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
            description: userController.description.text,
            geolon: locationController.currentlongitude.value.toString(),
            geolat: locationController.currentlatitude.value.toString(),
            location: locationController.locationAddressShort.value.toString(),
            shortaddress: userController.shortAddress.text,
            phone: userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.phonenumber.text,
          ),
        );
      } else {
        response = await ApiServiceTolet.newPost(
          NewPostTolet(
            uid: dbController.getUserID(),
            propertyname: nameController.text,
            category: getCategory(),
            bed: bedrooms.value == "select" ? "" : bedrooms.value,
            bath: bathrooms.value == "select" ? "" : bathrooms.value,
            dining: dining.value == "select" ? "" : dining.value,
            kitchen: kitchen.value == "select" ? "" : kitchen.value,
            floornumber: floorno.value == "select" ? "" : floorno.value,
            facing: facing.value == "select" ? "" : facing.value,
            roomsize: roomSize.text == "200" ? "" : roomSize.text,
            rentfrom: rentFrom,
            mentenance: int.parse(maintenance.text == ""
                ? "0"
                : maintenance.text.replaceAll(",", "")),
            rent: int.parse(rent.text.replaceAll(",", "")),
            garagetype: "",
            fasalitis: getFasalities(),
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
            description: userController.description.text,
            geolat: locationController.currentlatitude.value.toString(),
            geolon: locationController.currentlongitude.value.toString(),
            location: locationController.locationAddressShort.value.toString(),
            shortaddress: userController.shortAddress.text,
            phone: userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.phonenumber.text,
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
  var categoriesSort = {
    'Family': false.obs,
    'Bachelor': false.obs,
    'Male Sit': false.obs,
    'Female Sit': false.obs,
    'Sub-let': false.obs,
    'Hostel': false.obs,
    'Shop': false.obs,
    'Office': false.obs,
    'Only Garage': false.obs,
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
    'Lift': FasalitisModel(state: false.obs, icon: Icons.elevator_outlined),
    'Security Guard':
        FasalitisModel(state: false.obs, icon: Icons.security_rounded),
    'WIFI': FasalitisModel(state: false.obs, icon: Icons.wifi_rounded),
    'Power Backup': FasalitisModel(
        state: false.obs, icon: Icons.power_settings_new_rounded),
    'Giser': FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Fire Alarm':
        FasalitisModel(state: false.obs, icon: Icons.fire_extinguisher),
  };
  String getFasalitiesSort() {
    final selectedCategories = fasalitisSort.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    String jsonStringArray = jsonEncode(selectedCategories);
    return jsonStringArray;
  }

  var rentmin = 0.obs;
  var rentmax = 100000.obs;
  var bedsort = [].obs;
  var bathsort = [].obs;

  String getSort(mainList) {
    String jsonStringArray = jsonEncode(mainList
        .map((element) => element is String ? element : element.toString())
        .toList());

    return mainList.isEmpty ? '' : jsonStringArray;
  }

  var totalResult = 0.obs;
  var totalResultloding = false.obs;
  void sortingPostCount() async {
    try {
      totalResultloding(true);

      var response = await ApiServiceTolet.sortingPostCount(
        SortPostTolet(
          geolon: locationController.currentlongitude.value.toString(),
          geolat: locationController.currentlatitude.value.toString(),
          page: 1,
          category: getCategorySort(),
          fasalitis: getFasalitiesSort(),
          rentmin: rentmin.value,
          rentmax: rentmax.value,
          bed: getSort(bedsort),
          bath: getSort(bathsort),
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
    print("object");
    sortloding(true);
    try {
      var response = await ApiServiceTolet.sortingPost(
        SortPostTolet(
          geolon: locationController.currentlongitude.value.toString(),
          geolat: locationController.currentlatitude.value.toString(),
          page: sortpage.value,
          category: getCategorySort(),
          fasalitis: getFasalitiesSort(),
          rentmin: rentmin.value,
          rentmax: rentmax.value,
          bed: getSort(bedsort),
          bath: getSort(bathsort),
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

  //*----------------- Saved Work

  late TabController tabControllerDrawer;
  final GlobalKey<AnimatedListState> deleteKeySaved = GlobalKey();

  void save(int pid, bool status) async {
    try {
      var response = await ApiServiceTolet.savedPost(
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
      var response = await ApiServiceTolet.getSaved(
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
      var response = await ApiServiceTolet.myPostList(
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
      mypostPageloding(false);
    }
  }

  final GlobalKey<AnimatedListState> deleteKeyMypost = GlobalKey();

  void deleteMypost(int postid) async {
    try {
      var response = await ApiServiceTolet.deletePost(
        await dbController.getUserID(),
        postid,
      );
      if (response != null) {}
    } finally {}
  }
}
