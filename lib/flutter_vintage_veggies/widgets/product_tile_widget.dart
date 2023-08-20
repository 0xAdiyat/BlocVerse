import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/cart/bloc/cart_bloc.dart';
import '../features/home/bloc/home_bloc.dart';
import '../features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productData;
  final Color backgroundColor;
  final Bloc customBloc;
  const ProductTileWidget({
    Key? key,
    required this.productData,
    required this.backgroundColor,
    required this.customBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCartBloc = customBloc.runtimeType == CartBloc;
    bool isHomeBloc = customBloc.runtimeType == HomeBloc;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                ),
                boxShadow: [
                  BoxShadow(
                      color: backgroundColor,
                      offset: const Offset(12, 12),
                      blurRadius: 2,
                      spreadRadius: 0),
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                    image: DecorationImage(
                        image: NetworkImage(productData.imageUrl),
                        fit: BoxFit.cover),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${productData.quantity}x",
                          style: GoogleFonts.lobster(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      if (isCartBloc)
                        IconButton(
                            onPressed: () {
                              customBloc.add(CartRemoveProductEvent());
                            },
                            icon: const Icon(
                              CupertinoIcons.minus,
                              color: Colors.white,
                            )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productData.name,
                          style: GoogleFonts.vt323(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        productData.description,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${productData.price}",
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (isHomeBloc) {
                                    customBloc.add(
                                        HomeProductWishListButtonClickedEvent(
                                            clickedProduct: productData));
                                  }
                                },
                                icon: const Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.pink,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (isHomeBloc) {
                                    customBloc.add(HomeCartButtonClickedEvent(
                                        clickedProduct: productData));
                                  }
                                },
                                icon: Icon(
                                  isCartBloc
                                      ? CupertinoIcons.cart_fill
                                      : CupertinoIcons.cart,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
