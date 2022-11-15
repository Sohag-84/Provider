// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/controller/db_helper.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/provider/cart_provider.dart';
import 'package:shopping_cart/screens/cart_screen.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({Key? key}) : super(key: key);

  DbHelper dbHelper = DbHelper();

  List<String> productName = [
    'Banana',
    'Boiler',
    'Carrot',
    'Chili',
    'Egg',
    'Mutton',
    'Oil',
  ];
  List<String> productUnit = [
    'Dozen',
    'KG',
    'KG',
    'KG',
    'Dozen',
    'KG',
    'KG',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'images/banana.png',
    'images/boiler_chicken.png',
    'images/carrot.png',
    'images/chili.png',
    'images/egg.png',
    'images/mutton.png',
    'images/oil.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Product list"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            ),
            child: Center(
              child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: TextStyle(color: Colors.white),
                    );
                  },              
                ),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          SizedBox(width: 20)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productImage.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            productImage[index],
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                productUnit[index] +
                                    " " +
                                    r"$" +
                                    productPrice[index].toString(),
                              ),
                              SizedBox(height: 5),
                              InkWell(
                                onTap: () {
                                  dbHelper
                                      .insert(
                                    CartModel(
                                      id: index,
                                      productId: index.toString(),
                                      productName:
                                          productName[index].toString(),
                                      initialPrice: productPrice[index],
                                      productPrice: productPrice[index],
                                      quantity: 1,
                                      unitTag: productUnit[index].toString(),
                                      image: productImage[index].toString(),
                                    ),
                                  )
                                      .then(
                                    (value) {
                                      Fluttertoast.showToast(
                                          msg: "Product is added");
                                      cartProvider.addTotalPrice(
                                        productPrice: double.parse(
                                          productPrice[index].toString(),
                                        ),
                                      );
                                      cartProvider.addCounter();
                                    },
                                  ).onError(
                                    (error, stackTrace) {
                                      print(error.toString());
                                    },
                                  );
                                },
                                child: Container(
                                  height: 35,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add to cart",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
