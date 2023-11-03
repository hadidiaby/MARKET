import 'package:flutter/material.dart';
import 'package:market/api.dart';
import 'package:market/globals.dart';
import 'dart:math';

import 'package:market/models/storeplace.dart';

class LivraisonScreen extends StatefulWidget {
  const LivraisonScreen({Key? key}) : super(key: key);

  @override
  _LivraisonScreenState createState() => _LivraisonScreenState();
}

class _LivraisonScreenState extends State<LivraisonScreen> {
  int? selectedLieuLivraison;
  DateTime nextSaturday = _getNextSaturday();
  DateTime orderDate = DateTime.now();
  String? confirmationCode;

  List<StorePlace> _stores = [];

  @override
  void initState() {
    API.getStore().then((value) {
      setState(() {
        _stores = value;
      });
    });
    super.initState();
  }

  static DateTime _getNextSaturday() {
    DateTime now = DateTime.now();
    int daysUntilSaturday = DateTime.saturday - now.weekday;
    if (daysUntilSaturday <= 0) {
      daysUntilSaturday += 7;
    }
    return now.add(Duration(days: daysUntilSaturday));
  }

  double totalAPayer = 0.0;
  bool isLivraisonConfirmed = false;
  String? selectedPaymentMethod;
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    amountController.dispose();
    super.dispose();
  }

  // Fonction pour générer un code de commande spécifique au lieu de livraison
  String _generateConfirmationCode() {
    final random = Random();
    const digits = '0123456789';
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String code = '';

    for (int i = 0; i < 4; i++) {
      code += digits[random.nextInt(digits.length)];
    }

    for (int i = 0; i < 2; i++) {
      code += letters[random.nextInt(letters.length)];
    }

    // Ajouter un préfixe spécifique au lieu de livraison
    if (selectedLieuLivraison != null) {
      code =
          '${_stores.where((element) => element.id == selectedLieuLivraison).first.name!.substring(0, 3).toUpperCase()}-$code';
    }

    return code;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Livraison"),
          backgroundColor: const Color(0xff23AA49),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Délai de Livraison"),
              Tab(text: "Paiement"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Onglet Délai de Livraison
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Où souhaitez-vous être livré ?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3C3D3C)),
                  ),
                ),
                Wrap(
                  children: [
                    for (var lieuLivraison in _stores)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChoiceChip(
                          label: Text(lieuLivraison.name!),
                          selected: selectedLieuLivraison == lieuLivraison.id,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedLieuLivraison =
                                  selected ? lieuLivraison.id : null;
                            });
                          },
                          backgroundColor: const Color.fromARGB(255, 226, 228, 230),
                          selectedColor: Colors.green,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (selectedLieuLivraison != null) {
                      API
                          .passOrder(gblCart, selectedLieuLivraison!)
                          .whenComplete(
                        () {
                          print('ok');
                          setState(() {
                        isLivraisonConfirmed = true;
                        totalAPayer = 50.0;
                        confirmationCode = _generateConfirmationCode();
                      });
                        },
                      );

                      
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Erreur"),
                            content: const Text(
                                "Aucun lieu de livraison n'a été sélectionné."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff23AA49),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Confirmer la livraison",
                      style: TextStyle(color: Colors.white)),
                ),
                if (isLivraisonConfirmed)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date de la commande : ${orderDate.toLocal()}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3C3D3C)),
                                ),
                                Text(
                                  "Date de livraison : ${nextSaturday.toLocal()}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3C3D3C)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lieu de livraison : $selectedLieuLivraison",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3C3D3C)),
                                ),
                                Text(
                                  "Montant à payer : \$$totalAPayer",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3C3D3C)),
                                ),
                                Text(
                                  "Code de confirmation : $confirmationCode",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3C3D3C)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            // Onglet Paiement
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Montant à payer : \$$totalAPayer",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3C3D3C)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<String>(
                        value: "Moov",
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value;
                          });
                        },
                      ),
                      const Text("Moov"),
                      Radio<String>(
                        value: "Orange",
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value;
                          });
                        },
                      ),
                      const Text("Orange"),
                      Radio<String>(
                        value: "MTN",
                        groupValue: selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value;
                          });
                        },
                      ),
                      const Text("MTN"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (selectedPaymentMethod != null)
                    Column(
                      children: [
                        TextField(
                          controller: phoneController,
                          decoration:
                              const InputDecoration(labelText: "Numéro de téléphone"),
                        ),
                        TextField(
                          controller: amountController,
                          decoration:
                              const InputDecoration(labelText: "Montant (\$)"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            double paymentAmount =
                                double.tryParse(amountController.text) ?? 0.0;

                            if (paymentAmount < totalAPayer) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Erreur de paiement"),
                                    content: const Text(
                                        "Le montant entré est inférieur au montant total à payer."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              String network = selectedPaymentMethod!;
                              String phoneNumber = phoneController.text;
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Paiement"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Réseau : $network"),
                                        Text(
                                            "Numéro de téléphone : $phoneNumber"),
                                        Text("Montant : \$$paymentAmount"),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff23AA49),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Payer",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> lieuxLivraison = [
  "Plateau",
  "Yopougon",
  "Cocody centre",
  "Angre cocody",
  "Abobo",
  "Treichville",
];
