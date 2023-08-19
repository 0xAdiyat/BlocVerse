part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

@immutable
abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartLoadedSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartLoadedSuccessState({required this.cartItems});
}

class CartLoadingState extends CartState {}

class CartErrorState extends CartState {
  final String error;

  CartErrorState({required this.error});
}
