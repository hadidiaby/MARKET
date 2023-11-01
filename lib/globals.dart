library moli.globals;

import 'package:flutter/material.dart';
import 'models/user.dart';

Size? gblSize;
String? gbltoken;
User? globalUser;

bool gblWaiting = false;



Widget loader() {
  return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.black,
      )));
}