import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DBController extends GetxController {
  final _box = GetStorage();

  final loginKey = 'userKey';
  final loginToken = 'token';

  getUserID() => _box.read(loginKey) ?? false;
  saveUserId(int value) => _box.write(loginKey, value);

  getUserToken() => _box.read(loginToken) ?? false;
  saveUserToken(int value) => _box.write(loginToken, value);
}
