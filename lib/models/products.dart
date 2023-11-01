// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    int? id;
    String? image;
    String? name;
    int? price;
    String? description;
    int? city;

    Product({
        this.id,
        this.image,
        this.name,
        this.price,
        this.description,
        this.city,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "price": price,
        "description": description,
        "city": city,
    };
}
