import 'package:flutter/material.dart';
import 'package:mana_employee_fe/screens/rollcall/bloc/rollcall_bloc.dart';

class RollCallButton extends StatelessWidget {
  final RollCallBloc rollCallBloc;
  final RollCallState state;
  final Function(bool isCheckedIn) onAction;

  const RollCallButton({
    super.key,
    required this.rollCallBloc,
    required this.state,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    bool isCheckedIn = false;
    bool isLoading = false;

    if (state is RollCallLoadedSuccessState) {
      isCheckedIn = (state as RollCallLoadedSuccessState).status == RollCallStatus.checkedIn;
    } else if (state is RollCallLoadingState) {
      isLoading = true;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isCheckedIn ? Colors.red : Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
      ),
      onPressed: isLoading ? null : () => onAction(isCheckedIn),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
            )
          : Text(isCheckedIn ? "Tan ca" : "Vào ca"),
    );
  }
}
