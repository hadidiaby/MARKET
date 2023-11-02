library moli.globals;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market/models/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user.dart';

Size? gblSize;
String? gbltoken;
User? globalUser;

bool gblWaiting = false;

List<OrderItem> gblCart = [];


saveCart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('cart', jsonEncode(gblCart));
}


loadCart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var cart = jsonDecode(prefs.getString('cart')??'[]')  as List;
  gblCart = cart.map((tagJson) => OrderItem.fromJson(tagJson)).toList();
}

Widget loader() {
  return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.black,
      )));
}
