import 'package:bloc_verse/features/home/bloc/home_bloc.dart';
import 'package:bloc_verse/features/home/models/home_product_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productData;
  final Color backgroundColor;
  final HomeBloc homeBloc;

  const ProductTileWidget(
      {Key? key,
      required this.productData,
      required this.backgroundColor,
      required this.homeBloc})
      : super(key: key);

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
                    child: Text(
                      "${productData.quantity}x",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productData.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          productData.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$${productData.price}",
                              style: TextStyle(
                                  color: Theme.of(context).iconTheme.color!,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      homeBloc.add(
                                          HomeProductWishListButtonClickedEvent(
                                              clickedProduct: productData));
                                    },
                                    icon: Icon(
                                      CupertinoIcons.heart,
                                      shadows: [
                                        Shadow(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color!,
                                            blurRadius: 2,
                                            offset: const Offset(0.5, 1))
                                      ],
                                    )),
                                IconButton(
                                  onPressed: () {
                                    homeBloc.add(HomeCartButtonClickedEvent(
                                        clickedProduct: productData));
                                  },
                                  icon: Icon(
                                    CupertinoIcons.cart,
                                    shadows: [
                                      Shadow(
                                          color: Theme.of(context)
                                              .iconTheme
                                              .color!,
                                          blurRadius: 2,
                                          offset: const Offset(0.5, 1))
                                    ],
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
