import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home/home_tabs.dart';
import '../digiceipts_details/digiceipts_details_screen.dart';

class CameraScreen extends StatefulWidget {
  static const String routeName = '/camera';

  // ignore: prefer_typing_uninitialized_variables
  final cameras;

  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeCameraFuture;
  int selectedCamera = 0;
  List<File> _capturedImages = [];
  bool isCameraFlash = false;

  final String closeCameraIcon = 'assets/icons/close-camera-icon.svg';

  final String flashCameraIcon = 'assets/icons/flash-camera-icon.svg';
  final String saveImagesIcon = 'assets/icons/save-images-icon.svg';
  final String flashCameraDisabledIcon =
      'assets/icons/flash-camera-disabled-icon.svg';
  final String cameraOverlay = 'assets/icons/camera-overlay.svg';

  void initializeCamera() async {
    _controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    _initializeCameraFuture = _controller.initialize();
  }

  void toggleCameraFlash() {
    _controller.setFlashMode(!isCameraFlash ? FlashMode.torch : FlashMode.off);

    setState(() {
      isCameraFlash = !isCameraFlash;
    });
  }

  void navigateToHome(BuildContext ctx) {
    Navigator.of(ctx).pushReplacementNamed(HomeTabs.routeName);
  }

  void navigateToDetailScreen(BuildContext ctx) {
    Navigator.of(context)
        .pushNamed(DigiceiptsDetailScreen.routeName, arguments: _capturedImages)
        .then((value) {
      setState(() {
        _capturedImages = value as List<File>;
      });
    });
  }

  takePicture() async {
    await _initializeCameraFuture;
    XFile xFile = await _controller.takePicture();
    setState(() {
      _capturedImages.add(File(xFile.path));
    });
  }

  @override
  void initState() {
    initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const CircularProgressIndicator(color: Colors.white);
                }
              },
              future: _initializeCameraFuture,
            ),
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 10,
              left: 16,
              child: GestureDetector(
                onTap: () => navigateToHome(context),
                child: SvgPicture.asset(
                  closeCameraIcon,
                  semanticsLabel: 'Close camera',
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).viewPadding.top + 10,
              right: 16,
              child: GestureDetector(
                onTap: toggleCameraFlash,
                child: SvgPicture.asset(
                  isCameraFlash ? flashCameraIcon : flashCameraDisabledIcon,
                  semanticsLabel: 'Close camera',
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 16,
              right: 16,
              child: SvgPicture.asset(
                cameraOverlay,
                width: MediaQuery.of(context).size.width - 32,
                height: MediaQuery.of(context).size.height * 0.6,
                semanticsLabel: 'Close camera',
              ),
            ),
            if (_capturedImages.isNotEmpty)
              Positioned(
                bottom: MediaQuery.of(context).viewPadding.bottom + 100,
                left: MediaQuery.of(context).size.width / 4,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(32, 32, 32, 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    '${_capturedImages.length} digiceipt(s) captured',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(255, 255, 255, 0.7),
                    ),
                  ),
                ),
              ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 33,
              bottom: MediaQuery.of(context).viewPadding.bottom + 16,
              child: GestureDetector(
                onTap: takePicture,
                child: Container(
                  width: 66,
                  height: 66,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(33),
                    border: Border.all(width: 3, color: Colors.white),
                  ),
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(33),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (_capturedImages.isNotEmpty)
              Positioned(
                right: 16,
                bottom: MediaQuery.of(context).viewPadding.bottom + 30,
                child: GestureDetector(
                  onTap: () => navigateToDetailScreen(context),
                  child: SvgPicture.asset(
                    saveImagesIcon,
                    semanticsLabel: 'Save images',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
