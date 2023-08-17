import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeProductWishListButtonClickedEvent>((event, emit) {
      print("WishList Clicked");
    });
    on<HomeCartButtonClickedEvent>((event, emit) {
      print("Cart  Clicked");
    });
    on<HomeCartButtonNavigateEvent>((event, emit) {
      print("Cart Navigate Clicked");
    });
    // We can also do
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print("WishList Navigate Clicked");
  }
}
