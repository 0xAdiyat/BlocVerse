part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

// Initial event
class HomeInitialEvent extends HomeEvent {}

// Click event
class HomeProductWishListButtonClickedEvent extends HomeEvent {}

class HomeCartButtonClickedEvent extends HomeEvent {}

// Click navigation event
class HomeCartButtonNavigateEvent extends HomeEvent {}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}
