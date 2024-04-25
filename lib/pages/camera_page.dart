import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'dart:convert';
import '../controllers/dashboard_controller.dart';
import 'package:image_editor/image_editor.dart' as editor;

class CameraPageWithGallery extends StatefulWidget {
  // final EmployeeUpdateController controller;
  final RxString fieldVar;
  const CameraPageWithGallery(
      {super.key, required this.fieldVar});

  @override
  State<CameraPageWithGallery> createState() => _CameraPageWithGalleryState();
}

class _CameraPageWithGalleryState extends State<CameraPageWithGallery> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  late XFile _imageFile;
  bool _isFrontCamera = false;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
    _imageFile = XFile('');
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      _isFrontCamera ? cameras[1] : cameras[0],
      ResolutionPreset.high,
    );
    return _cameraController.initialize();
  }

  Future<void> _toggleCamera() async {
    _isFrontCamera = !_isFrontCamera;
    await _initializeCamera();
  }

  Future<void> _takePicture() async {
    try {
      final XFile? image;
      // await _initializeControllerFuture;
      if (_cameraController.value.isInitialized &&
          !_cameraController.value.isTakingPicture) {
        image = await _cameraController.takePicture();
        await flipPhoto(image.path);
      }
    } catch (e) {
      log('Error taking picture: $e');
    }
  }

  Future<void> flipPhoto(String imagePath) async {
    var photofile = File(imagePath);
    Uint8List imageBytes = await photofile.readAsBytes();

    final editor.ImageEditorOption option = editor.ImageEditorOption();
    option.addOption(
      editor.FlipOption(
        horizontal: _cameraController.value.description.lensDirection ==
            CameraLensDirection.back
            ? false
            : true,
      ),
    );
    imageBytes = (await editor.ImageEditor.editImage(
      image: imageBytes,
      imageEditorOption: option,
    ))!;
    await photofile.delete();
    await photofile.writeAsBytes(imageBytes);
    _imageFile = XFile(photofile.path);
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _imageFile = XFile(pickedFile.path);
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  // ... (rest of the code remains the same)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _imageFile.path.isNotEmpty
                ? Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Image.file(
                    File(_imageFile.path),
                    fit:BoxFit.contain
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 60.0,
                        ),
                        onPressed: () async {
                          List<int> imageBytes =
                          await File(_imageFile.path).readAsBytes();
                          String base64Image = base64Encode(imageBytes);
                          log(base64Image);
                          log('Image confirmed!');
                          if (mounted) {
                            Navigator.pop(context, base64Image);
                          }
                          log("That is: $base64Image");
                          widget.fieldVar.value = base64Image;
                          setState(() {
                            _imageFile = XFile('');
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                          // Change the color to light green
                          size:
                          60.0, // Change the size to 36.0 or any other desired size
                        ),
                        onPressed: () {
                          log('Image discarded!');
                          //Navigator.of(context).pop(); // Close the dialog
                          setState(() {
                            _imageFile = XFile('');
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
                : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.maxFinite,
                child: CameraPreview(_cameraController));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xff1a1a1a),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.photo, color: Colors.white),
              onPressed: () async {
                await _pickImageFromGallery();
                setState(() {});
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.camera,
                color: Colors.white,
              ),
              onPressed: () async {
                await _takePicture();
                setState(() {});
              },
            ),
            IconButton(
              icon: const Icon(Icons.switch_camera, color: Colors.white),
              onPressed: () async {
                await _toggleCamera();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}