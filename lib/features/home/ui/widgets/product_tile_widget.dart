import 'package:bloc/bloc.dart';
import 'package:bloc_verse/features/home/bloc/home_bloc.dart';
import 'package:bloc_verse/features/home/models/home_product_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 9,
            color: backgroundColor,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
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
                          topRight: Radius.circular(10)),
                      image: DecorationImage(
                          image: NetworkImage(productData.imageUrl),
                          fit: BoxFit.cover),
                    ),
                    child: Text("${productData.quantity}x",
                        style: GoogleFonts.lobster(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
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
                                    customBloc.add(
                                        HomeProductWishListButtonClickedEvent(
                                            clickedProduct: productData));
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.heart,
                                    color: Colors.pink,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    customBloc.add(HomeCartButtonClickedEvent(
                                        clickedProduct: productData));
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.cart,
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
        ),
      ],
    );
  }
}
