import 'package:btolet/pages/post/tolet/widget/drapdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  late TabController tabController;
  var pageController = PageController();

  TextEditingController propertyNameTolet = TextEditingController();
  TextEditingController roomSizeTolet = TextEditingController();
  TextEditingController maintenanceTolet = TextEditingController();
  TextEditingController rentTolet = TextEditingController();
  TextEditingController discriptionTolet = TextEditingController();
  TextEditingController shortAddressTolet = TextEditingController();
  TextEditingController nameTolet = TextEditingController();
  TextEditingController numberTolet = TextEditingController();
  TextEditingController wappnumberTolet = TextEditingController();

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

  getSelectedCategoryName() {
    final selectedCategories = categories.entries
        .where((entry) => entry.value.value)
        .map((entry) => entry.key)
        .toList();

    print('Selected Categories: $selectedCategories');
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
      "10 th"
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
  TextEditingController garagetxtcontroller = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController wapp = TextEditingController();
  TextEditingController name = TextEditingController();

  late String image1 = '';
  late String image2 = '';
  late String image3 = '';
  late String image4 = '';
  late String image5 = '';

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
