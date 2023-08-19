import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../data/cart_items_data.dart';
import '../../../data/grocery_data.dart';
import '../../../data/wishlist_items_data.dart';
import '../models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>((event, emit) async {
      emit(HomeLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      try {
        final products = GroceryData.groceryProducts
            .map((product) => ProductDataModel(
                id: product['id'],
                name: product['name'],
                description: product['description'],
                imageUrl: product['imageUrl'],
                price: product['price'],
                quantity: product['quantity']))
            .toList();
        emit(
          HomeLoadedSuccessState(
            products: products,
          ),
        );
      } catch (error) {
        emit(
            HomeErrorState(error: "An error occurred while loading products."));
      }
    });

    on<HomeProductWishListButtonClickedEvent>((event, emit) {
      wishlistItems.add(event.clickedProduct);
      emit(HomeProductItemWishlistedActionState(
          wishListedItemName: event.clickedProduct.name));
    });
    on<HomeCartButtonClickedEvent>((event, emit) {
      cartItems.add(event.clickedProduct);
      emit(HomeProductItemAddedToCartActionState(
          addedItemName: event.clickedProduct.name));
    });
    on<HomeCartButtonNavigateEvent>((event, emit) {
      print("Cart Navigate Clicked");
      emit(HomeNavigateToCartPageActionState());
    });
    // We can also do
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("WishList Navigate Clicked");
    emit(HomeNavigateToWishlistPageActionState());
  }
}
