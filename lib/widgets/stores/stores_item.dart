import 'package:flutter/material.dart';

import '../../models/store_model.dart';

class StoresItemWidget extends StatelessWidget {
  final StoreModel item;

  const StoresItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        ],
      ),
    );
  }
}
