import 'dart:async'; 
import 'package:bloc/bloc.dart';
import 'package:mana_employee_fe/api/rollcall.dart';
import 'package:mana_employee_fe/model/rollcall/rollcall_respone.dart';   
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

      //viết những thứ nếu cần     
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
      RollCallRespone respone = await ApiServiceRollCall().checkIn(event.employeeId, event.longitude, event.latitude);
      //viết những thứ nếu cần     
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
      RollCallRespone respone = await ApiServiceRollCall().checkOut(event.employeeId, event.longitude, event.latitude);
      //viết những thứ nếu cần     
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