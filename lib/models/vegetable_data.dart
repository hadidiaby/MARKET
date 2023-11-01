class VegetableItemModel {
  late final String imagePath;
  late final String name;
  late final String price;
  VegetableItemModel(
      {required this.imagePath, required this.name, required this.price});
  static final vegetableItemList = [
    VegetableItemModel(
        imagePath: "assets/images/pepper_red.png",
        name: "Poivron",
        price: "1kg, 500 fcfa"),
    VegetableItemModel(
        imagePath: "assets/images/butternut.png",
        name: "Courgette ",
        price: "1kg, 950 fcfa"),
    VegetableItemModel(
        imagePath: "assets/images/ginger.png",
        name: "gingimbre",
        price: "1kg, 300 fcfa"),
    VegetableItemModel(
        imagePath: "assets/images/carrots.png",
        name: "carrots",
        price: "1kg, 300 fcfa"),
    VegetableItemModel(
        imagePath: "assets/images/pepper_red.png",
        name: "Poivron rouge",
        price: "1kg, 500 fcfa"),
    VegetableItemModel(
        imagePath: "assets/images/butternut.png",
        name: "Courgette ",
        price: "1kg, 850 fcfa"),
    VegetableItemModel(
        imagePath: "assets/images/ginger.png",
        name: "gingimbre",
        price: "1kg, 300 fcfa"),
    VegetableItemModel(
        imagePath: "assets/images/carrots.png",
        name: "carrots",
        price: "1kg, 300 fcfa"),
  ];
}
