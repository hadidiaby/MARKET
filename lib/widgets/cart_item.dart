import 'package:flutter/material.dart';
import 'package:market/api.dart';
import 'package:market/globals.dart';
import 'package:market/models/order.dart';
import '../models/cart_data.dart';

class CartItemWidget extends StatefulWidget {
  final OrderItem item;
  const CartItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int itemCount = 0;
  @override
  Widget build(BuildContext context) {
    int indexOrder = gblCart
        .indexWhere((element) => widget.item.product!.id == element.product!.id!);
    if (indexOrder != -1) {
      itemCount = gblCart[indexOrder].quantity!;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image.network(
            '$addressIp${widget.item.product!.image}',
            width: 40,
            height: 40,
          )),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.product!.name!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(widget.item.price.toString(),
                    style: const TextStyle(
                        color: Color(0xffFF324B),
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: (() {
                    setState(() {
                      itemCount++;
                    });
                  }),
                  child: Image.asset(
                    "assets/images/add_icon.png",
                    width: 24,
                    height: 24,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "$itemCount",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (itemCount > 0) itemCount--;
                    });
                  },
                  child: Image.asset(
                    "assets/images/remove_icon.png",
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
