class ProductEntity {
  final int id;
  final String title;
  final String status;
  final String price;
  final double rating;
  final String transmission;
  final String image;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.price,
    required this.rating,
    required this.transmission,
    required this.image,
  });
}
