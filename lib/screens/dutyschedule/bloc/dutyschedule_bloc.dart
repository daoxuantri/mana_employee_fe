import 'package:flutter_bloc/flutter_bloc.dart';

part 'dutyschedule_event.dart';
part 'dutyschedule_state.dart';

class DutyScheduleBloc extends Bloc<DutyScheduleEvent , DutyScheduleState>{
  DutyScheduleBloc() : super (DutyInitial()){
    on<DutyInitialEvent>(dutyInitialEvent);
  }


  Future<void> dutyInitialEvent(
    DutyInitialEvent event , Emitter<DutyScheduleState> emit) async {
      emit(DutyLoadingState());
      try{

      }catch(e){

      }
    }
  
  
}

