import 'package:flutter/material.dart';
import 'package:market/api.dart';

import 'package:market/models/products.dart';
import 'package:market/screens/vegetable_detail.dart';
// import '../models/vegetable_data.dart';
import '../widgets/vegetable_card.dart';

class VegetablesScreen extends StatefulWidget {
  const VegetablesScreen({Key? key}) : super(key: key);

  @override
  State<VegetablesScreen> createState() => _VegetablesScreenState();
}

class _VegetablesScreenState extends State<VegetablesScreen> {
  @override
  void initState() {
    API.getProducts().then((value) {
      setState(() {
        _products = value;
      });
    });
    super.initState();
  }

  List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Vegetables",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Image.asset(
            "assets/images/back_icon.png",
            scale: 2.2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            mainAxisExtent: 225,
          ),
          itemBuilder: (context, index) {
            return VegetableCardWidget(
              imagePath: '$addressIp${_products[index].image}',
              name: _products[index].name ?? '',
              price: '${_products[index].price ?? 0} FCFA',
              onTapCallback: () {
               

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VegetableDetailScreen(
                            product: _products[index],
                          )),
                );
              },
            );
          },
          itemCount: _products.length,
        ),
      ),
    );
  }
}
