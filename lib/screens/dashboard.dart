import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market/models/vegetable_data.dart';
import 'package:market/screens/vegetable_detail.dart';
import 'package:market/screens/vegetables.dart';
import 'package:market/utils/routes.dart';
import '../widgets/vegetable_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bienvenue",
                            style: TextStyle(
                                color: Color(0xff979899),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Nyaam market",
                            style: TextStyle(
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
                            "My Flat",
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _seeAllView(context, "Categories"),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    _categoriesView("assets/images/ac.png", "Abidjan"),
                    _categoriesView("assets/images/ac.png", "Abengourou"),
                    _categoriesView("assets/images/ac.png", "Bouake"),
                    _categoriesView("assets/images/ac.png", "Man"),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                _seeAllView(context, "Top Ventes"),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: VegetableCardWidget(
                        imagePath: "assets/images/ginger.png",
                        name: "Gingembre",
                        price: "1kg, 780 fcfa",
                        onTapCallback: () {
                          Navigator.pushNamed(
                              context, MyRoutes.vegetableDetailRoute);
                        },
                      ),
                    ),
                    Expanded(
                      child: VegetableCardWidget(
                          imagePath: "assets/images/lamb_meat.png",
                          name: "Bell Pepper Red",
                          price: "1kg, 780fcfa",
                          onTapCallback: () {}),
                    ),
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
              MaterialPageRoute(
                  builder: (context) => VegetablesScreen()),
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
