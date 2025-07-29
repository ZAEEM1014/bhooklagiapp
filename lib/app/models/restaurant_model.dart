class Restaurant {
  final String id;
  final String name;
  final String image;
  final double rating;
  final int reviews;
  final String category;
  final String deliveryTime;
  final String offer;
  final bool isAd;
  final bool freeDelivery;


  final List<Offer> offers;
  final List<Section> sections;

  Restaurant({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.category,
    required this.deliveryTime,
    required this.offer,
    required this.isAd,
    required this.freeDelivery,
    required this.offers,
    required this.sections,


  });
}

class Offer {
  final String title;
  final String description;

  Offer({required this.title, required this.description});
}

class Section {
  final String title;
  final List<Product> products;

  Section({required this.title, required this.products});
}

class Product {
  final String name;
  final String image;
  final double price;
  final String description; // ✅ Add this line

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.description, // ✅ This now matches the field above
  });
}

