import 'package:flutter/material.dart';
import 'package:market/globals.dart';
import 'package:market/screens/livraison.dart';
import '../models/order.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<OrderItem> _dupCart = gblCart;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var priceTotal = 0;
    for (var order_item in _dupCart) {
      priceTotal += (order_item.price)! * (order_item.quantity)!;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
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
                return const Divider();
              },
              itemCount: _dupCart.length,
              itemBuilder: (context, index) {
                return CartItemWidget(
                  item: _dupCart[index],
                  add: () {
                    gblCart[index].quantity = gblCart[index].quantity! + 1;

                  
                    setState(() {
                      _dupCart = gblCart;
                    });
                  },
                  remove: () {
                    if (gblCart[index].quantity! - 1 == 0) {
                      gblCart.removeAt(index);
                    } else {
                      gblCart[index].quantity = gblCart[index].quantity! - 1;
                    }
              
                    setState(() {
                      _dupCart = gblCart;
                    });
                  },
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
                            builder: (context) => const LivraisonScreen()),
                      );
                      // Navigator.pushNamed(context, MyRoutes.livraisonRoute);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle:
                          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xff23AA49),
                    ),
                    child: priceTotal != 0
                        ? Text("Commander pour : $priceTotal F CFA")
                        : const Text("Commander")),
              )
            ]),
          )
        ],
      ),
    );
  }
}
