import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/offer_model.dart';

class OfferFullItem extends StatelessWidget {
  final OfferModel offer;

  const OfferFullItem({Key? key, required this.offer }) : super(key: key);

  final String closeIcon = 'assets/icons/close-icon.svg';

  void closeModal (BuildContext ctx) => Navigator.pop(ctx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                offer.imageUrl,
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
              ),
              Positioned(
                top: 15,
                right: 15,
                child: GestureDetector(
                  onTap: () => closeModal(context),
                  child: SvgPicture.asset(
                    closeIcon,
                    semanticsLabel: 'App Logo',
                  ),
                ),
              ),
        
            ],
          )
        ],
      ),
    );
  }
}
