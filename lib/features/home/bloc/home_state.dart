part of 'home_bloc.dart';

// Abstract base class for different states related to the Home screen
@immutable
abstract class HomeState {}

// Abstract class representing states resulting from actions on the Home screen
abstract class HomeActionState extends HomeState {}

// Initial state when the Home screen is loaded
class HomeInitial extends HomeState {}

// State representing the loading state of the Home screen
class HomeLoadingState extends HomeState {}

// State representing a successful data load on the Home screen
class HomeLoadedSuccessState extends HomeState {}

// State representing an error condition on the Home screen
class HomeErrorState extends HomeState {}

// Action state triggered when navigating to the Cart page from the Home screen
class HomeNavigateToCartPageActionState extends HomeActionState {}

// Action state triggered when navigating to the Wishlist page from the Home screen
class HomeNavigateToWishlistPageActionState extends HomeActionState {}
