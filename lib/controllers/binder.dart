import 'package:get/get.dart';
import 'package:outlet_insight/controllers/dashboard_controller.dart';
import 'package:outlet_insight/controllers/home_page_controller.dart';
import 'package:outlet_insight/controllers/login_controller.dart';
import 'package:outlet_insight/controllers/shared_preference_controller.dart';

class DependencyBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SharedPreferenceController());
    Get.put(LoginController());
    Get.put(DashboardController());
    Get.put(HomePageController());
  }
}
