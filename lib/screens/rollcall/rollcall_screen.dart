import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mana_employee_fe/screens/rollcall/bloc/rollcall_bloc.dart';
import 'package:mana_employee_fe/screens/rollcall/components/location_helper.dart';
import 'package:mana_employee_fe/screens/rollcall/components/rollcall_button.dart';
import 'package:mana_employee_fe/screens/rollcall/components/work_schedule.dart';
import 'package:mana_employee_fe/size_config.dart';

class RollCallScreen extends StatefulWidget {
  const RollCallScreen({super.key});
  static String routeName = '/rollcall';

  @override
  State<RollCallScreen> createState() => _RollCallScreenState();
}

class _RollCallScreenState extends State<RollCallScreen> {
  final RollCallBloc rollCallBloc = RollCallBloc();

  @override
  void initState() {
    super.initState();
    rollCallBloc.add(RollCallInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(title: Text("Chấm công")),
      body: BlocConsumer<RollCallBloc, RollCallState>(
        bloc: rollCallBloc,
        listenWhen: (previous, current) => current is RollCallActionState,
        buildWhen: (previous, current) => current is! RollCallActionState,
        listener: (context, state) {
          if (state is RollCallCheckInClickedState) {
            _handleCheckIn();
          } else if (state is RollCallCheckOutClickedState) {
            _handleCheckOut();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              WorkSchedule(),
              RollCallButton(rollCallBloc: rollCallBloc, state: state , onAction: _handleRollCall),
            ],
          );
        },
      ),
    );
  }

  /// Xử lý chấm công (Check-in / Check-out)
  void _handleRollCall(bool isCheckedIn) async {
    Position? position = await LocationHelper.determinePosition();
    if (position != null) {
      if (isCheckedIn) {
        rollCallBloc.add(RollCallCheckOutClickedEvent(
          latitude: position.latitude,
          longitude: position.longitude,
          employeeId: "67cdb950d434b69cb94ec7d6", // Thay bằng ID thực tế
        ));
        _showSnackbar("Check-out thành công!", Colors.green);
      } else {
        rollCallBloc.add(RollCallCheckInClickedEvent(
          latitude: position.latitude,
          longitude: position.longitude,
          employeeId: "67cdb950d434b69cb94ec7d6", // Thay bằng ID thực tế
        ));
        _showSnackbar("Check-in thành công!", Colors.green);
      }
    } else {
      _showSnackbar("Không thể lấy vị trí. Kiểm tra GPS!", Colors.red);
    }
  }

  /// Hiển thị thông báo
  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }



  /// Xử lý Check-in
  void _handleCheckIn() async {
    Position? position = await LocationHelper.determinePosition();
    if (position != null) {
      rollCallBloc.add(RollCallCheckInClickedEvent(
        latitude: position.latitude,
        longitude: position.longitude,
        employeeId: "123456", // Thay bằng ID thực tế
      ));
      _showSnackbar("Check-in thành công!", Colors.green);
    } else {
      _showSnackbar("Không thể lấy vị trí. Kiểm tra GPS!", Colors.red);
    }
  }

  /// Xử lý Check-out
  void _handleCheckOut() async {
    Position? position = await LocationHelper.determinePosition();
    if (position != null) {
      rollCallBloc.add(RollCallCheckOutClickedEvent(
        latitude: position.latitude,
        longitude: position.longitude,
        employeeId: "123456",
      ));
      _showSnackbar("Check-out thành công!", Colors.green);
    } else {
      _showSnackbar("Không thể lấy vị trí. Kiểm tra GPS!", Colors.red);
    }
  }
}
