import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  late TabController tabController;
  var pageController = PageController();

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
  var rooms = 'select'.obs;
  var bath = 'select'.obs;
  var floors = 'select'.obs;
  var facing = 'select'.obs;
  var kitchen = 'select'.obs;

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
