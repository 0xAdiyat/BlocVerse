import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/colors.dart';
import '../../../widgets/product_tile_widget.dart';
import '../../../widgets/retro_app_bar.dart';
import '../bloc/cart_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cartBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RetroAppBar(
        title: 'Cart',
        actions: [
          BlocBuilder<CartBloc, CartState>(
            bloc: cartBloc,
            buildWhen: (previous, current) => current is! CartActionState,
            builder: (context, state) {
              switch (state.runtimeType) {
                case CartLoadedSuccessState:
                  var cartData = state as CartLoadedSuccessState;
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(cartData.cartItems.length.toString(),
                        style: GoogleFonts.lobster(fontSize: 24)),
                  );
                default:
                  return const SizedBox();
              }
            },
          )
        ],
      ),
      body: BlocConsumer<CartBloc, CartState>(
          bloc: cartBloc,
          listenWhen: (previous, current) => current is CartActionState,
          buildWhen: (previous, current) => current is! CartActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartLoadedSuccessState:
                final cartData = state as CartLoadedSuccessState;
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: cartData.cartItems.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ProductTileWidget(
                            productData: cartData.cartItems[index],
                            backgroundColor:
                                tileColors[index % tileColors.length],
                            customBloc: cartBloc,
                          ),
                        ));
              case CartLoadingState:
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case CartErrorState:
                final cartErrState = state as CartErrorState;
                return Scaffold(
                  body: Center(
                    child: Text(
                      cartErrState.error,
                    ),
                  ),
                );
              default:
                return const SizedBox();
            }
          },
          listener: (context, state) {}),
    );
  }
}
