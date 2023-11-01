// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:market/globals.dart';
import 'package:market/models/order.dart';
import 'package:market/models/products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'models/user.dart';



const address = "http://192.168.43.196:8000";
// const address = "http://192.168.1.3:8000";
const ipAddressApi = "$address/api";


class API {
  static Map<String, String> headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Token $gbltoken'
  };

  static Future<String> generateToken(String phoneNumber) async {
    phoneNumber = phoneNumber;
    final response = await http.get(
      Uri.parse(
          '$ipAddressApi/generate-token/${phoneNumber.replaceAll(' ', '')}'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      // showSuccess(data['message'].toString());
      return (data['message']).toString();
    } else {
      // showErrorToast(null);
      return 'une erreur est survenue';
    }
  }

  static Future<bool> verifyPhoneNumber(
      String phoneNumber, String defaultToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$ipAddressApi/verify-phone-number/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'phoneNumber': phoneNumber.replaceAll(' ', ''),
        'defaultToken': defaultToken,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data['success'] == true) {
        gbltoken = data['data']['token'];
        globalUser = (data['data']['user'] != null)
            ? User.fromJson(data['data']['user'])
            : null;
        if (gbltoken != null) {
          await prefs.setString('token', gbltoken!);
          await prefs.setString('user', jsonEncode(globalUser));
        }
      }
      //showSuccess(data['message'].toString());
      return data['success'];
    } else {
      // showErrorToast("Le code saisie est incorrect veuillez reessayer");
      return false;
    }
  }

  static Future<bool> inscription(String phoneNumber, String firstName,
      String lastName, String password, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Uri uriUser = Uri.parse('$ipAddressApi/account/signup/');
    final response = await http.post(
      uriUser,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "phoneNumber": phoneNumber.replaceAll(' ', ''),
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
        "email": email,
      }),
    );
    if ([200, 201].contains(response.statusCode)) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data['success'] == true) {
        //showSuccess(data['message'].toString());
        gbltoken = data['data']['token'];
        print(gbltoken);
        globalUser = User.fromJson(data['data']['user']);

        if (gbltoken != null) {
          await prefs.setString('token', gbltoken!);
          await prefs.setString('user', jsonEncode(globalUser));
        }
      }
      return true;
    } else {
      return false;
    }
  }
  static Future<bool> login(String password, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Uri uriUser = Uri.parse('$ipAddressApi/account/login/');
    final response = await http.post(
      uriUser,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
       
        "password": password,
        "email": email,
      }),
    );
    if ([200, 201].contains(response.statusCode)) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data['success'] == true) {
        //showSuccess(data['message'].toString());
        gbltoken = data['data']['token'];
        print(gbltoken);
        globalUser = User.fromJson(data['data']['user']);

        if (gbltoken != null) {
          await prefs.setString('token', gbltoken!);
          await prefs.setString('user', jsonEncode(globalUser));
        }
      }
      return true;
    } else {
      return false;
    }
  }




  static Future<List<Product>> getProducts() async {
    Uri uri = Uri.parse('$ipAddressApi/products/products/');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var jsontolist = data['data'] as List;
      return jsontolist.map((tagJson) => Product.fromJson(tagJson)).toList();
    } else {
      print('produits introuvable');
      return [];
    }
  }


   static Future<Order?> passOrder(List<OrderItem> orderItems,
      List<OrderItem> extras, int? total, int? deliveryFee, bool meal) async {
    Uri uri = Uri.parse('$ipAddressApi/orders/');
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String?, dynamic>{
        // "status": 0,
        "total": total,
        "deliveringFee": deliveryFee,
        "mark": "",
        "comment": "",
        "ordered_by": globalUser!.id,
        "order_items": orderItems.map((tagJson) => tagJson.toJson()).toList(),
        "extras": extras.map((tagJson) => tagJson.toJson()).toList()
      }),
    );
    if (response.statusCode == 201) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return Order.fromJson(data['data']['order']);
    }
    return null;
  }

  
  









}
