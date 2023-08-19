import 'package:badges/badges.dart' as badges;
import 'package:bloc_verse/flutter_vintage_veggies/widgets/product_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utility/constants/colors.dart';
import '../../../widgets/retro_app_bar.dart';
import '../../cart/bloc/cart_bloc.dart';
import '../../cart/ui/cart.dart';
import '../../wishlist/ui/wishlist.dart';
import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeBloc homeBloc = HomeBloc();
  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.close();
    cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RetroAppBar(
        title: "VintageVeggies",
        actions: [
          IconButton(
            onPressed: () => homeBloc.add(HomeWishlistButtonNavigateEvent()),
            icon: const Icon(CupertinoIcons.heart),
          ),
          BlocBuilder<CartBloc, CartState>(
            bloc: cartBloc,
            builder: (context, state) {
              print(state.runtimeType);
              if (state.runtimeType == CartLoadedSuccessState) {
                var cartedItems = state as CartLoadedSuccessState;
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () => homeBloc.add(HomeCartButtonNavigateEvent()),
                    child: badges.Badge(
                      badgeContent:
                          Text(cartedItems.cartItems.length.toString()),
                      child: const Icon(CupertinoIcons.cart),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          )
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
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
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: productsData.products.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ProductTileWidget(
                          productData: productsData.products[index],
                          backgroundColor:
                              tileColors[index % tileColors.length],
                          customBloc: homeBloc,
                        ),
                      ));
            case HomeErrorState:
              final homeErrorStateErr = state as HomeErrorState;
              return Scaffold(
                body: Center(
                  child: Text(
                    homeErrorStateErr.error,
                  ),
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
