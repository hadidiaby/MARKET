class CartItemModel {
  late final String imagePath;
  late final String name;
  late final String price;

  CartItemModel({
    required this.imagePath,
    required this.name,
    required this.price,
  });

  static final cartItemList = [
    CartItemModel(
      imagePath: "assets/images/pepper_red.png",
      name: "Poivron rouge",
      price: "1kg, 100 fcfa",
    ),
    CartItemModel(
      imagePath: "assets/images/butternut.png",
      name: "Courgette",
      price: "1kg, 1000 fcfa",
    ),
    CartItemModel(
      imagePath: "assets/images/ginger.png",
      name: "gingembre",
      price: "1kg, 850 fcfa",
    ),
    CartItemModel(
      imagePath: "assets/images/carrots.png",
      name: "carottes",
      price: "1kg, 850 fcfa",
    ),
  ];

  // Méthode pour calculer le montant total du panier
  static double calculateTotalAmount() {
    double total = 0;
    for (var item in cartItemList) {
      // Extrait le prix de l'article (suppose que le prix est une chaîne au format "1kg, XXX fcfa")
      final priceParts = item.price.split(', ');
      if (priceParts.length == 2) {
        final priceValue = double.tryParse(priceParts[1]);
        if (priceValue != null) {
          total += priceValue;
        }
      }
    }
    return total;
  }
}
