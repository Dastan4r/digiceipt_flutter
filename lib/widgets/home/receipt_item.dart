import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/receipt_item_model.dart';

class ReceiptItem extends StatelessWidget {
  final ReceiptModel item;

  const ReceiptItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        maxHeight: 64,
      ),
      child: Row(
        children: [
          Image.asset('assets/images/${item.category}-category-image.png'),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      '\$${item.price}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.category,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.grey),
                    ),
                    Text(
                      DateFormat('d MMM').format(item.time),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
