import 'package:flutter/material.dart';
import 'package:market/globals.dart';
import 'package:market/screens/livraison.dart';
import '../models/cart_data.dart';
import '../widgets/cart_item.dart';
import 'package:market/utils/routes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var price_total=0;
    for (var order_item in gblCart) {
      price_total += (order_item.price)! * (order_item.quantity)!;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
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
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: gblCart.length,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  item: gblCart[index],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LivraisonScreen()),
                      );
                      // Navigator.pushNamed(context, MyRoutes.livraisonRoute);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      shape: StadiumBorder(),
                      backgroundColor: Color(0xff23AA49),
                    ),
                    child: price_total !=0
                    ?
                    Text("Commander pour : $price_total F CFA")
                    :Text("Commander")),
              )
            ]),
          )
        ],
      ),
    );
  }
}
