import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:mana_employee_fe/api/user.dart';
import 'package:mana_employee_fe/model/user/get_infor_user_model.dart';
import 'package:mana_employee_fe/model/user/info_user_respone.dart'; 
import 'package:meta/meta.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(profileInitialEvent);
    on<ProfileToUserInformationScreenEvent>(
        profileToUserInformationScreenEvent);
    on<ProfileToWalletScreenEvent>(profileToWalletScreenEvent);
    on<ProfileToMyOrdersScreenEvent>(profileToMyOrdersScreenEvent);
    on<ProfileToAddressScreenEvent>(profileToAddressScreenEvent);
    on<ProfileToSettingScreenEvent>(profileToSettingScreenEvent);
    on<ProfileToFavouriteEvent>(profileToFavouriteEvent);
  }

  Future<FutureOr<void>> profileInitialEvent(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try { 
      InfoUserDataModel profile = await ApiServiceUsers().getDetailUser();
        emit(ProfileLoaded(profile));
    } catch (e) {
      String failToken = e.toString();
      if (failToken.startsWith('Exception: ')) {
        failToken = failToken.substring('Exception: '.length);
      }
      emit(ProfileError(failToken));
    }
  }






  

  FutureOr<void> profileToUserInformationScreenEvent(
      ProfileToUserInformationScreenEvent event, Emitter<ProfileState> emit) {
    // emit(ProfileToUserInformationScreenState(event.profile));
  }

  FutureOr<void> profileToWalletScreenEvent(
      ProfileToWalletScreenEvent event, Emitter<ProfileState> emit) {
    emit(ProfileToWalletScreenState());
  }

  FutureOr<void> profileToMyOrdersScreenEvent(
      ProfileToMyOrdersScreenEvent event, Emitter<ProfileState> emit) {
    emit(ProfileToMyOrdersScreenState());
  }

  FutureOr<void> profileToAddressScreenEvent(
      ProfileToAddressScreenEvent event, Emitter<ProfileState> emit) {
    emit(ProfileToAddressScreenActionState());
  }

  FutureOr<void> profileToSettingScreenEvent(
      ProfileToSettingScreenEvent event, Emitter<ProfileState> emit) {
    emit(ProfileToSettingScreenActionState());
  }

  FutureOr<void> profileToFavouriteEvent(
      ProfileToFavouriteEvent event, Emitter<ProfileState> emit) {
    emit(ProfileToFavouriteActionState());
  }
}
