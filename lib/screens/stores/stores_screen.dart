import 'package:flutter/material.dart';

import '../../widgets/app/custom_app_bar.dart';
import '../../models/store_model.dart';
import '../../widgets/stores/stores_item.dart';

class StoresScreen extends StatelessWidget {
  static const routeName = '/stores';

  StoresScreen({Key? key}) : super(key: key);

  final List<StoreModel> _stores = [
    StoreModel(
      id: 'sghjkhjdf',
      imageUrl: 'assets/images/store-image.png',
      name: 'Store name',
    ),
    StoreModel(
      id: 'sdf',
      imageUrl: 'assets/images/store-image.png',
      name: 'Store name',
    ),
    StoreModel(
      id: 'hjklhj',
      imageUrl: 'assets/images/store-image.png',
      name: 'Store name',
    ),
    StoreModel(
      id: 'asdf',
      imageUrl: 'assets/images/store-image.png',
      name: 'Store name',
    ),
    StoreModel(
      id: 'jghklhj',
      imageUrl: 'assets/images/store-image.png',
      name: 'Store name',
    ),
    StoreModel(
      id: 'sdfhghjk',
      imageUrl: 'assets/images/store-image.png',
      name: 'Store name',
    ),
    StoreModel(
      id: 'aasdgg',
      imageUrl: 'assets/images/store-image.png',
      name: 'Store name',
    ),
    StoreModel(
      id: 'sdfg',
      imageUrl: 'assets/images/store-image.png',
      name: 'Store name',
    ),
    StoreModel(
      id: 'dhdh',
      imageUrl: 'assets/images/store-image.png',
      name: 'Store name',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(title: 'Stores'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 19,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Text('Fashion, Electronics, Food +1'),
                ),
              ),
              const SizedBox(height: 25),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 200,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return StoresItemWidget(item: _stores[index]);
                  },
                  itemCount: _stores.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
