import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mana_employee_fe/api/rollcall.dart';
import 'package:mana_employee_fe/model/rollcall/rollcall_respone.dart';
import 'package:mana_employee_fe/model/rollcall/rollcall_status_respone.dart';
import 'package:meta/meta.dart';
part 'rollcall_event.dart';
part 'rollcall_state.dart';

class RollCallBloc extends Bloc<RollCallEvent, RollCallState> {
  RollCallBloc() : super(RollCallInitial()) {
    on<RollCallInitialEvent>(rollCallInitialEvent);
    on<RollCallCheckInClickedEvent>(rollCallCheckInClickedEvent);
    on<RollCallCheckOutClickedEvent>(rollCallCheckOutClickedEvent);
    on<RollCallErrorScreenToLoginEvent>(rollCallErrorScreenToLoginEvent);
  }

  Future<void> rollCallInitialEvent(
      RollCallInitialEvent event, Emitter<RollCallState> emit) async {
    emit(RollCallLoadingState());
    try {
      final RollCallStatusRespone response =
          await ApiServiceRollCall().getTodayStatus(event.employeeId!);

      final String? status = response.status;
      final String? checkinTime = response.checkinTime;
      final String? checkoutTime = response.checkoutTime;

      if (status == "checkedIn") {
        emit(RollCallLoadedSuccessState(
          status: RollCallStatus.checkedIn,
          morningCheckInTime: checkinTime,
          morningCheckOutTime: null,
          afternoonCheckInTime: null,
          afternoonCheckOutTime: null,
        ));
      } else if (status == "checkedOut") {
        // Phân chia: sáng chỉ có check-in, chiều chỉ có check-out
        emit(RollCallLoadedSuccessState(
          status: RollCallStatus.checkedOut,
          morningCheckInTime: checkinTime,
          morningCheckOutTime: null,
          afternoonCheckInTime: null,
          afternoonCheckOutTime: checkoutTime,
        ));
      } else {
        emit(RollCallLoadedSuccessState(
          status: RollCallStatus.none,
          morningCheckInTime: null,
          morningCheckOutTime: null,
          afternoonCheckInTime: null,
          afternoonCheckOutTime: null,
        ));
      }
    } catch (e) {
      String failToken = e.toString();
      if (failToken.startsWith('Exception: ')) {
        failToken = failToken.substring('Exception: '.length);
      }
      emit(RollCallErrorState(errorMessage: failToken));
    }
  }

  //check-in
  Future<void> rollCallCheckInClickedEvent(
      RollCallCheckInClickedEvent event, Emitter<RollCallState> emit) async {
    emit(RollCallLoadingState());
    try {
      RollCallRespone respone = await ApiServiceRollCall()
          .checkIn(event.employeeId, event.longitude, event.latitude);

      emit(RollCallLoadedSuccessState(status: RollCallStatus.checkedIn));
    } catch (e) {
      String failToken = e.toString();
      if (failToken.startsWith('Exception: ')) {
        failToken = failToken.substring('Exception: '.length);
      }
      emit(RollCallErrorState(errorMessage: failToken));
    }
  }

  //check-out
  Future<void> rollCallCheckOutClickedEvent(
      RollCallCheckOutClickedEvent event, Emitter<RollCallState> emit) async {
    try {
      RollCallRespone respone = await ApiServiceRollCall()
          .checkOut(event.employeeId, event.longitude, event.latitude);

      emit(RollCallLoadedSuccessState(status: RollCallStatus.checkedOut));
    } catch (e) {
      String failToken = e.toString();
      if (failToken.startsWith('Exception: ')) {
        failToken = failToken.substring('Exception: '.length);
      }
      emit(RollCallErrorState(errorMessage: failToken));
    }
  }

  FutureOr<void> rollCallErrorScreenToLoginEvent(
      RollCallErrorScreenToLoginEvent event, Emitter<RollCallState> emit) {
    emit(RollCallErrorScreenToLoginState());
  }
}
