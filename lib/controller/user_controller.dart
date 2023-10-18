import 'package:btolet/api/api.dart';
import 'package:btolet/model/apimodel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var banneradsList = [].obs;
  var bannerLoding = true.obs;
  // var fatchOneTime = true.obs;
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
      // fatchOneTime(false);
    }
  }

  // RxInt uid = 0.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString image = ''.obs;
  RxString phone = ''.obs;
  RxString wapp = ''.obs;
  RxString geolocation = ''.obs;
  RxString signature = ''.obs;
  late DateTime time = ''.obs as DateTime;

  var isLoading = false.obs;
  userChackEmail(email) async {
    try {
      isLoading(true);
      var user = await ApiService.userCheck(email);
      if (user == null) {
        return false;
      } else {
        name.value = user.name;
        name.value = user.name;
        email = user.email;
        image.value = user.image;
        phone.value = user.phone;
        wapp.value = user.wapp;
        geolocation.value = user.geolocation;
        signature.value = user.signature;
        time = user.time;
        return user.uid;
      }
    } finally {
      isLoading(false);
    }
  }

  creatNewUser(Newuser data) async {
    try {
      isLoading(true);
      var response = await ApiService.createNewUser(data);
      if (response != null) {
        // print(response);
        return response;
      } else {
        return null;
      }
    } finally {
      isLoading(false);
    }
  }

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
}
