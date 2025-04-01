import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mana_employee_fe/size_config.dart';

class AssignWorkScreen extends StatefulWidget {
  const AssignWorkScreen({super.key});

  @override
  State<AssignWorkScreen> createState() => _AssignWorkScreenState();
}

class _AssignWorkScreenState extends State<AssignWorkScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Center(
          child: Text(
        'Cần có bản nâng cấp tiếp theo!!',
        style: TextStyle(fontSize: 18, color: Colors.red),
      )),
    );
  }
}
