import 'dart:convert';
import 'package:btolet/api/api.dart';
import 'package:btolet/controller/location_controller.dart';
import 'package:btolet/model/apimodel.dart';
import 'package:btolet/pages/post/tolet/widget/drapdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:hl_image_picker_android/hl_image_picker_android.dart';
import 'db_controller.dart';

class PostController extends GetxController {
  final DBController dbController = Get.put(DBController());
  final LocationController locationController = Get.find();

  late TabController tabController;
  var pageController = PageController();
  List<HLPickerItem> selectedImages = [];

  TextEditingController propertyNameTolet = TextEditingController();
  TextEditingController roomSizeTolet = TextEditingController();
  TextEditingController maintenanceTolet = TextEditingController();
  TextEditingController rentTolet = TextEditingController();
  TextEditingController discriptionTolet = TextEditingController();
  TextEditingController shortAddressTolet = TextEditingController();
  TextEditingController nameTolet = TextEditingController();
  TextEditingController phonenumberTolet = TextEditingController();
  TextEditingController wappnumberTolet = TextEditingController();
  TextEditingController garagetxtcontroller = TextEditingController();
  late DateTime rentFrom;

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
  final selectedFilters = <String>[].obs;

  List getSelectedCategoryName() {
    final selectedCategories = categories.entries
        .where((entry) => entry.value.value)
        .map((entry) => entry.key)
        .toList();

    print('Selected Categories: $selectedCategories');
    return selectedCategories;
  }

  var fasalitisTolet = {
    'Balcony': FasalitisTolet(state: false.obs, icon: Icons.balcony_rounded),
    'Parking': FasalitisTolet(state: false.obs, icon: Icons.directions_bike),
    'CCTV': FasalitisTolet(state: false.obs, icon: Icons.photo_camera),
    'GAS': FasalitisTolet(
        state: false.obs, icon: Icons.local_fire_department_outlined),
    'Lift': FasalitisTolet(state: false.obs, icon: Icons.elevator_outlined),
    'Security Guard':
        FasalitisTolet(state: false.obs, icon: Icons.security_rounded),
    'WIFI': FasalitisTolet(state: false.obs, icon: Icons.wifi_rounded),
    'Power Backup': FasalitisTolet(
        state: false.obs, icon: Icons.power_settings_new_rounded),
    'Fire Alarm':
        FasalitisTolet(state: false.obs, icon: Icons.fire_extinguisher),
    'Gaser': FasalitisTolet(state: false.obs, icon: Icons.gas_meter_outlined),
  };

  getFasalitiesNameTolet() {
    final selectedCategories = fasalitisTolet.entries
        .where((entry) => entry.value.state.value)
        .map((entry) => entry.key)
        .toList();

    print('Selected Categories: $selectedCategories');
    return selectedCategories;
  }

  final bedrooms = 'select'.obs;
  final bathrooms = 'select'.obs;
  final dining = 'select'.obs;
  final kitchen = 'select'.obs;
  final floorno = 'select'.obs;
  final facing = 'select'.obs;

  Map<Category, List<String>> categoryData = {
    Category.bedrooms: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
    Category.bathrooms: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
    Category.dining: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
    Category.kitchen: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10+"],
    Category.floorno: [
      "1 st",
      "2 nd",
      "3 rd",
      "4 th",
      "5 th",
      "6 th",
      "7 th",
      "8 th",
      "9 th",
      "10 th",
    ],
    Category.facing: [
      "East",
      "North",
      "North-East",
      "North-West",
      "South",
      "South-East",
      "South-West",
      "West",
    ],
  };
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
      default:
        throw ArgumentError('Invalid category');
    }
  }

  updateProfile() async {
    try {
      var res = await ApiService.profileUpdateapi(
        ProfileUpdate(
          uid: dbController.getUserID(),
          name: nameTolet.text,
          phone: phonenumberTolet.text,
          wapp: wappnumberTolet.text,
        ),
      );
      if (res == null) {
        return false;
      } else {
        await snakberSuccess(res);
      }
    } finally {}
  }

  newPOST() async {
    List<String> imageBase64List = [];

    for (int i = 0; i < 12; i++) {
      if (i < selectedImages.length) {
        Uint8List? compressedImage =
            await FlutterImageCompress.compressWithFile(
          selectedImages[i].path,
          minHeight: 1200,
          minWidth: 800,
          quality: 25,
          rotate: 0,
        );
        String base64Image = base64Encode(compressedImage!);
        imageBase64List.add(base64Image);
      } else {
        imageBase64List.add("");
      }
    }

    // for (int i = 0; i < 12; i++) {
    //   if (i < selectedImages.length) {
    //     imageBase64List.add(
    //       base64Encode(await File(selectedImages[i].path).readAsBytes()),
    //     );
    //   } else {
    //     imageBase64List.add("");
    //   }
    // }

    // ignore: prefer_typing_uninitialized_variables
    var response;
    try {
      if (categories['Only Garage']!.value) {
        print("Only Garage");
        response = await ApiService.newPostTolet(
          PostToServerTolet(
            uid: dbController.getUserID(),
            propertyname: propertyNameTolet.text,
            category: getSelectedCategoryName().toString(),
            bed: "",
            bath: "",
            dining: "",
            kitchen: "",
            floornumber: "",
            facing: "",
            roomsize: "",
            rentfrom: rentFrom,
            mentenance: 0,
            rent: int.parse(garagetxtcontroller.text),
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
            description: discriptionTolet.text,
            geolon: locationController.currentlongitude.value.toString(),
            geolat: locationController.currentlatitude.value.toString(),
            location: locationController.locationAddressShort.value.toString(),
            shortaddress: shortAddressTolet.text,
            phone: phonenumberTolet.text,
            wapp: wappnumberTolet.text,
          ),
        );
      } else {
        print("TOlet");
        print("TOlet");
        response = await ApiService.newPostTolet(
          PostToServerTolet(
            uid: dbController.getUserID(),
            propertyname: propertyNameTolet.text,
            category: getSelectedCategoryName().toString(),
            bed: bedrooms.value,
            bath: bathrooms.value,
            dining: dining.value == "select" ? "" : dining.value,
            kitchen: kitchen.value,
            floornumber: floorno.value == "select" ? "" : floorno.value,
            facing: facing.value == "select" ? "" : facing.value,
            roomsize: roomSizeTolet.text,
            rentfrom: rentFrom,
            mentenance: int.parse(maintenanceTolet.text),
            rent: int.parse(rentTolet.text),
            fasalitis: getFasalitiesNameTolet().toString(),
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
            description: discriptionTolet.text,
            geolon: locationController.currentlongitude.value.toString(),
            geolat: locationController.currentlatitude.value.toString(),
            location: locationController.locationAddressShort.value.toString(),
            shortaddress: shortAddressTolet.text,
            phone: phonenumberTolet.text,
            wapp: wappnumberTolet.text,
          ),
        );
      }
      if (response != null) {
        updateProfile();

        return response;
      } else {
        return null;
      }
    } finally {}
  }

  snakberSuccess(text) {
    return Get.snackbar(
      'You are awarsome',
      "",
      snackPosition: SnackPosition.BOTTOM,
      messageText: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
        ),
        maxLines: 1,
      ),
      duration: const Duration(seconds: 5),
      backgroundColor: Colors.black.withOpacity(0.5),
      colorText: Colors.white,
      borderRadius: 4,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      maxWidth: 400.0,
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'Okay',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  var flagActiveFlag = false.obs;
  var categoryFlag = false.obs;
  var bedFlag = false.obs;
  var bathFlag = false.obs;
  var kitchenFlag = false.obs;
  var priceFlag = false.obs;
  var imageFlag = false.obs;
  var phoneFlag = false.obs;
  var toletAllFlag = false.obs;

  void animateToPage(val) {
    pageController.animateToPage(
      val,
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
    );
    // Vibration.vibrate(pattern: [10, 20, 10]);
    // print('object');
  }

  allToletFlagCheck() {
    if (categories['Only Garage']!.value) {
      print(rentTolet.text.isNotEmpty);
      print(selectedImages.isNotEmpty);
      if (garagetxtcontroller.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (phonenumberTolet.text != "" || wappnumberTolet.text != "") {
        phoneFlag.value = true;
      }
      if (imageFlag.value && priceFlag.value & phoneFlag.value) {
        toletAllFlag.value = true;
      }
    } else {
      if (!categoryFlag.value || getSelectedCategoryName().isEmpty) {
        pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        );
        categoryFlag.value = false;
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
      if (rentTolet.text.isNotEmpty) {
        priceFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (selectedImages.isNotEmpty) {
        imageFlag.value = true;
      } else {
        animateToPage(0);
      }
      if (phonenumberTolet.text != "" || wappnumberTolet.text != "") {
        phoneFlag.value = true;
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
        phoneFlag
      ].every((flag) => flag.value)) {
        toletAllFlag.value = true;
      }
    }
  }

  //* All Tolet POST
  var toletpage = 1.obs;
  var toletlodingPosts = false.obs;
  var allToletPost = [].obs;
  var toletStopLoding = false.obs;
  void getAllPost() async {
    int itemCoutn = allToletPost.length;
    if (toletStopLoding.value) {
    } else {
      toletlodingPosts(true);
      try {
        var response = await ApiService.getAllToletPost(
          toletpage.value,
          locationController.currentlatitude,
          locationController.currentlongitude,
        );
        if (response != null) {
          allToletPost.addAll(response);
          print(allToletPost.length);
          if (response.isEmpty) {
            toletlodingPosts(false);
          }
          toletpage = toletpage + 1;
        }
      } finally {
        toletlodingPosts(false);
        if (itemCoutn == allToletPost.length) {
          toletStopLoding.value = true;
        }
      }
    }
  }

  var singlepostToletloding = false.obs;
  late ToletSinglePost singlepostTolet;
  void getSinglePost(postid) async {
    imageList.clear();
    singlepostToletloding(true);
    try {
      var response = await ApiService.getSinglePostTolet(postid);
      if (response != null) {
        singlepostTolet = response;
        getImageList();
        if (response.isEmpty) {
          singlepostToletloding(false);
        }
      }
    } finally {
      singlepostToletloding(false);
    }
  }

  var imageList = [].obs;
  getImageList() {
    if (singlepostTolet.image1 != '') {
      imageList.add(singlepostTolet.image1);
    }
    if (singlepostTolet.image2 != '') {
      imageList.add(singlepostTolet.image2);
    }
    if (singlepostTolet.image3 != '') {
      imageList.add(singlepostTolet.image3);
    }
    if (singlepostTolet.image4 != '') {
      imageList.add(singlepostTolet.image4);
    }
    if (singlepostTolet.image5 != '') {
      imageList.add(singlepostTolet.image5);
    }
    if (singlepostTolet.image6 != '') {
      imageList.add(singlepostTolet.image6);
    }
    if (singlepostTolet.image7 != '') {
      imageList.add(singlepostTolet.image7);
    }
    if (singlepostTolet.image8 != '') {
      imageList.add(singlepostTolet.image8);
    }
    if (singlepostTolet.image9 != '') {
      imageList.add(singlepostTolet.image9);
    }
    if (singlepostTolet.image10 != '') {
      imageList.add(singlepostTolet.image10);
    }
    if (singlepostTolet.image11 != '') {
      imageList.add(singlepostTolet.image11);
    }
    if (singlepostTolet.image12 != '') {
      imageList.add(singlepostTolet.image12);
    }

    print('------------------------------');
    print(imageList.length);
    return imageList;
  }

  //------------------------sorting
  var family = false.obs;
  var bachelor = false.obs;
  var office = false.obs;
  var sitMale = false.obs;
  var sitFemale = false.obs;
  var sublet = false.obs;
  var hostel = false.obs;
  var shop = false.obs;
  var onlygarage = false.obs;

  var balcony = false.obs;
  var parking = false.obs;
  var lift = false.obs;
  var wifi = false.obs;
  var powerbackup = false.obs;
  var cctv = false.obs;
  var gas = false.obs;
  var security = false.obs;
  var firealarm = false.obs;
  var gaser = false.obs;

  //-----------------------------
  var area = 'শতাংশ'.obs;
  var prooms = 'select'.obs;
  var pbath = 'select'.obs;
  var pfloors = 'select'.obs;
  var pfacing = 'select'.obs;
  var pkitchen = 'select'.obs;

  TextEditingController maintenance = TextEditingController();
  TextEditingController sizeOfHome = TextEditingController();
  TextEditingController propertyName = TextEditingController();
  TextEditingController shortAddress = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController squireft = TextEditingController();

  TextEditingController price = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController wapp = TextEditingController();
  TextEditingController name = TextEditingController();

  // List<HLPickerItem> selectedImages = [];

  //*-------------------------------------------------
  var postpage = false.obs;

  var categoryIndex = true.obs;

  var house = false.obs;
  var appartmetn = false.obs;
  var flat = false.obs;
  var plot = false.obs;
  var land = false.obs;
  var others = false.obs;

  var diningProperty = 'select'.obs;
  var kitchenProperty = 'select'.obs;
  var balconyProperty = 'select'.obs;
  var totalUnitProperty = 'select'.obs;
  var totalFloorProperty = 'select'.obs;

  var pbalcony = false.obs;
  var pparking = false.obs;
  var pelevator = false.obs;
  var pwifi = false.obs;
  var ppowerbackup = false.obs;
  var pcctv = false.obs;
  var pgas = false.obs;
  var psecurity = false.obs;
  var pfirealarm = false.obs;
  var wasaconnection = false.obs;
  var pgaser = false.obs;
  var fireexit = false.obs;
  var westdisposal = false.obs;
  var garden = false.obs;

  var drain = false.obs;
  var electricity = false.obs;
}

class FasalitisTolet {
  final RxBool state;
  final IconData icon;

  FasalitisTolet({required this.state, required this.icon});
}
