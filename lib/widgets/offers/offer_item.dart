import 'package:flutter/material.dart';

import '../../models/offer_model.dart';

class OfferItemWidget extends StatelessWidget {
  final OfferModel item;
  void Function(BuildContext, dynamic) navigateToOffer;

  OfferItemWidget({Key? key, required this.item, required this.navigateToOffer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToOffer(context, item);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(item.imageUrl),
          const SizedBox(height: 6),
          Text(
            item.name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Row(
            children: [
              Text(
                '\$${item.discountPrice.toString()}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(width: 5),
              Text(
                '\$${item.originPrice.toString()}',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          )
        ],
      ),
    );
  }
}
