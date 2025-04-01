part of 'rollcall_bloc.dart';

@immutable
abstract class RollCallState {
  const RollCallState();
}

abstract class RollCallActionState extends RollCallState {}

class RollCallInitial extends RollCallState {}

class RollCallLoadingState extends RollCallState {}

enum RollCallStatus {
  checkedIn,
  checkedOut,
  none
}
class RollCallLoadedSuccessState extends RollCallState {
  final RollCallStatus status;
  final String? morningCheckInTime;
  final String? morningCheckOutTime;
  final String? afternoonCheckInTime;
  final String? afternoonCheckOutTime;

  RollCallLoadedSuccessState({
    required this.status,
    this.morningCheckInTime,
    this.morningCheckOutTime,
    this.afternoonCheckInTime,
    this.afternoonCheckOutTime,
  });
}


class RollCallErrorState extends RollCallState {
  final String errorMessage;
  const RollCallErrorState({
    required this.errorMessage,
  });
}

class RollCallCheckInClickedState extends RollCallActionState {
  final String message;
  RollCallCheckInClickedState({
    required this.message,
  });
}

class RollCallCheckOutClickedState extends RollCallActionState {
  final String message;
  RollCallCheckOutClickedState({
    required this.message,
  });
}
class RollCallErrorScreenToLoginState extends RollCallActionState {}


