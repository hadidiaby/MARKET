// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:market/models/products.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
    int? id;
    List<OrderItem>? orderItems;
    DateTime? orderingDate;
    int? orderedBy;

    Order({
        this.id,
        this.orderItems,
        this.orderingDate,
        this.orderedBy,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        orderItems: json["order_items"] == null ? [] : List<OrderItem>.from(json["order_items"]!.map((x) => OrderItem.fromJson(x))),
        orderingDate: json["ordering_date"] == null ? null : DateTime.parse(json["ordering_date"]),
        orderedBy: json["ordered_by"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_items": orderItems == null ? [] : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "ordering_date": orderingDate?.toIso8601String(),
        "ordered_by": orderedBy,
    };
}

class OrderItem {
    int? id;
    int? price;
    int? quantity;
    int? order;
    Product? product;

    OrderItem({
        this.id,
        this.price,
        this.quantity,
        this.order,
        this.product,
    });

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        price: json["price"],
        quantity: json["quantity"],
        order: json["order"],
        product: json["product"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "quantity": quantity,
        "order": order,
        "product": product,
    };
}
