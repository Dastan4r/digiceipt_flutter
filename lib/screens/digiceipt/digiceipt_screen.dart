import 'package:flutter/material.dart';

import '../../widgets/app/custom_app_bar.dart';

import '../../models/receipt_item_model.dart';

class DigiceiptScreen extends StatefulWidget {
  static const String routeName = '/digiceipt';

  const DigiceiptScreen({Key? key}) : super(key: key);

  @override
  State<DigiceiptScreen> createState() => _DigiceiptScreenState();
}

class _DigiceiptScreenState extends State<DigiceiptScreen> {
  @override
  Widget build(BuildContext context) {
    final ReceiptModel currentDigiceipt =
        ModalRoute.of(context)!.settings.arguments as ReceiptModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Digiceipt',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            currentDigiceipt.receipt.download_url.toString(),
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
