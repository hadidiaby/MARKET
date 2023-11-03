import 'package:flutter/material.dart';
import 'package:market/api.dart';
import '../models/order.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {


  @override
  void initState() {
    API.getOrders().then((value) {
      setState(() {
        _orders = value;
      });
    });
    super.initState();
  }

  List<Order> _orders = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Mes commandes",
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
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Row(children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(
                      height: 100,
                     child: Column(children: [
                      Text(_orders[index].orderingDate.toString()),
                      Text(_orders[index].orderItems!.fold(0, (sum, item) => sum + item.price!).toString())
                     ]),
                    )
                  ]),
                );
              },
            ),
          ),
         
        ],
      ),
    );
  }
}
