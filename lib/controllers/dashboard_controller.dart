import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:outlet_insight/controllers/shared_preference_controller.dart';
import 'package:outlet_insight/models/usermodel.dart';
import 'package:outlet_insight/utils/custom_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardController extends GetxController {
  // Current user ID


  RxString marketName = "".obs;
  RxString currentUserId = "".obs;
  RxString respondent = "".obs;
  RxString retailName = "".obs;
  RxString street = "".obs;
  RxString cluster = "".obs;
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

  @override
  void onInit() async{
    super.onInit();
    await fetchDataFromSession();
    await getCurrentLocation();
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
    selectedHolidays.clear();
    selectedCameraPlacementOptions.clear();

    interiorBase64Image.value = '';
    exteriorBase64Image.value = '';
    frontBase64Image.value = '';
    backBase64Image.value = '';
  }

  void submitOutletInformation(BuildContext context) async {
    try {
      final String apiUrl = 'http://retail.isgalleon.com/api/outlet/insert_outlet.php';

      // Create the request body
      Map<String, String> requestBody = {
        'RetailName': retailName.value.toString(),
        'HasTradeLicense': tradeAvailability.toString(),
        'RespondentRelationWithRetailOther':respondantRelationWithRetail.value.toString(),
        'AvailablePlacesToMountTheDisplayOther':availablePlacesToMountTheDisplayOther.value.toString(),
        'RespondentName':respondent.value.toString(),
        'AddressStreet': street.value.toString(),
        'AddressCluster': cluster.value.toString(),
        'AddressArea': area.value.toString(),
        'OwnerType': ownershipType.value.toString(), // This value seems to be constant
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
        'AvailablePlacesToMountTheDisplay': selectedCameraPlacementOptions.join(',').toString(), // Adjust this accordingly
        'IsGoingToBePlacedAnyCorner': cctvPlacement.value.toString(), // This value seems to be constant
        'WillDisplayBePlacedAtEyeLevel': cctvEyeLevel.value.toString(),
        'IsRetailerHappyWithIncentiveOffered': incentive_happiness.value.toString(),
        'WhatIncentiveDemand': amountDemand.value.toString(),
        'LargestAmountOfIncentiveHetGets': largestIncentive.value.toString(),
        'WhoIsTheClient': client.value.toString(),
        'AverageDailySales': averageDailySales.value.toString(),
        'RetailCategory': retailCategory.value.toString(),
        'RetailType': retailType.value.toString(),
        'Premises': premises.value.toString(),
        'MarketName': marketName.value.toString(), // This value seems to be constant
        'LatValue': latitude.value.toString(), // Adjust this accordingly
        'LonValue': longitude.value.toString(), // Adjust this accordingly
        'Accuracy': accuracy.value.toString(), // Adjust this accordingly
        'PictureData': '', // Adjust this accordingly
        'Remarks': 'This is a test remark.',
        'AppVersion': '1.0.0',
        'UserId': currentUserId.value.toString(),
      };

      // Make the request
      final http.Response response = await http.post(Uri.parse(apiUrl), body: requestBody);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          // Handle success response
          print('Outlet information submitted successfully: ${responseData['message']}');
          clearData();
          showCustomAlertDialog(context, 'Success', responseData['message']);

        } else {
          // Handle failure response
          print('Failed to submit outlet information: ${responseData['message']}');
          showCustomAlertDialog(context, 'Error', responseData['message']);
        }
      } else {
        // Handle HTTP error
        print('Failed to submit outlet information. Status code: ${response.statusCode}');
        showCustomAlertDialog(context, 'Error', 'Failed to submit outlet information. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('Error submitting outlet information: $error');
      showCustomAlertDialog(context, 'Error', 'Error submitting outlet information: $error');
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

  void showCustomAlertDialog(BuildContext context, String title, String message) {
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

  // Method to upload images and details
  Future<void> uploadImagesAndDetails() async {
    // Concurrently upload all images
    final interiorUpload =
        _uploadImage(interiorBase64Image.value, 'interior_image_upload_url');
    final exteriorUpload =
        _uploadImage(exteriorBase64Image.value, 'exterior_image_upload_url');
    final frontUpload =
        _uploadImage(frontBase64Image.value, 'front_image_upload_url');
    final backUpload =
        _uploadImage(backBase64Image.value, 'back_image_upload_url');

    // Wait for all uploads to complete
    await Future.wait(
        [interiorUpload, exteriorUpload, frontUpload, backUpload]);

    // Upload details
    try {
      final detailsResponse = await http.post(
        Uri.parse('details_upload_url'),
        body: {
          // Include other details here
        },
      );
      log('Details Response: ${detailsResponse.statusCode}');
    } catch (e) {
      log('Error uploading details: $e');
    }
  }

  // Helper method to upload image
  Future<void> _uploadImage(String base64Image, String uploadUrl) async {
    if (base64Image.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(uploadUrl),
          body: {'image': base64Image},
        );
        log('Upload Response: ${response.statusCode}');
      } catch (e) {
        log('Error uploading image: $e');
      }
    }
  }
}