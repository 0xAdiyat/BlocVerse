import 'package:bloc/bloc.dart';
import 'package:bloc_verse/data/cart_items_data.dart';

import '../../home/models/home_product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>((event, emit) {
      emit(CartLoadedSuccessState(cartItems: cartItems));
    });
  }
}
