import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/models/city.dart';
import 'package:market/models/products.dart';
import 'package:market/screens/history.dart';
import 'package:market/screens/vegetable_detail.dart';
import 'package:market/screens/vegetables.dart';
import '../widgets/vegetable_card.dart';
import '../api.dart';
import '../globals.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<City> _cities = [];
  List<Product> _citiesprod = [];
  int selected_city = -1;
  @override
  void initState() {
    API.getCities().then((value) {
      setState(() {
        _cities = value;
        if (value.length > 0) {
          selected_city = value.first.id!;
          loadproducts(value.first.id);
        }
      });
    });
    super.initState();
  }

  void loadproducts([int? selected]) {
    API.getProductsByCity(selected ?? selected_city).then((value) {
      setState(() {
        _citiesprod = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String first = globalUser!.user!.lastName ?? "";
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            height: 36,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Image.asset(
                    "assets/images/user.png",
                    scale: 3.6,
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Bienvenue",
                            style: TextStyle(
                                color: Color(0xff979899),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            first,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: const BoxDecoration(
                          color: Color(0xffF3F5F7),
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.location,
                            color: Color(0xff23AA49),
                            size: 16,
                          ),
                          Text(
                            "Deco",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          Icon(
                            CupertinoIcons.chevron_down,
                            color: Color(0xff23AA49),
                            size: 12,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xffF3F5F7),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
                child: const TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Chercher une categorie",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xff979899),
                          fontWeight: FontWeight.w500),
                      contentPadding: EdgeInsets.all(16),
                      prefixIcon: Icon(
                        CupertinoIcons.search,
                        color: Color(0xff23AA49),
                      ),
                    )),
              )),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/images/banner.png",
              scale: 4.0,
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryScreen()),
            );
            },
            child: Text("voir historique"),
          ),

          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _seeAllView(context, "Top Ventes"),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.3), width: 3))),
                  height: 30,
                  child: Builder(
                    builder: (BuildContext context) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _cities.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected_city = _cities[index].id!;
                                    loadproducts();
                                  });
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    decoration: BoxDecoration(
                                        border: (selected_city ==
                                                _cities[index].id!)
                                            ? const Border(
                                                bottom: BorderSide(
                                                    width: 3,
                                                    color: Colors.green))
                                            : const Border(bottom: BorderSide.none)),
                                    child: Text(_cities[index].name!)),
                              ));
                    },
                  ),
                ),

                Container(
                  height: MediaQuery.sizeOf(context).height * 0.4,
                  width: MediaQuery.sizeOf(context).width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      mainAxisExtent: 225,
                    ),
                    itemBuilder: (context, index) {
                      return VegetableCardWidget(
                        imagePath: '$addressIp${_citiesprod[index].image}',
                        name: _citiesprod[index].name ?? '',
                        price: '${_citiesprod[index].price ?? 0} FCFA',
                        onTapCallback: () {
                          // OrderItem oItem = OrderItem(
                          //     product: _products[index],
                          //     price: _products[index].price!,
                          //     quantity: 1);

                          // int indexOrder = gblCart.indexWhere(
                          //     (element) => _products[index].id == element.product!.id!);

                          // if (indexOrder != -1) {
                          //   oItem.quantity = gblCart[indexOrder].quantity! + 1;
                          //   gblCart.replaceRange(indexOrder, indexOrder + 1, [oItem]);
                          // } else {
                          //   gblCart.add(oItem);
                          // }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VegetableDetailScreen(
                                      product: _citiesprod[index],
                                    )),
                          );
                        },
                      );
                    },
                    itemCount: _citiesprod.length,
                  ),
                ),

                const SizedBox(
                  height: 32,
                ),
                // _seeAllView(context, "Top Ventes"),
                const SizedBox(
                  height: 24,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Expanded(
                    //   child: VegetableCardWidget(
                    //     imagePath: "assets/images/ginger.png",
                    //     name: "Gingembre",
                    //     price: "1kg, 780 fcfa",
                    //     onTapCallback: () {
                    //       Navigator.pushNamed(
                    //           context, MyRoutes.vegetableDetailRoute);
                    //     },
                    //   ),
                    // ),
                    // Expanded(
                    //   child: VegetableCardWidget(
                    //       imagePath: "assets/images/lamb_meat.png",
                    //       name: "Bell Pepper Red",
                    //       price: "1kg, 780fcfa",
                    //       onTapCallback: () {}),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _seeAllView(BuildContext context, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const VegetablesScreen()),
            );
            // Navigator.pushNamed(context, MyRoutes.vegetablesRoute);
          },
          child: const Text(
            "Voir+",
            style: TextStyle(
                fontSize: 14,
                color: Color(0xff23AA49),
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _categoriesView(String imagePath, String catName) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xffF3F5F7),
            radius: 32,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                imagePath,
                scale: 4.0,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            catName,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          )
        ],
      ),
    );
  }
}
