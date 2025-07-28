import 'package:get/get.dart';
import '../../app/models/restaurant_model.dart';
import '../../constants/app_assets.dart';


class RestaurantController extends GetxController {
  /// List of available filters
  final filters = <String>[
    "All",
    "Fast Delivery",
    "Top Rated",
    "Free Delivery",
    "Offers",
  ].obs;

  /// List of restaurants
  final restaurants = <Restaurant>[
    Restaurant(
      name: "Spice Hub",
      image: AppAssets.burger, // Cover Image
      rating: 4.3,
      reviews: 120,
      category: "Biryani, Curry",
      deliveryTime: "30-40 mins",
      offer: "20% OFF",
      isAd: true,
      freeDelivery: true,
      offers: [
        Offer(title: "20% OFF", description: "Min. order Rs. 300"),
        Offer(title: "Rs. 50 Cashback", description: "With EasyPaisa"),
        Offer(title: "Free Drink", description: "On orders above Rs. 500"),
      ],
      sections: [
        Section(
          title: "Biryani Specials",
          products: [
            Product(name: "Chicken Biryani", image: AppAssets.burger, price: 299, description: "Classic spiced chicken biryani served with raita."),
            Product(name: "Beef Biryani", image: AppAssets.burger, price: 349, description: "Tender beef layered with fragrant basmati rice."),
            Product(name: "Sindhi Biryani", image: AppAssets.burger, price: 329, description: "Zesty and rich Sindhi-style biryani."),
            Product(name: "Boneless Chicken Biryani", image: AppAssets.burger, price: 369, description: "Flavorful boneless chicken cooked in biryani spices."),
          ],
        ),
        Section(
          title: "Curries",
          products: [
            Product(name: "Chicken Karahi (Half)", image: AppAssets.burger, price: 499, description: "Spicy chicken karahi cooked in tomatoes and spices."),
            Product(name: "Beef Korma", image: AppAssets.burger, price: 479, description: "Slow-cooked beef in creamy korma gravy."),
            Product(name: "Paneer Handi", image: AppAssets.burger, price: 399, description: "Soft paneer cubes in buttery tomato gravy."),
            Product(name: "Chicken Jalfrezi", image: AppAssets.burger, price: 459, description: "Stir-fried chicken with capsicum and onions."),
          ],
        ),
        Section(
          title: "BBQ",
          products: [
            Product(name: "Chicken Tikka", image: AppAssets.burger, price: 180, description: "Chargrilled spicy chicken thigh piece."),
            Product(name: "Beef Seekh Kebab", image: AppAssets.burger, price: 250, description: "Minced beef kebabs with desi spices."),
            Product(name: "Chicken Malai Boti", image: AppAssets.burger, price: 300, description: "Creamy and tender chicken boti."),
            Product(name: "Beef Boti", image: AppAssets.burger, price: 320, description: "Spiced beef cubes grilled to perfection."),
          ],
        ),
        Section(
          title: "Burgers & Wraps",
          products: [
            Product(name: "Zinger Burger", image: AppAssets.burger, price: 350, description: "Crispy fried chicken fillet in a bun."),
            Product(name: "Beef Cheese Burger", image: AppAssets.burger, price: 380, description: "Juicy beef patty with melted cheese."),
            Product(name: "Grilled Chicken Wrap", image: AppAssets.burger, price: 320, description: "Smoky grilled chicken wrapped in tortilla."),
            Product(name: "Crispy Wrap", image: AppAssets.burger, price: 310, description: "Crunchy chicken bites wrapped with sauce."),
          ],
        ),
        Section(
          title: "Snacks & Sides",
          products: [
            Product(name: "Masala Fries", image: AppAssets.burger, price: 150, description: "French fries tossed in tangy masala."),
            Product(name: "Nuggets (6 pcs)", image: AppAssets.burger, price: 199, description: "Golden chicken nuggets with dip."),
            Product(name: "Garlic Bread", image: AppAssets.burger, price: 120, description: "Toasted bread with garlic butter."),
            Product(name: "Cheese Balls", image: AppAssets.burger, price: 220, description: "Crispy outside, cheesy inside balls."),
          ],
        ),
        Section(
          title: "Desserts",
          products: [
            Product(name: "Gulab Jamun", image: AppAssets.burger, price: 120, description: "Soft syrup-soaked sweet dumplings."),
            Product(name: "Kheer", image: AppAssets.burger, price: 130, description: "Traditional rice pudding."),
            Product(name: "Chocolate Lava Cake", image: AppAssets.burger, price: 250, description: "Molten chocolate-filled cake."),
            Product(name: "Ice Cream Scoop", image: AppAssets.burger, price: 100, description: "Single scoop of premium ice cream."),
          ],
        ),
        Section(
          title: "Beverages",
          products: [
            Product(name: "Pepsi 500ml", image: AppAssets.burger, price: 80, description: "Chilled Pepsi bottle."),
            Product(name: "7Up 500ml", image: AppAssets.burger, price: 80, description: "Refreshing 7Up."),
            Product(name: "Mint Margarita", image: AppAssets.burger, price: 150, description: "Cool mint margarita shake."),
            Product(name: "Cold Coffee", image: AppAssets.burger, price: 200, description: "Iced coffee with whipped topping."),
          ],
        ),
      ], id: 'spice_hub',
    ),





    Restaurant(
      name: "Burger Fix",
      image: AppAssets.burger,
      rating: 4.6,
      reviews: 95,
      category: "Burgers, Fast Food",
      deliveryTime: "25 mins",
      offer: "Free Drink",
      isAd: false,
      freeDelivery: false,
      offers: [
        Offer(title: "Free Drink", description: "With any burger"),
      ],

      sections: [
        Section(
          title: "Classic Burgers",
          products: [
            Product(
              name: "Zinger Burger",
              image: AppAssets.burger,
              price: 399,
              description: "Crispy chicken fillet with lettuce, mayo, and bun.",
            ),
            Product(
              name: "Beef Burger",
              image: AppAssets.burger,
              price: 449,
              description: "Juicy beef patty with cheese, onions, and sauces.",
            ),
          ],
        ),
        Section(
          title: "Loaded Fries",
          products: [
            Product(
              name: "Cheesy Fries",
              image: AppAssets.fries,
              price: 249,
              description: "Crispy fries topped with melted cheddar cheese.",
            ),
          ],
        ),
      ], id: 'burger_fix',
    ),
    Restaurant(
      name: "Pizza Mania",
      image: AppAssets.pizza,
      rating: 4.2,
      reviews: 150,
      category: "Pizza, Italian",
      deliveryTime: "40 mins",
      offer: "Buy 1 Get 1 Free",
      isAd: true,
      freeDelivery: true,
      offers: [
        Offer(title: "Buy 1 Get 1", description: "On medium size pizzas"),
      ],

      sections: [
        Section(
          title: "Medium Pizzas",
          products: [
            Product(
              name: "Pepperoni Pizza",
              image: AppAssets.pizza,
              price: 999,
              description: "Classic pepperoni slices over mozzarella and tomato sauce.",
            ),
            Product(
              name: "Fajita Pizza",
              image: AppAssets.pizza,
              price: 949,
              description: "Spicy chicken fajita flavor on a cheesy crust.",
            ),
          ],
        ),
        Section(
          title: "Large Pizzas",
          products: [
            Product(
              name: "Chicken Supreme",
              image: AppAssets.pizza,
              price: 1399,
              description: "Loaded with grilled chicken, veggies, and extra cheese.",
            ),
          ],
        ),
      ], id: 'pizza_mannia',
    ),

  ].obs;
}
