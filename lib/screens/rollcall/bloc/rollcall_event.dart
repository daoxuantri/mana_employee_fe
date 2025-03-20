part of 'rollcall_bloc.dart';

@immutable
abstract class RollCallEvent {
  const RollCallEvent();
}

class RollCallInitialEvent extends RollCallEvent {}

class RollCallErrorScreenToLoginEvent extends RollCallEvent {}

class RollCallCheckInClickedEvent extends RollCallEvent {
  final String employeeId;
  final double latitude;
  final double longitude;
  const RollCallCheckInClickedEvent({
    required this.employeeId,
    required this.latitude,
    required this.longitude,
  });
}

class RollCallCheckOutClickedEvent extends RollCallEvent {
  final String employeeId;
  final double latitude;
  final double longitude;
  const RollCallCheckOutClickedEvent({
    required this.employeeId,
    required this.latitude,
    required this.longitude,
  });
}
