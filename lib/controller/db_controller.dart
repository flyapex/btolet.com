import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DBController extends GetxController {
  final _box = GetStorage();

  // ignore: non_constant_identifier_names
  final login_key = 'userKey';

  getUserID() => _box.read(login_key) ?? false;
  saveUserId(int value) => _box.write(login_key, value);
}
