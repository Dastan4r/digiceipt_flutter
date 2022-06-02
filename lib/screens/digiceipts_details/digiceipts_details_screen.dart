import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/digiceipts_provider.dart';
// import '../../models/upload_receipt_model.dart';
import '../../screens/home/home_tabs.dart';

class DigiceiptsDetailScreen extends StatefulWidget {
  static const String routeName = '/digiceipts-details';

  const DigiceiptsDetailScreen({Key? key}) : super(key: key);

  @override
  State<DigiceiptsDetailScreen> createState() => _DigiceiptsDetailScreenState();
}

class _DigiceiptsDetailScreenState extends State<DigiceiptsDetailScreen> {
  final String closeCameraIcon = 'assets/icons/close-camera-icon.svg';

  List<Io.File> _capturedImages = [];
  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        _capturedImages =
            ModalRoute.of(context)!.settings.arguments as List<Io.File>;
      });
    });
    super.initState();
  }

  void deleteCameraReceipt(Io.File image) {
    setState(() {
      _capturedImages =
          _capturedImages.where((element) => element != image).toList();
    });
  }

  void navigationBackToCamera(BuildContext ctx) {
    Navigator.of(context).pop(_capturedImages);
  }

  void saveDigiceipts(BuildContext ctx) async {
    List<Map<String, dynamic>> data = [];

    if (_capturedImages.isNotEmpty) {
      for (var element in _capturedImages) {
        final bytes = Io.File(element.path).readAsBytesSync();

        String img64 = base64Encode(bytes);

        data.add({
          'receipt': {
            'image': 'data:image/jpg;base64,$img64',
            'title': '',
          },
          'tags': [],
        });
      }
    }

    if (data.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<DigiceiptsProvider>(ctx, listen: false)
          .uploadDigiceipts(data)
          .then((_) {
        setState(() {
          isLoading = false;

          Navigator.pushReplacementNamed(context, HomeTabs.routeName);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Digiceipts",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: GestureDetector(
                onTap: () => navigationBackToCamera(context),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: [
          SizedBox(
            width: 50,
            height: 50,
            child: TextButton(
              onPressed: () => saveDigiceipts(context),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Save"),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _capturedImages.isEmpty
              ? Center(
                  child: Text('You dont have any captured digiceipt now', style: Theme.of(context).textTheme.headline3,))
              : GridView.count(
                  primary: false,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: _capturedImages
                      .map((image) => Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  image,
                                  width:
                                      MediaQuery.of(context).size.width / 2 - 22,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 1,
                                child: GestureDetector(
                                  onTap: () => deleteCameraReceipt(image),
                                  child: SvgPicture.asset(
                                    closeCameraIcon,
                                    width: 25,
                                    height: 25,
                                    semanticsLabel: 'Close camera',
                                  ),
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
        ),
      ),
    );
  }
}
