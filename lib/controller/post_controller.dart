import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  var pageController = PageController();
  var family = false.obs;
  var bachelor = false.obs;
  var officeSpace = false.obs;
  var sitMale = false.obs;
  var sitFemale = false.obs;
  var sublet = false.obs;
  var hostel = false.obs;
  var shop = false.obs;
  var garage = false.obs;

  var balcony = false.obs;
  var parking = false.obs;
  var lift = false.obs;
  var wifi = false.obs;
  var powerbackup = false.obs;
  var cctv = false.obs;
  var gas = false.obs;
  var security = false.obs;
  var firealarm = false.obs;

  TextEditingController maintenance = TextEditingController();
  TextEditingController sizeOfHome = TextEditingController();
  TextEditingController shortAddress = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController wapp = TextEditingController();
  TextEditingController name = TextEditingController();
}
