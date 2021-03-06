import 'package:flutter/material.dart';
//import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:provider/provider.dart';

import '../../widgets/app/custom_app_bar.dart';
//import '../../widgets/home/home_button.dart';
//import '../../widgets/home/receipt_item.dart';
import '../../models/receipt_item_model.dart';
//import '../../widgets/home/category_header.dart';
import '../../screens/camera/camera_screen.dart';
import '../../screens/digiceipt/digiceipt_screen.dart';

import '../../providers/digiceipts_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  // final String _recentlyAddedIcon = 'assets/icons/recently-added-icon.svg';
  // final String _filterIcon = 'assets/icons/filter-icon.svg';

  bool isLoading = false;
  bool loadingMore = false;

  // final Map<String, List<ReceiptModel>> _items = {
  //   "2022": [
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'food',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'food',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'finance',
  //       time: DateTime.now(),
  //     ),
  //   ],
  //   "2021": [
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'finance',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'food',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'food',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'finance',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'food',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'finance',
  //       time: DateTime.now(),
  //     ),
  //   ],
  //   "2020": [
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'finance',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'food',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'food',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'finance',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'food',
  //       time: DateTime.now(),
  //     ),
  //     ReceiptModel(
  //       title: 'Receipt Name',
  //       price: 5000.00,
  //       category: 'finance',
  //       time: DateTime.now(),
  //     ),
  //   ],
  // };

  // bool _isElevationAppBar = false;

  // bool _onScroll(scrollValue) {
  //   if (scrollValue.metrics.pixels >= 40) {
  //     setState(() {
  //       _isElevationAppBar = true;
  //     });
  //   } else {
  //     setState(() {
  //       _isElevationAppBar = false;
  //     });
  //   }

  //   return true;
  // }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<DigiceiptsProvider>(context, listen: false)
          .getDigiceipts()
          .then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });

    _scrollController.addListener(_scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if ((_scrollController.position.pixels >
            (_scrollController.position.maxScrollExtent * 0.75)) &&
        !loadingMore) {
      setState(() {
        loadingMore = true;
      });
      Provider.of<DigiceiptsProvider>(context, listen: false)
          .getDigiceiptsMore()
          .then((_) {
        setState(() {
          loadingMore = false;
        });
      });
    }
  }

  void navigateToCameraScreen(BuildContext ctx) {
    Navigator.pushReplacementNamed(ctx, CameraScreen.routeName);
  }

  Future<void> _onRefresh() async {
    await Provider.of<DigiceiptsProvider>(context, listen: false)
        .getDigiceipts();
  }

  void navigateToDigiceipt(BuildContext ctx, ReceiptModel item) {
    Navigator.pushNamed(ctx, DigiceiptScreen.routeName, arguments: item);
  }

  @override
  Widget build(BuildContext context) {
    final List<ReceiptModel> digiceipts =
        Provider.of<DigiceiptsProvider>(context).digiceipts
            as List<ReceiptModel>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarWidget(
        title: 'Home',
        // withElevation: _isElevationAppBar,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToCameraScreen(context),
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : digiceipts.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Flexible(
                        child: RefreshIndicator(
                          onRefresh: _onRefresh,
                          child: GridView.builder(
                            controller: _scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 162,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => navigateToDigiceipt(
                                    context, digiceipts[index]),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  child: Image.network(
                                    digiceipts[index]
                                        .thumbnails
                                        .download_url
                                        .toString(),
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (ctx, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            itemCount: digiceipts.length,
                          ),
                        ),
                      ),
                      if (loadingMore) const CircularProgressIndicator()
                    ],
                  ),
                )
              : Center(
                  child: Text('You dont have any digiceipts',
                      style: Theme.of(context).textTheme.headline3),
                ),
    );
  }
}

// Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             const SizedBox(height: 6),
//             ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxWidth: double.infinity,
//                 maxHeight: MediaQuery.of(context).size.height / 1.5,
//               ),
//               child: NotificationListener<ScrollNotification>(
//                 onNotification: _onScroll,
//                 child: CustomScrollView(
//                   slivers: [
//                     SliverToBoxAdapter(
                      // child: Row(
                      //   children: [
                      //     HomeButton(
                      //       iconUrl: _recentlyAddedIcon,
                      //       title: "Recently added",
                      //     ),
                      //     const SizedBox(width: 10),
                      //     HomeButton(
                      //       iconUrl: _filterIcon,
                      //       title: "Filter",
                      //     ),
                      //   ],
                      // ),
//                     ),
//                     ..._items.entries.map((e) {
//                       return SliverStickyHeader(
//                         header: CategoryHeader(title: e.key),
//                         sliver: SliverList(
//                           delegate: SliverChildBuilderDelegate(
//                             (context, i) => ReceiptItem(item: e.value[i]),
//                             childCount: e.value.length,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
