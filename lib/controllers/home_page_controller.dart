import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  RxBool _seen = false.obs;

  bool get seen => _seen.value;

  @override
  void onInit() {
    super.onInit();
    checkSeenStatus();
  }

  Future<void> checkSeenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _seen.value = prefs.getBool('seen') ?? false;
  }
}