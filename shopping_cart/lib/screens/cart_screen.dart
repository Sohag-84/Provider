// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/controller/db_helper.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart product"),
        centerTitle: true,
        actions: [
          Center(
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
          SizedBox(width: 20)
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: cartProvider.getData(),
            builder: (context, AsyncSnapshot<List<CartModel>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(
                      "Cart is empty",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data![index];
                        return Card(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.asset(
                                    data.image.toString(),
                                    height: 100,
                                    width: 100,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data.productName.toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  dbHelper.delete(
                                                      id: snapshot
                                                          .data![index].id!);
                                                  cartProvider.removeCounter();
                                                  cartProvider.removeTotalPrice(
                                                    productPrice: double.parse(
                                                      data.productPrice
                                                          .toString(),
                                                    ),
                                                  );
                                                },
                                                child: Icon(Icons.delete)),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          data.unitTag.toString() +
                                              " " +
                                              r"$ " +
                                              data.productPrice.toString(),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          height: 38,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.green,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    int quantity =
                                                        data.quantity!;
                                                    int price =
                                                        data.initialPrice!;
                                                    quantity--;
                                                    int? newPrice =
                                                        quantity * price;
                                                    if (quantity > 0) {
                                                      dbHelper
                                                          .updateQuantity(
                                                        cartModel: CartModel(
                                                          id: data.id,
                                                          productId: data
                                                              .productId
                                                              .toString(),
                                                          productName: data
                                                              .productName
                                                              .toString(),
                                                          initialPrice:
                                                              data.initialPrice,
                                                          productPrice:
                                                              newPrice,
                                                          quantity: quantity,
                                                          unitTag: data.unitTag
                                                              .toString(),
                                                          image: data.image
                                                              .toString(),
                                                        ),
                                                      )
                                                          .then((value) {
                                                        newPrice = 0;
                                                        quantity = 0;
                                                        cartProvider
                                                            .removeTotalPrice(
                                                          productPrice:
                                                              double.parse(
                                                            data.initialPrice!
                                                                .toString(),
                                                          ),
                                                        );
                                                      }).onError((error,
                                                              stackTrace) {
                                                        print(
                                                          error.toString(),
                                                        );
                                                      });
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  data.quantity.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    int quantity =
                                                        data.quantity!;
                                                    int price =
                                                        data.initialPrice!;
                                                    quantity++;
                                                    int? newPrice =
                                                        quantity * price;
                                                    dbHelper
                                                        .updateQuantity(
                                                      cartModel: CartModel(
                                                        id: data.id,
                                                        productId: data
                                                            .productId
                                                            .toString(),
                                                        productName: data
                                                            .productName
                                                            .toString(),
                                                        initialPrice:
                                                            data.initialPrice,
                                                        productPrice: newPrice,
                                                        quantity: quantity,
                                                        unitTag: data.unitTag
                                                            .toString(),
                                                        image: data.image
                                                            .toString(),
                                                      ),
                                                    )
                                                        .then((value) {
                                                      newPrice = 0;
                                                      quantity = 0;
                                                      cartProvider
                                                          .addTotalPrice(
                                                        productPrice:
                                                            double.parse(
                                                          data.initialPrice!
                                                              .toString(),
                                                        ),
                                                      );
                                                    }).onError((error,
                                                            stackTrace) {
                                                      print(
                                                        error.toString(),
                                                      );
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              }
              return Text("Something is wrong!");
            },
          ),
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return Column(
                children: [
                  Visibility(
                    visible: value.getTotalPrice().toStringAsFixed(2) == '0.00'
                        ? false
                        : true,
                    child: ReusableWidget(
                      title: "Sub total",
                      value: r"$" + value.getTotalPrice().toStringAsFixed(2),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
