import 'package:flutter/material.dart';

class WorkSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> days = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
    final int today = DateTime.now().weekday;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(days.length, (index) {
        final isToday = (index + 1) == today;
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: isToday ? Colors.blue : Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(days[index], style: TextStyle(fontWeight: FontWeight.bold)),
        );
      }),
    );
  }
}