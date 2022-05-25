import 'package:flutter/material.dart';

class CategoryHeader extends StatelessWidget {
  final String title;

  const CategoryHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsetsDirectional.only(top: 10),
      child: SizedBox(
        height: 30.0,
        width: double.infinity,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
