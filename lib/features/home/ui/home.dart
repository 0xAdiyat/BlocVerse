import 'package:bloc_verse/features/home/ui/widgets/product_tile_widget.dart';
import 'package:bloc_verse/features/wishlist/ui/wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cart/ui/cart.dart';
import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> tileColors = [
      Theme.of(context).cardColor, // Color for the first tile
      Color(0xffc7ffdf),
      Color(0xfff6e1b5),
      Color(0xffebd2f4),
    ];

    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content:
                  Text("${state.wishListedItemName} was added to wishlist")));
        } else if (state is HomeProductItemAddedToCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("${state.addedItemName} was added to cart")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final productsData = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("BlocVerse"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(CupertinoIcons.heart)),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeCartButtonNavigateEvent());
                    },
                    icon: const Icon(CupertinoIcons.cart),
                  ),
                ],
              ),
              body: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: productsData.products.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ProductTileWidget(
                          productData: productsData.products[index],
                          backgroundColor:
                              tileColors[index % tileColors.length],
                          homeBloc: homeBloc,
                        ),
                      )),
            );
          case HomeErrorState:
            final homeErrorStateErr = state as HomeErrorState;
            return Scaffold(
              body: Center(
                child: Text(
                  homeErrorStateErr.error,
                ),
              ),
            );
            break;
          default:
            return const SizedBox();
        }
      },
    );
  }
}
