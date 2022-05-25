class OfferModel {
  final String name;
  final String id;
  final String imageUrl;
  final double originPrice;
  final double discountPrice;

  OfferModel({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.originPrice,
    required this.discountPrice,
  });
}
