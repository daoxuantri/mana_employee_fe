part of 'dutyschedule_bloc.dart';

abstract class DutyScheduleState {
  const DutyScheduleState();
}

abstract class DutyInitialActionEvent extends DutyScheduleState {}

class DutyInitial extends DutyScheduleState{}

class DutyLoadingState extends DutyScheduleState {}
