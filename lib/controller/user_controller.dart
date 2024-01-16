import 'dart:convert';

import 'package:btolet/api/api.dart';
import 'package:btolet/model/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'db_controller.dart';

class UserController extends GetxController {
  TextEditingController shortAddress = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController wappnumber = TextEditingController();

  var phoneFlag = false.obs;

  final FocusNode shortaddressfocusNode = FocusNode();
  final FocusNode descriptionfocusNode = FocusNode();
  final FocusNode namefocusNode = FocusNode();
  final FocusNode phonefocusNode = FocusNode();
  final FocusNode wappfocusNode = FocusNode();

  currency(amount) {
    String formattedAmount;
    if (amount.abs() >= 10000000) {
      formattedAmount = (amount / 10000000).toStringAsFixed(2) + ' Crore';
    } else if (amount.abs() >= 100000) {
      formattedAmount = (amount / 100000).toStringAsFixed(2) + ' Lakh';
    } else if (amount.abs() >= 1000) {
      formattedAmount = (amount / 1000).toStringAsFixed(2) + 'k';
    } else {
      formattedAmount = amount.toStringAsFixed(2);
    }
    formattedAmount = formattedAmount.replaceAll(RegExp(r'\.00'), '');
    return formattedAmount;
  }

  getDay(date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} h ago";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} d ago";
    } else {
      final months = difference.inDays ~/ 30;
      return "$months mon${months > 1 ? 's' : ''} ago";
    }
  }

  getDayfull(date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} days ago";
    } else {
      final months = difference.inDays ~/ 30;
      return "$months month${months > 1 ? 's' : ''} ago";
    }
  }

  //*--------------------------------------Tolet & Property Tab
  late TabController tabController;

  //*--------------------------------------User Details
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString image =
      'https://lh3.googleusercontent.com/a/ACg8ocI5SL5XCQO4EArybQ1127wXGS6x5kvrG2hNVpXBCfFsflY'
          .obs;
  RxString phone = ''.obs;
  RxString wapp = ''.obs;
  RxString geolocation = ''.obs;
  RxString signature = ''.obs;
  late DateTime time = ''.obs as DateTime;

  var isLoading = false.obs;
  userLogin(Newuser data) async {
    try {
      isLoading(true);
      var userdetails = await ApiService.userLogin(data);
      if (userdetails == null) {
        return false;
      } else {
        name.value = userdetails.name;
        email.value = userdetails.email;
        image.value = userdetails.image;
        phone.value = userdetails.phone;
        wapp.value = userdetails.wapp;
        geolocation.value = userdetails.geolocation;
        signature.value = userdetails.signature;
        time = userdetails.time;
        return userdetails;
      }
    } finally {
      isLoading(false);
    }
  }

  var isLoadingUserDetails = false.obs;
  userDetailsByID(id) async {
    try {
      isLoadingUserDetails(true);
      var user = await ApiService.userdetails(id);
      if (user == null) {
        return null;
      } else {
        name.value = user.name;
        email.value = user.email;
        image.value = user.image;
        phone.value = user.phone;
        wapp.value = user.wapp;
        geolocation.value = user.geolocation;
        signature.value = user.signature;
        time = user.time;
        nameController.text = user.name;
        phonenumber.text = user.phone;
        wappnumber.text = user.wapp;

        // userNameTxtController.text = user.name;
        // emailTxtController.text = user.email;
        // phoneTxtController.text = user.phone;
        // wappTxtController.text = user.wapp;
        return user;
      }
    } finally {
      isLoadingUserDetails(false);
    }
  }

  //*--------------------------------------Drawer
  late TabController tabControllerDrawer;
  //*--------------------------------------Home

  var fatchOneTime = true.obs;
  var note = 'Hello from Btolet.com )'.obs;
  void getnote() async {
    try {
      var response = await ApiService.notes();
      if (response != null) {
        note.value = response.text;
        fatchOneTime.value = false;
      }
    } finally {}
  }

  var banneradsList = [].obs;
  var bannerLoding = true.obs;
  var fatchOneTimeBanner = true.obs;
  var bannerImage = [].obs;

  decodeImage() async {
    bannerImage.clear();
    for (var banner in banneradsList) {
      Uint8List decodedImage = base64Decode(banner.image);
      Image decodedImageWidget = Image.memory(
        decodedImage,
        fit: BoxFit.cover,
      );
      bannerImage.add(decodedImageWidget);
    }
  }

  Future bannerApi() async {
    try {
      banneradsList.clear();
      bannerLoding(true);
      var response = await ApiService.banner();
      if (response != null) {
        banneradsList.addAll(response);
        await decodeImage();
        bannerLoding(false);
      }
    } finally {
      fatchOneTimeBanner(false);
    }
  }

  //*--------------------------user details Update
  DBController dbController = Get.find();
  updateProfile() async {
    try {
      var res = await ApiService.profileUpdateapi(
        ProfileUpdate(
          uid: dbController.getUserID(),
          name: nameController.text,
          phone: phonenumber.text,
          wapp: wappnumber.text,
        ),
      );
      if (res == null) {
        return false;
      } else {
        // await snakberSuccess(res);
        return res;
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
          color: Colors.white,
        ),
        maxLines: 1,
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.black.withOpacity(0.1),
      colorText: Colors.white,
      borderRadius: 4,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      maxWidth: 400.0,
      mainButton: TextButton(
        onPressed: () {
          // refreshkey.currentState!.refresh(
          //   draggingDuration: const Duration(milliseconds: 350),
          //   draggingCurve: Curves.easeOutBack,
          // );
          Get.back();
        },
        child: const Text(
          'Okay',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
