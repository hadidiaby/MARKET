import 'package:flutter/material.dart';
import 'package:market/api.dart';
import 'package:market/globals.dart';
import 'package:market/models/order.dart';
import 'package:market/screens/cart.dart';
import 'package:market/utils/routes.dart';

import '../models/products.dart';

class VegetableDetailScreen extends StatefulWidget {
  const VegetableDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<VegetableDetailScreen> createState() => _VegetableDetailScreenState();
}

class _VegetableDetailScreenState extends State<VegetableDetailScreen> {
  int itemCount = 0;
  

  @override
  Widget build(BuildContext context) {
    int indexOrder = gblCart
        .indexWhere((element) => widget.product.id == element.product!.id!);
    if (indexOrder != -1) {
      itemCount = gblCart[indexOrder].quantity!;
    }
    int a = 5;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffF3F5F7),
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 140.0))),
              child: Column(children: [
                SizedBox(
                  height: 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          "assets/images/back_icon.png",
                          width: 44,
                          height: 44,
                        ),
                      ),
                      Image.asset(
                        "assets/images/search_icon.png",
                        width: 44,
                        height: 44,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 0.6,
                  child: Container(
                    child: Image.network(
                      '$addressIp${widget.product.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
              ]),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.product.name ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (() {
                                OrderItem oItem = OrderItem(
                                    product: widget.product,
                                    price: widget.product.price!,
                                    quantity: 1);

                                int indexOrder = gblCart.indexWhere((element) =>
                                    widget.product.id == element.product!.id!);

                                if (indexOrder != -1) {
                                  oItem.quantity =
                                      gblCart[indexOrder].quantity! + 1;
                                  gblCart.replaceRange(
                                      indexOrder, indexOrder + 1, [oItem]);
                                } else {
                                  gblCart.add(oItem);
                                }
                                setState(() {
                                  itemCount++;
                                });
                              }),
                              child: Image.asset(
                                "assets/images/add_icon.png",
                                width: 32,
                                height: 32,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                              "$itemCount",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            InkWell(
                              onTap: () {
                                OrderItem oItem = OrderItem(
                                    product: widget.product,
                                    price: widget.product.price!,
                                    quantity: 1);

                                int indexOrder = gblCart.indexWhere((element) =>
                                    widget.product.id == element.product!.id!);

                                if (indexOrder != -1) {
                                  if (itemCount == 0) {
                                    gblCart.removeAt(indexOrder);
                                  } else {
                                    oItem.quantity =
                                        gblCart[indexOrder].quantity! - 1;

                                    gblCart.replaceRange(
                                        indexOrder, indexOrder + 1, [oItem]);
                                  }
                                }

                                setState(() {
                                  if (itemCount > 0) itemCount--;
                                });
                              },
                              child: Image.asset(
                                "assets/images/remove_icon.png",
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("1kg, ${widget.product.price}fcfa",
                      style: TextStyle(
                          color: Color(0xffFF324B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.product.description ?? '',
                    style: TextStyle(
                        color: Color(0xff979899),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      _itemKeyPointsView(
                          "assets/images/organic.png", "100%", "Organic"),
                      SizedBox(
                        width: 8,
                      ),
                      _itemKeyPointsView("assets/images/expiration.png",
                          "1 Year", "Expiration")
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      _itemKeyPointsView(
                          "assets/images/reviews.png", "4.8", "Reviews"),
                      SizedBox(
                        width: 8,
                      ),
                      _itemKeyPointsView(
                          "assets/images/calories.png", "80 kcal", "100 Gram")
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()),
                          );
                          // Navigator.pushNamed(context, MyRoutes.cartRoute);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          shape: StadiumBorder(),
                          backgroundColor: Color(0xff23AA49),
                        ),
                        child: Text("Ajouter au panier")),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemKeyPointsView(String imagePath, String title, String desc) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: Color(0xffF1F1F5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff23AA49)),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(desc,
                    style: TextStyle(fontSize: 14, color: Color(0xff979899))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
