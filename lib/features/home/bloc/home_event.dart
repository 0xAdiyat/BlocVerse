part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

// Initial event
class HomeInitialEvent extends HomeEvent {}

// Click event
class HomeProductWishListButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductWishListButtonClickedEvent({required this.clickedProduct});
}

class HomeCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeCartButtonClickedEvent({required this.clickedProduct});
}

// Click navigation event
class HomeCartButtonNavigateEvent extends HomeEvent {}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}
