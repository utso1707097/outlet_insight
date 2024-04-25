import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:multi_dropdown/multiselect_dropdown.dart';


class DashboardController extends GetxController {
  // Current user ID
  final MultiSelectController multiSelectController = MultiSelectController();

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

  // Method to clear all image data
  void clearData() {
    // Clear all data
    currentUserId.value = "";
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
    premises.value = "";

    selectedHolidays.clear();
    selectedCameraPlacementOptions.clear();

    interiorBase64Image.value = '';
    exteriorBase64Image.value = '';
    frontBase64Image.value = '';
    backBase64Image.value = '';
  }

  @override
  void onClose() {
    // Dispose the form key when the controller is closed
    clearData();
    super.onClose();
  }


  // Method to set interior base64 image
  void setInteriorBase64Image(String value) {
    interiorBase64Image.value = value;
    update();
    print("Image saved as : ${interiorBase64Image.value}");
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
    final interiorUpload = _uploadImage(interiorBase64Image.value, 'interior_image_upload_url');
    final exteriorUpload = _uploadImage(exteriorBase64Image.value, 'exterior_image_upload_url');
    final frontUpload = _uploadImage(frontBase64Image.value, 'front_image_upload_url');
    final backUpload = _uploadImage(backBase64Image.value, 'back_image_upload_url');

    // Wait for all uploads to complete
    await Future.wait([interiorUpload, exteriorUpload, frontUpload, backUpload]);

    // Upload details
    try {
      final detailsResponse = await http.post(
        Uri.parse('details_upload_url'),
        body: {
          // Include other details here
        },
      );
      print('Details Response: ${detailsResponse.statusCode}');
    } catch (e) {
      print('Error uploading details: $e');
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
        print('Upload Response: ${response.statusCode}');
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }
}