import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../widgets/app/custom_app_bar.dart';
import '../../widgets/offers/offer_item.dart';
import '../../widgets/offers/offer_full_item.dart';
import '../../models/offer_model.dart';

class OffersScreen extends StatelessWidget {
  static const routeName = '/offers';

  OffersScreen({Key? key}) : super(key: key);

  final List<OfferModel> _offers = [
    OfferModel(
      discountPrice: 29.99,
      name: 'Offer name',
      imageUrl: 'assets/images/offer-image.png',
      originPrice: 39.99,
      id: 'gdsfg',
    ),
    OfferModel(
      discountPrice: 29.99,
      name: 'Offer name',
      imageUrl: 'assets/images/offer-image.png',
      originPrice: 39.99,
      id: 'dfghdfgh',
    ),
    OfferModel(
      discountPrice: 29.99,
      name: 'Offer name',
      imageUrl: 'assets/images/offer-image.png',
      originPrice: 39.99,
      id: 'ertwet',
    ),
    OfferModel(
      discountPrice: 29.99,
      name: 'Offer name',
      imageUrl: 'assets/images/offer-image.png',
      originPrice: 39.99,
      id: 'qeqwer',
    ),
    OfferModel(
      discountPrice: 29.99,
      name: 'Offer name',
      imageUrl: 'assets/images/offer-image.png',
      originPrice: 39.99,
      id: 'cvxb',
    ),
    OfferModel(
      discountPrice: 29.99,
      name: 'Offer name',
      imageUrl: 'assets/images/offer-image.png',
      originPrice: 39.99,
      id: 'mbmnjt',
    ),
    OfferModel(
      discountPrice: 29.99,
      name: 'Offer name',
      imageUrl: 'assets/images/offer-image.png',
      originPrice: 39.99,
      id: 'tyghfd',
    ),
    OfferModel(
      discountPrice: 29.99,
      name: 'Offer name',
      imageUrl: 'assets/images/offer-image.png',
      originPrice: 39.99,
      id: 'fghjgf',
    ),
  ];

  void navigateToOffer(BuildContext ctx, item) {
    showCupertinoModalBottomSheet(
      context: ctx,
      builder: (ctx) => OfferFullItem(offer: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Offers'),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 262,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return OfferItemWidget(
                item: _offers[index],
                navigateToOffer: navigateToOffer,
              );
            },
            itemCount: _offers.length,
          ),
        ),
      ),
    );
  }
}
