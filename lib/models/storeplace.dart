// To parse this JSON data, do
//
//     final storePlace = storePlaceFromJson(jsonString);

import 'dart:convert';

StorePlace storePlaceFromJson(String str) => StorePlace.fromJson(json.decode(str));

String storePlaceToJson(StorePlace data) => json.encode(data.toJson());

class StorePlace {
    int? id;
    String? name;
    String? address;

    StorePlace({
        this.id,
        this.name,
        this.address,
    });

    factory StorePlace.fromJson(Map<String, dynamic> json) => StorePlace(
        id: json["id"],
        name: json["name"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
    };
}
