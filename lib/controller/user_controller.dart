import 'package:btolet/api/api.dart';
import 'package:btolet/controller/post_controller.dart';
import 'package:btolet/model/apimodel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  PostController postController = Get.put(PostController());
  var banneradsList = [].obs;
  var bannerLoding = true.obs;
  var fatchOneTime = true.obs;
  Future bannerApi() async {
    try {
      banneradsList.clear();
      bannerLoding(true);
      var response = await ApiService.banner();
      if (response != null) {
        banneradsList.addAll(response);
        // banneradsList.add(response);
        bannerLoding(false);
      }
    } finally {
      fatchOneTime(false);
    }
  }

  // RxInt uid = 0.obs;
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
        postController.nameTolet.text = userdetails.name;
        postController.phonenumberTolet.text = userdetails.phone;
        postController.wappnumberTolet.text = userdetails.wapp;
        return userdetails;
      }
    } finally {
      isLoading(false);
    }
  }

  // creatNewUser(Newuser data) async {
  //   try {
  //     isLoading(true);
  //     var response = await ApiService.userLogin(data);
  //     if (response != null) {
  //       // print(response);
  //       return response;
  //     } else {
  //       return null;
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

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
        postController.nameTolet.text = user.name;
        postController.phonenumberTolet.text = user.phone;
        postController.wappnumberTolet.text = user.wapp;
        return user;
      }
    } finally {
      isLoadingUserDetails(false);
    }
  }
}
