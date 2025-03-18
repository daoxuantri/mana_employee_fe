part of 'home_bloc.dart';

@immutable
abstract class HomeState{
  const HomeState();
}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  List<BannerDataModel> ?bannersPropose;
  HomeLoadedSuccessState({
    required this.bannersPropose
  });
}

class HomeErrorState extends HomeState {
  final String errorMessage;
  const HomeErrorState({
    required this.errorMessage,
  });
}

class HomeErrorScreenToLoginState extends HomeActionState {}

class HomeProductClickedState extends HomeActionState {
  final String productId;
  HomeProductClickedState({
    required this.productId,
  });
}

