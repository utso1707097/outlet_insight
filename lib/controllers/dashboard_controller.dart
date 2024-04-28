import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:outlet_insight/controllers/shared_preference_controller.dart';
import 'package:outlet_insight/models/usermodel.dart';
import 'package:outlet_insight/utils/custom_alert_dialog.dart';
import 'package:outlet_insight/utils/custom_loading_indicator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/outlet_page.dart';

class DashboardController extends GetxController {
  // Current user ID

  RxString marketName = "".obs;
  RxString currentUserId = "".obs;
  RxString respondent = "".obs;
  RxString retailName = "".obs;
  RxString street = "".obs;
  RxString cluster = "".obs;
  RxString region = "".obs;
  RxString area = "".obs;

  RxString owner = "".obs;
  RxString phone1 = "".obs;
  RxString phone2 = "".obs;
  RxString bkash = "".obs;
  RxString pointOfContactName = "".obs;
  RxString pointOfContactPhone = "".obs;
  RxString averageFootfall = "".obs;
  RxString openTime = "".obs;
  RxString closeTime = "".obs;
  RxString amountDemand = "".obs;
  RxString largestIncentive = "".obs;
  RxString client = "".obs;
  RxString averageDailySales = "".obs;

  // Rx variables for dropdown fields
  final RxString relationshipWithRetail = "".obs;
  final RxString ownershipType = "".obs;
  final RxString tradeAvailability = "".obs;
  final RxString whoseBkash = "".obs;
  final RxString internetAvailability = "".obs;
  final RxString cctvAvailability = "".obs;
  final RxString cctvEyeLevel = "".obs;
  final RxString cctvPlacement = "".obs;
  final RxString incentive_happiness = "".obs;
  final RxString retailCategory = "".obs;
  final RxString retailType = "".obs;
  final RxString premises = "".obs;

  // Rx variables for other fields
  final RxString respondantRelationWithRetail = "".obs;
  final RxString availablePlacesToMountTheDisplayOther = "".obs;
  final RxString retailTypeOther = "".obs;

  // Rx variables for location
  final RxString latitude = "".obs;
  final RxString longitude = "".obs;
  final RxString accuracy = "".obs;

  // Rx variables for brand
  final RxString brand1 = "".obs;
  final RxString brand2 = "".obs;
  final RxString brand3 = "".obs;
  final RxString brand4 = "".obs;
  final RxString brand5 = "".obs;

  // Rx variables for multiselect dropdown fields

  RxList<String> selectedHolidays = <String>[].obs;
  RxList<String> selectedCameraPlacementOptions = <String>[].obs;

  // RxString variables to hold base64 images
  RxString interiorBase64Image = ''.obs;
  RxString exteriorBase64Image = ''.obs;
  RxString frontBase64Image = ''.obs;
  RxString backBase64Image = ''.obs;

  // RxString for version check
  RxString appVersion = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchAppVersion();
    if (appVersion.value!="" && currentUserId.value != "") {
      print("called");
      checkForUpdate(
          currentUserId.value.toString(), "outlet", appVersion.value, Get.context!);
    }
  }

  Future<void> checkForUpdate(String userId, String appName,
      String currentVersion, BuildContext context) async {
    try {
      // Set up the URL
      final String url =
          'http://retail.isgalleon.com/api/app_version/version_check.php';

      // Create the multipart request
      final http.MultipartRequest request =
      http.MultipartRequest('POST', Uri.parse(url));

      String modifiedVersionCode =
      currentVersion.substring(0, currentVersion.length - 2);

      // Add your data to the request
      request.fields['UserId'] = userId;
      request.fields['AppName'] = appName;
      request.fields['CurrentVersion'] = modifiedVersionCode;
      print(request.fields);

      // Send the request
      final http.Response response =
      await http.Response.fromStream(await request.send());
      print("this is the response body: ${response.body}");
      if (response.statusCode == 200) {
        // Request was successful
        Map<String, dynamic> responseData = jsonDecode(response.body);
        // Process the response data, you can handle it according to your requirements

        if (responseData['success']) {
          String message = responseData['message'];

          // Check if the message is "Version detail updated"
          if (message == "New version found.") {
            // Handle the case when a new version is found
            Map<String, dynamic> appInfo = responseData['appInfo'];
            // Extract information from appInfo and take necessary actions
            String appName = appInfo['app_name'];
            String appVersion = appInfo['app_version'];
            String appLocationUrl = appInfo['app_location_url'];
            // Call another function or perform actions based on the new version information
            showUpdateDialog(context, "Update", "Please update your app",
                appLocationUrl, appVersion);
          }
        }
        print("This is response for app response: ${responseData}");
      } else {
        // Request failed
        // print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors
      print('Error sending version check request: $error');
    }
  }

  void showUpdateDialog(BuildContext context, String title, String message,
      String appLocationUrl, String updatedApkVersion) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF333333),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              const Icon(
                Icons.arrow_circle_up,
                color: Colors.blue,
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                'New Version: $updatedApkVersion',
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                'Your apk version: ${appVersion.value.substring(0, appVersion.value.length - 2)}',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            // Update button instead of cancel
            TextButton(
              onPressed: (){
                downloadFile(appLocationUrl);
              },
              child: const Text('Update', style: TextStyle(color: Colors.red)),
            ),
            TextButton(onPressed:  (){Navigator.pop(context);}, child: const Text('Cancel', style: TextStyle(color: Colors.red)),)
          ],
        );
      },
    );
  }

  Future<void> downloadFile(String appLocationUrl) async {
    // print(appLocationUrl);
    Uri fileUrl = Uri.parse(appLocationUrl);
    print("This is file url: $fileUrl");
    // const fileUrl = 'YOUR_SHAREABLE_LINK'; // Replace with your shareable link
    if (await canLaunchUrl(fileUrl)) {
      await launchUrl(fileUrl);
    } else {
      throw 'Could not launch $fileUrl';
    }
  }

  Future<void> fetchAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = packageInfo.version;
      print("App Version: ${appVersion.value}");
    } catch (e) {
      print('Error fetching app version: $e');
    }
  }

  // Method to clear all image data
  void clearData() {
    // Clear all data
    marketName.value = "";
    respondent.value = "";
    retailName.value = "";
    street.value = "";
    cluster.value = "";
    area.value = "";
    region.value = "";
    owner.value = "";
    phone1.value = "";
    phone2.value = "";
    bkash.value = "";
    pointOfContactName.value = "";
    pointOfContactPhone.value = "";
    averageFootfall.value = "";
    openTime.value = "";
    closeTime.value = "";
    amountDemand.value = "";
    largestIncentive.value = "";
    client.value = "";
    averageDailySales.value = "";

    accuracy.value = "";
    latitude.value = "";
    longitude.value = "";

    relationshipWithRetail.value = "";
    ownershipType.value = "";
    tradeAvailability.value = "";
    whoseBkash.value = "";
    internetAvailability.value = "";
    cctvAvailability.value = "";
    cctvEyeLevel.value = "";
    cctvPlacement.value = "";
    incentive_happiness.value = "";
    retailCategory.value = "";
    retailType.value = "";
    respondantRelationWithRetail.value = "";
    availablePlacesToMountTheDisplayOther.value = "";
    retailTypeOther.value = "";
    selectedHolidays.clear();
    selectedCameraPlacementOptions.clear();

    interiorBase64Image.value = '';
    exteriorBase64Image.value = '';
    frontBase64Image.value = '';
    backBase64Image.value = '';
  }

  void submitOutletInformation(BuildContext context) async {
    try {
      final String apiUrl =
          'http://retail.isgalleon.com/api/outlet/insert_outlet.php';

      // Create the request body
      Map<String, String> requestBody = {
        'RetailName': retailName.value.toString(),
        'HasTradeLicense': tradeAvailability.toString(),
        'RespondentRelationWithRetailOther':
            respondantRelationWithRetail.value.toString(),
        'RespondentRelationWithRetail': relationshipWithRetail.value.toString(),
        'AvailablePlacesToMountTheDisplayOther':
            availablePlacesToMountTheDisplayOther.value.toString(),
        'RetailTypeOther':retailTypeOther.value.toString(),
        'RespondentName': respondent.value.toString(),
        'AddressStreet': street.value.toString(),
        'AddressCluster': cluster.value.toString(),
        'AddressArea': area.value.toString(),
        'AddressRegion': region.value.toString(),
        'OwnerType': ownershipType.value.toString(),
        // This value seems to be constant
        'OwnerName': owner.value.toString(),
        'OwnerContactNumber1': phone1.value.toString(),
        'OwnerContactNumber2': phone2.value.toString(),
        'OwnerBkashNumber': bkash.value.toString(),
        'PointOfContactName': pointOfContactName.value.toString(),
        'PointOfContactNumber': pointOfContactPhone.value.toString(),
        'AverageConsumerFootfallPerDay': averageFootfall.value.toString(),
        'OwnerOfBkashTransactionNumber': whoseBkash.value.toString(),
        'OpenTime': openTime.value.toString(),
        'CloseTime': closeTime.value.toString(),
        'Top5Brands1': brand1.value.toString(),
        'Top5Brands2': brand2.value.toString(),
        'Top5Brands3': brand3.value.toString(),
        'Top5Brands4': brand4.value.toString(),
        'Top5Brands5': brand5.value.toString(),
        'IsAvailableInternetHardware': internetAvailability.value.toString(),
        'IsAvailableCctv': cctvAvailability.value.toString(),
        'CctvMonitorPlacedLocation': cctvPlacement.value.toString(),
        'WeeklyOffDays': selectedHolidays.join(',').toString(),
        'AvailablePlacesToMountTheDisplay':
            selectedCameraPlacementOptions.join(',').toString(),
        // Adjust this accordingly
        'IsGoingToBePlacedAnyCorner': cctvPlacement.value.toString(),
        // This value seems to be constant
        'WillDisplayBePlacedAtEyeLevel': cctvEyeLevel.value.toString(),
        'IsRetailerHappyWithIncentiveOffered':
            incentive_happiness.value.toString(),
        'WhatIncentiveDemand': amountDemand.value.toString(),
        'LargestAmountOfIncentiveHetGets': largestIncentive.value.toString(),
        'WhoIsTheClient': client.value.toString(),
        'AverageDailySales': averageDailySales.value.toString(),
        'RetailCategory': retailCategory.value.toString(),
        'RetailType': retailType.value.toString(),
        'Premises': premises.value.toString(),
        'MarketName': marketName.value.toString(),
        // This value seems to be constant
        'LatValue': latitude.value.toString(),
        // Adjust this accordingly
        'LonValue': longitude.value.toString(),
        // Adjust this accordingly
        'Accuracy': accuracy.value.toString(),
        // Adjust this accordingly
        'PictureData': '',
        // Adjust this accordingly
        'Remarks': 'This is a test remark.',
        'AppVersion': '1.0.0',
        'UserId': currentUserId.value.toString(),
      };

      // Make the request
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: CustomLoadingIndicator(), // Assuming CustomLoadingIndicator is your custom loading widget
            ),
          );
        },
      );
      final http.Response response =
          await http.post(Uri.parse(apiUrl), body: requestBody);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          // Handle success response
          print(
              'Outlet information submitted successfully: ${responseData['message']}');
          await Future.wait([
            if (interiorBase64Image.value != '')
              uploadBase64Image(
                  responseData['outletId'],
                  currentUserId.value.toString(),
                  interiorBase64Image.value.toString(),
                  "http://retail.isgalleon.com/api/outlet/insert_installation_01_picture.php"),
            if (frontBase64Image.value != '')
              uploadBase64Image(
                  responseData['outletId'],
                  currentUserId.value.toString(),
                  frontBase64Image.value.toString(),
                  "http://retail.isgalleon.com/api/outlet/insert_installation_02_picture.php"),
            if (backBase64Image.value != '')
              uploadBase64Image(
                  responseData['outletId'],
                  currentUserId.value.toString(),
                  backBase64Image.value.toString(),
                  "http://retail.isgalleon.com/api/outlet/insert_outside_picture.php"),
          ]);
          Navigator.pop(context);
          clearData();
          update();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OutletPage(),
            ),
          );
          showCustomAlertDialog(context, 'Success', responseData['message']);
        } else {
          // Handle failure response
          log('Failed to submit outlet information: ${responseData['message']}');
          Navigator.pop(context);
          showCustomAlertDialog(context, 'Error', responseData['message']);
        }
      } else {
        // Handle HTTP error
        log('Failed to submit outlet information. Status code: ${response.statusCode}');
        Navigator.pop(context);
        showCustomAlertDialog(context, 'Error',
            'Failed to submit outlet information. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      log('Error submitting outlet information: $error');
      Navigator.pop(context);
      showCustomAlertDialog(
          context, 'Error', 'Error submitting outlet information: $error');
    }
  }

  @override
  void onClose() {
    super.onClose();
    clearData();
    currentUserId.value = "";
  }

  Future<void> fetchDataFromSession() async {
    SharedPreferenceController _cache = Get.find();
    UserModel? user = await _cache.getCurrentUser();
    if (user != null) {
      log("User ID: ${user.userId}");
      currentUserId.value = user.userId!;
      log("current user id: ${currentUserId.value}");
      update();
      log("User Name: ${user.userName}");
    } else {
      log("User not found in session.");
    }
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      log("Location Denied");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      log("Latitude=${currentPosition.latitude.toString()}");
      log("Longitude=${currentPosition.longitude.toString()}");
      log("Accuracy=${currentPosition.accuracy.toString()}");
      latitude.value = currentPosition.latitude.toString();
      longitude.value = currentPosition.longitude.toString();
      accuracy.value = currentPosition.accuracy.toString();
      log(latitude.value);
      log(longitude.value);
      log(accuracy.value);
      update();
    }
  }

  void showCustomAlertDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: title,
          message: message,
        );
      },
    );
  }

  // Method to set interior base64 image
  void setInteriorBase64Image(String value) {
    interiorBase64Image.value = value;
    update();
    log("Image saved as : ${interiorBase64Image.value}");
  }

  // Method to set exterior base64 image
  void setExteriorBase64Image(String value) {
    exteriorBase64Image.value = value;
    update();
  }

  // Method to set front base64 image
  void setFrontBase64Image(String value) {
    frontBase64Image.value = value;
    update();
  }

  // Method to set back base64 image
  void setBackBase64Image(String value) {
    backBase64Image.value = value;
    update();
  }

  Future<void> uploadBase64Image(
      String outletId, String userId, String base64Image, String url) async {
    try {
      Uri requestUri = Uri.parse(url);
      var request = http.MultipartRequest('POST', requestUri);

      request.fields['OutletId'] = outletId;
      request.fields['UserId'] = userId;
      request.fields['ImageData'] = base64Image;
      var response = await http.Response.fromStream(await request.send());
      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        bool imageSuccess = json.decode(response.body)['success'];
        if (imageSuccess) {
          var sessionData = jsonResponse['sessionData'];
          log("Image sending success");
        } else {
          log("${response.statusCode} ${response.body}");
        }
      } else {
        log("${response.statusCode} ${response.body}");
      }
    } catch (error) {
      log('Error: $error');
    }
  }
}
