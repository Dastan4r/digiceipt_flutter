import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../widgets/app/custom_app_bar.dart';
import '../../widgets/home/home_button.dart';
import '../../widgets/home/receipt_item.dart';
import '../../models/receipt_item_model.dart';
import '../../widgets/home/category_header.dart';
import '../../screens/camera/camera_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _recentlyAddedIcon = 'assets/icons/recently-added-icon.svg';
  final String _filterIcon = 'assets/icons/filter-icon.svg';

  final Map<String, List<ReceiptModel>> _items = {
    "2022": [
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'food',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'food',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'finance',
        time: DateTime.now(),
      ),
    ],
    "2021": [
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'finance',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'food',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'food',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'finance',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'food',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'finance',
        time: DateTime.now(),
      ),
    ],
    "2020": [
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'finance',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'food',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'food',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'finance',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'food',
        time: DateTime.now(),
      ),
      ReceiptModel(
        title: 'Receipt Name',
        price: 5000.00,
        category: 'finance',
        time: DateTime.now(),
      ),
    ],
  };

  bool _isElevationAppBar = false;

  bool _onScroll(scrollValue) {
    if (scrollValue.metrics.pixels >= 40) {
      setState(() {
        _isElevationAppBar = true;
      });
    } else {
      setState(() {
        _isElevationAppBar = false;
      });
    }

    return true;
  }

  void navigateToCameraScreen (BuildContext ctx) {
    Navigator.pushReplacementNamed(context, CameraScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarWidget(
        title: 'Home',
        withElevation: _isElevationAppBar,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToCameraScreen(context),
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 6),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: double.infinity,
                maxHeight: MediaQuery.of(context).size.height / 1.5,
              ),
              child: NotificationListener<ScrollNotification>(
                onNotification: _onScroll,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          HomeButton(
                            iconUrl: _recentlyAddedIcon,
                            title: "Recently added",
                          ),
                          const SizedBox(width: 10),
                          HomeButton(
                            iconUrl: _filterIcon,
                            title: "Filter",
                          ),
                        ],
                      ),
                    ),
                    ..._items.entries.map((e) {
                      return SliverStickyHeader(
                        header: CategoryHeader(title: e.key),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, i) => ReceiptItem(item: e.value[i]),
                            childCount: e.value.length,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
