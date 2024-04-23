import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class DashboardController extends GetxController {
  // Current user ID
  String currentUserId = "";

  // RxString variables to hold base64 images
  RxString interiorBase64Image = ''.obs;
  RxString exteriorBase64Image = ''.obs;
  RxString frontBase64Image = ''.obs;
  RxString backBase64Image = ''.obs;

  // Method to clear all image data
  void clearData() {
    interiorBase64Image.value = '';
    exteriorBase64Image.value = '';
    frontBase64Image.value = '';
    backBase64Image.value = '';
  }

  // Method to set interior base64 image
  void setInteriorBase64Image(String value) {
    interiorBase64Image.value = value;
  }

  // Method to set exterior base64 image
  void setExteriorBase64Image(String value) {
    exteriorBase64Image.value = value;
  }

  // Method to set front base64 image
  void setFrontBase64Image(String value) {
    frontBase64Image.value = value;
  }

  // Method to set back base64 image
  void setBackBase64Image(String value) {
    backBase64Image.value = value;
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