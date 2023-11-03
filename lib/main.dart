import 'package:flutter/material.dart';
import 'package:market/components/login_page.dart';
import 'package:market/globals.dart';
import 'package:market/models/user.dart';
import 'package:market/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';







void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _loading = true;
  Widget _toShow = loader();

  @override
  void initState() {
    super.initState();
    _loadPref();
    _toShow = loader();
  }

  _loadPref() async {
    // loadSavedData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Widget home = const LoginPage();
    gbltoken = (prefs.getString('token') ?? '');
    print("===========gbltoken :$gbltoken");
    if (gbltoken != '') {
      globalUser = userFromJson(prefs.getString('user') ?? '');

      // API.retrieveUser(globalUser!.id);
      home = const DashboardScreen();
    } else {
      home = const LoginPage();
    }
    setState(() {
      _toShow = home;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (_loading) ? loader() : _toShow,
    );
  }
}




