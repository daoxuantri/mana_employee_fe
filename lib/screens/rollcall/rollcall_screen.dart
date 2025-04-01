import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mana_employee_fe/screens/rollcall/bloc/rollcall_bloc.dart';
import 'package:mana_employee_fe/screens/rollcall/components/location_helper.dart';
import 'package:mana_employee_fe/security_user/secure_storage_user.dart';
import 'package:intl/intl.dart';
import 'package:mana_employee_fe/size_config.dart';

class RollCallScreen extends StatefulWidget {
  const RollCallScreen({super.key});
  static String routeName = '/rollcall';

  @override
  State<RollCallScreen> createState() => _RollCallScreenState();
}

class _RollCallScreenState extends State<RollCallScreen> {
  final RollCallBloc rollCallBloc = RollCallBloc();
  String? employeeId;
  bool _isEmployeeIdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadEmployeeId();
  }

  Future<void> _loadEmployeeId() async {
    employeeId = await UserSecurityStorage.getId();
    // if (employeeId != null) {
    //   setState(() {
    //     _isEmployeeIdLoaded = true;
    //   });
    //   rollCallBloc.add(RollCallInitialEvent(employeeId: employeeId!));
    // }
    rollCallBloc.add(RollCallInitialEvent(employeeId: employeeId!));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<RollCallBloc, RollCallState>(
      bloc: rollCallBloc,
      listenWhen: (previous, current) => current is RollCallActionState,
      buildWhen: (previous, current) => current is! RollCallActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case RollCallLoadingState:
            return const Center(child: CircularProgressIndicator());
          case RollCallLoadedSuccessState:
            final successState = state as RollCallLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Chấm công",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Container(
                  child: Column(
                    children: [
                      _buildWeeklyCalendar(),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      if (successState.status == RollCallStatus.none)
                        _buildButton("Check-in", Colors.green,
                            () => _handleRollCall(false)),
                      if (successState.status == RollCallStatus.checkedIn)
                        _buildButton("Check-out", Colors.red,
                            () => _handleRollCall(true)),
                      if (successState.status == RollCallStatus.checkedOut)
                        const Text("Bạn đã hoàn thành ngày làm việc!",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: getProportionateScreenHeight(25)),
                      Text(
                        'Hoạt động điểm danh trong ngày hôm nay',
                        style: TextStyle(fontSize: 15, color: Colors.red),
                      ),
                      SizedBox(height: 10),
                      // Bảng check-in/check-out
                      DataTable(
                        columns: const [
                          DataColumn(label: Text('Buổi')),
                          DataColumn(label: Text('Check In')),
                          DataColumn(label: Text('Check Out')),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              const DataCell(Text('Sáng')),
                              DataCell(
                                Text(
                                  successState.morningCheckInTime != null
                                      ? formatTime(
                                          successState.morningCheckInTime!)
                                      : 'Chưa check',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              const DataCell(Text('Chưa check')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('Chiều')),
                              const DataCell(Text('Chưa check')),
                              DataCell(
                                Text(
                                  successState.afternoonCheckOutTime != null
                                      ? formatTime(
                                          successState.afternoonCheckOutTime!)
                                      : 'Chưa check',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          case RollCallErrorState:
            final errorState = state as RollCallErrorState;
            return Center(child: Text(errorState.errorMessage));
          default:
            return const Center(child: Text("Chờ tải dữ liệu..."));
        }
      },
    );
  }

  /// Xử lý Check-in / Check-out
  void _handleRollCall(bool isCheckedIn) async {
    Position? position = await LocationHelper.determinePosition();

    if (position == null) {
      _showSnackbar("Không thể lấy vị trí. Kiểm tra GPS!", Colors.red);
      return;
    }

    print(
        "📍 Vị trí lấy được: Latitude: ${position.latitude}, Longitude: ${position.longitude}");

    if (employeeId != null) {
      rollCallBloc.add(
        isCheckedIn
            ? RollCallCheckOutClickedEvent(
                latitude: position.latitude,
                longitude: position.longitude,
                employeeId: employeeId!,
              )
            : RollCallCheckInClickedEvent(
                latitude: position.latitude,
                longitude: position.longitude,
                employeeId: employeeId!,
              ),
      );

      _showSnackbar(
          isCheckedIn ? "Check-out thành công!" : "Check-in thành công!",
          Colors.green);
    }
  }

  /// Hiển thị Snackbar
  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  /// Tạo Button Check-in/Check-out với màu sắc phù hợp
  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(100),
            vertical: getProportionateScreenHeight(14)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
    );
  }

  String formatTime(String isoTime) {
    try {
      final dateTime = DateTime.parse(isoTime);
      // Ví dụ: format thành HH:mm
      return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return isoTime;
    }
  }

  /// Hiển thị lịch trong tuần
  Widget _buildWeeklyCalendar() {
    final today = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        final day = today.subtract(Duration(days: today.weekday - 1 - index));
        final isToday = day.day == today.day;
        return Column(
          children: [
            Text(DateFormat.E().format(day),
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: getProportionateScreenHeight(5)),
            Container(
              width: getProportionateScreenWidth(40),
              height: getProportionateScreenWidth(40),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isToday ? Colors.blue : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Text(
                day.day.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isToday ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
