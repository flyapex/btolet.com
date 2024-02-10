import 'dart:convert';

import 'package:btolet/api/api_tolet.dart';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/controller/user_controller.dart';
import 'package:btolet/model/category.dart';
import 'package:btolet/model/tolet_model.dart';

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
  Future getCurrentPostCount() async {
    try {
      currentPostCountLoding(true);
      var data = await ApiServiceTolet.postCountArea(
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
      var response = await ApiServiceTolet.getPost(
        page.value,
        locationController.currentlatitude,
        locationController.currentlongitude,
      );

      if (response != null) {
        allPost.addAll(response);
        if (response.isEmpty) {
          //|| response.length < 4
          lodingPosts(false);
        }
        page = page + 1;
      }
    } finally {}
  }

  var singlePostloding = true.obs;
  getSinglePost(postid) async {
    singlePostloding(true);
    try {
      var response = await ApiServiceTolet.getSinglePost(postid);
      if (response != null) {
        return response;
      } else {
        return null;
      }
    } finally {
      singlePostloding(false);
    }
  }

//*---------------------- More Post

  // var morePost = [].obs;
  // var lodeOneTime = true.obs;

  // void getMorePost(postid, category, price, page, latitude, longitude) async {
  //   // print('ModeList Count ${morePost.length}');
  //   // morePost.clear();
  //   print(postid);
  //   print(category);
  //   lodeOneTime(false);
  //   lodingmorePosts(true);
  //   try {
  //     var response = await ApiServiceTolet.getMorePost(
  //       postid,
  //       category,
  //       price,
  //       page,
  //       latitude,
  //       longitude,
  //     );
  //     if (response != null) {
  //       morePost.addAll(response);
  //       if (response.isEmpty || response.length < 4) {
  //         lodingmorePosts(false);
  //       }
  //     }
  //   } finally {
  //     print('ModeList Count ${morePost.length}');
  //     // lodingmorePosts(false);
  //   }
  // }

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
    'Male Seat': false.obs,
    'Female Seat': false.obs,
    'Sub-let': false.obs,
    'Hostel': false.obs,
    'Shop': false.obs,
    'Office': false.obs,
    'Only Garage': false.obs,
  };

  getCategory() {
    final selectedCategories = categories.entries
        .where((entry) => entry.value.value)
        .map((entry) => entry.key)
        .toList();
    // String jsonStringArray = jsonEncode(selectedCategories);
    return selectedCategories;
  }

  var fasalitis = {
    'Parking': FasalitisModel(state: false.obs, icon: Icons.directions_bike),
    'GAS': FasalitisModel(
        state: false.obs, icon: Icons.local_fire_department_outlined),
    'Fire Alarm':
        FasalitisModel(state: false.obs, icon: Icons.fire_extinguisher),
    'CCTV': FasalitisModel(state: false.obs, icon: Icons.photo_camera),
    'Lift': FasalitisModel(state: false.obs, icon: Icons.elevator_outlined),
    'Power Backup': FasalitisModel(
        state: false.obs, icon: Icons.power_settings_new_rounded),
    'Security Guard':
        FasalitisModel(state: false.obs, icon: Icons.security_rounded),
    'WIFI': FasalitisModel(state: false.obs, icon: Icons.wifi_rounded),
    'Giser': FasalitisModel(state: false.obs, icon: Icons.gas_meter_outlined),
    'Garden': FasalitisModel(state: false.obs, icon: Icons.grass),
    'Drinking Water':
        FasalitisModel(state: false.obs, icon: Icons.local_drink_outlined),
  };

  getFasalities() {
    final selectedCategories = fasalitis.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    // String jsonStringArray = jsonEncode(selectedCategories);
    return selectedCategories;
  }

  var selectedBed = bedtolet[0].obs;
  var selectedbath = bathtolet[0].obs;

  // Drop Down

  final dining = 'select'.obs;
  final kitchen = 'select'.obs;
  final floorno = 'select'.obs;
  final facing = 'select'.obs;
  final garage = 'Garage'.obs;
  final balcony = 'select'.obs;
  final drawing = 'select'.obs;

  String getCategoryValue(Category category) {
    switch (category) {
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
      case Category.balcony:
        return balcony.value;
      case Category.drawing:
        return drawing.value;
    }
  }

  void setCategoryValue(Category category, String value) {
    switch (category) {
      case Category.balcony:
        balcony.value = value;
        break;
      case Category.drawing:
        drawing.value = value;
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
  var priceFlag = false.obs;
  var imageFlag = false.obs;
  var locationFlag = true.obs;

  var allFlag = false.obs;

  resetAllflag() {
    activeFlag(false);
    categoryFlag(false);
    priceFlag(false);
    imageFlag(false);

    userController.phoneFlag(false);
    categories.forEach((key, value) {
      value.value = false;
    });
    fasalitis.forEach((key, value) {
      value.state.value = false;
    });
    dining.value = 'select';
    kitchen.value = 'select';
    floorno.value = 'select';
    facing.value = 'select';
    garage.value = 'Garage';
    nameController.clear();
    roomSize.clear();
    maintenance.clear();
    rent.clear();
    userController.description.clear();
    userController.shortAddress.clear();
    selectedImages.clear();
    // locationFlag(false);

    // allFlag(false);
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

  checkAllCatagory() {
    priceFlag.value = rent.text.isNotEmpty;
    imageFlag.value = selectedImages.isNotEmpty;

    userController.phoneFlag.value =
        userController.phonenumber.text.isNotEmpty ||
            userController.wappnumber.text.isNotEmpty;
    // if (locationController.locationAddressShort.value != 'Location') {
    //   locationFlag(false);
    // }
  }

  flagCheck() {
    if (categories['Only Garage']!.value) {
      if (rent.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        animateToPage(0);
      }

      userController.phoneFlag.value =
          userController.phonenumber.text.isNotEmpty ||
              userController.wappnumber.text.isNotEmpty;

      allFlag.value =
          imageFlag.value && priceFlag.value && userController.phoneFlag.value;
    } else if (categories['Office']!.value && categories['Family']!.value) {
      if (rent.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        animateToPage(0);
      }

      userController.phoneFlag.value =
          userController.phonenumber.text.isNotEmpty ||
              userController.wappnumber.text.isNotEmpty;
      allFlag.value =
          priceFlag.value && imageFlag.value && userController.phoneFlag.value;
    } else if (categories['Office']!.value) {
      if (rent.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        animateToPage(0);
      }
      userController.phoneFlag.value =
          userController.phonenumber.text.isNotEmpty ||
              userController.wappnumber.text.isNotEmpty;

      allFlag.value =
          priceFlag.value && imageFlag.value && userController.phoneFlag.value;
    } else if (categories['Shop']!.value) {
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
      userController.phoneFlag.value =
          userController.phonenumber.text.isNotEmpty ||
              userController.wappnumber.text.isNotEmpty;

      allFlag.value =
          imageFlag.value && priceFlag.value && userController.phoneFlag.value;
    } else {
      if (rent.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        animateToPage(0);
      }
      userController.phoneFlag.value =
          userController.phonenumber.text.isNotEmpty ||
              userController.wappnumber.text.isNotEmpty;

      allFlag.value =
          priceFlag.value && imageFlag.value && userController.phoneFlag.value;
    }
  }

  //* ---------------------------- New Post
  final DBController dbController = Get.put(DBController());

  newpost() async {
    print('------------------');
    print(rentFrom);
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
            balcony: '',
            drawing: '',
            dining: "",
            kitchen: "",
            floornumber: "",
            facing: "",
            roomsize: "",
            rentfrom: rentFrom,
            mentenance: 0,
            rent: int.parse(rent.text.replaceAll(",", "")),
            garagetype: garage.value,
            fasalitis: [],
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
            locationfull: locationController.locationAddress.value.toString(),
            shortaddress: userController.shortAddress.text,
            phone: userController.code.value + userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.code.value + userController.wappnumber.text,
          ),
        );
      } else if (categories['Shop']!.value) {
        print("Shop");
        response = await ApiServiceTolet.newPost(
          NewPostTolet(
            uid: dbController.getUserID(),
            propertyname: nameController.text,
            category: getCategory(),
            bed: "",
            bath: "",
            balcony: '',
            drawing: '',
            dining: "",
            kitchen: "",
            floornumber: floorno.value == "select" ? "" : floorno.value,
            facing: facing.value == "select" ? "" : facing.value,
            roomsize: roomSize.text == "" ? "" : roomSize.text,
            rentfrom: rentFrom,
            mentenance: 0,
            rent: int.parse(rent.text.replaceAll(",", "")),
            garagetype: garage.value,
            fasalitis: [],
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
            locationfull: locationController.locationAddress.value.toString(),
            shortaddress: userController.shortAddress.text,
            phone: userController.code.value + userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.code.value + userController.wappnumber.text,
          ),
        );
      } else if (categories['Office']!.value) {
        print("Office");
        response = await ApiServiceTolet.newPost(
          NewPostTolet(
            uid: dbController.getUserID(),
            propertyname: nameController.text,
            category: getCategory(),
            bed: selectedBed.value,
            bath: selectedbath.value,
            balcony: '',
            drawing: '',
            dining: '',
            kitchen: '',
            floornumber: floorno.value == "select" ? "" : floorno.value,
            facing: facing.value == "select" ? "" : facing.value,
            roomsize: roomSize.text == "" ? "" : roomSize.text,
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
            locationfull: locationController.locationAddress.value.toString(),
            shortaddress: userController.shortAddress.text,
            phone: userController.code.value + userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.code.value + userController.wappnumber.text,
          ),
        );
      } else {
        response = await ApiServiceTolet.newPost(
          NewPostTolet(
            uid: dbController.getUserID(),
            propertyname: nameController.text,
            category: getCategory(),
            bed: selectedBed.value,
            bath: selectedbath.value,
            balcony: balcony.value == "select" ? "" : balcony.value,
            drawing: drawing.value == "select" ? "" : drawing.value,
            dining: dining.value == "select" ? "" : dining.value,
            kitchen: kitchen.value == "select" ? "" : kitchen.value,
            floornumber: floorno.value == "select" ? "" : floorno.value,
            facing: facing.value == "select" ? "" : facing.value,
            roomsize: roomSize.text == "" ? "" : roomSize.text,
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
            locationfull: locationController.locationAddress.value.toString(),
            shortaddress: userController.shortAddress.text,
            phone: userController.code.value + userController.phonenumber.text,
            wapp: userController.wappnumber.text.isEmpty
                ? ""
                : userController.code.value + userController.wappnumber.text,
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

  TextEditingController pricemin = TextEditingController();
  TextEditingController pricemax = TextEditingController();

  final FocusNode priceminfocusNode = FocusNode();
  final FocusNode pricemaxfocusNode = FocusNode();

  var priceText = "Any Price".obs;
  var startval1 = 0.0.obs, endval1 = 50000.0.obs;

  var rentmin = 0.obs;
  var rentmax = 100000.obs;

  var resetSort = false.obs;

  resetAllSort() {
    resetSort(true);
    categoriesSort.forEach((key, value) {
      value.value = false;
    });
    fasalitisSort.forEach((key, value) {
      value.state.value = false;
    });
    // resetSort(false);
  }

  var categoriesSort = {
    'Family': false.obs,
    'Bachelor': false.obs,
    'Male Seat': false.obs,
    'Female Seat': false.obs,
    'Sub let': false.obs,
    'Hostel': false.obs,
    'Shop': false.obs,
    'Office': false.obs,
    'Only Garage': false.obs,
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
  getFasalitiesSort() {
    final selectedCategories = fasalitisSort.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    // String jsonStringArray = jsonEncode(selectedCategories);
    return selectedCategories;
  }

  var bedsort = [].obs;
  var bathsort = [].obs;

  List<String> getSort(List<dynamic> mainList) {
    List<String> stringList = mainList
        .map((element) => element is String ? element : element.toString())
        .toList();

    return stringList;
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

  //*--------------- MAP

  var mapToletList = [].obs;
  var mapLoding = true.obs;
  Future mapAllPost() async {
    try {
      mapToletList.clear();
      mapLoding(true);
      var response = await ApiServiceTolet.map();
      if (response != null) {
        mapToletList.addAll(response);
        mapLoding(false);
        return response;
      }
    } finally {}
  }

  RxBool showMapBoxTolet = false.obs;

  var mapPostToletList = [].obs;
  var mapPostLoding = true.obs;
  Future mapPostList(geolat, geolon) async {
    try {
      mapPostToletList.clear();
      mapPostLoding(true);
      var response = await ApiServiceTolet.codinateTopost(geolat, geolon);
      if (response != null) {
        mapPostToletList.addAll(response);
        mapPostLoding(false);
        return response;
      }
    } finally {}
  }
}
