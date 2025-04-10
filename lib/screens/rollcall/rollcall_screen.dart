import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    // employeeId = await UserSecurityStorage.getId();
    employeeId = '67cdb950d434b69cb94ec7d6';
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
              backgroundColor: Colors.white,
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
                      SizedBox(height: getProportionateScreenHeight(10)),
                      // Bảng check-in/check-out
                      DataTable(
                        border: TableBorder.all(color: Colors.black, width: 1),
                        columns: const [
                          DataColumn(
                              label: Text('Tên',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))),
                          DataColumn(
                              label: Text('Thời gian',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))),
                        ],
                        rows: [
                          DataRow(
                            color: MaterialStateProperty.resolveWith<Color?>(
                                (states) => Colors.white),
                            cells: [
                              const DataCell(Text('Check In',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                              DataCell(
                                Text(
                                  successState.morningCheckInTime != null
                                      ? formatTime(
                                          successState.morningCheckInTime!)
                                      : 'Chưa check',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            color: MaterialStateProperty.resolveWith<Color?>(
                                (states) => Colors.white),
                            cells: [
                              const DataCell(Text('Check Out',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
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
    double allowedRadius = 100; // 100m là bán kính cho phép
    double branchLatitude =
        10.346246800237312; // Toạ độ chi nhánh cần thay đổi cho đúng
    double branchLongitude = 107.09377785263734;

    double distance = Geolocator.distanceBetween(
        position.latitude, position.longitude, branchLatitude, branchLongitude);

    if (distance > allowedRadius) {
      _showOutOfRangeDialog(distance, position.latitude, position.longitude);
      return;
    }

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

  void _showOutOfRangeDialog(
      double distance, double latitude, double longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Chấm công chưa hợp lệ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getProportionateScreenHeight(10)),

                // 🟢 Nội dung thông báo chính
                Text(
                  "Vị trí của bạn (${distance.toStringAsFixed(0)}m), ngoài bán kính cho phép (30m).",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getProportionateScreenHeight(6)),

                Text(
                  "Vui lòng kiểm tra lại GPS và thử lại.",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bước 1: ",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                    Expanded(
                      child: Text(
                        "Tắt/bật thiết lập định vị GPS (dịch vụ vị trí) trên điện thoại hoặc kiểm tra vị trí bằng Google Maps và thử lại.",
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bước 2: ",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                    Expanded(
                      child: Text(
                        "Khởi động lại ứng dụng và chấm lại.",
                        softWrap: true,
                      ),
                    ),
                  ],
                ),

                // 🟢 Bản đồ Google hiển thị vị trí hiện tại và vị trí văn phòng
                // SizedBox(
                //   height: getProportionateScreenHeight(
                //       300), // Tăng kích thước để đảm bảo hiển thị
                //   width: double.infinity,
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: GoogleMap(
                //       initialCameraPosition: CameraPosition(
                //         target: LatLng(latitude, longitude),
                //         zoom: 16,
                //       ),
                //       onMapCreated: (GoogleMapController controller) {
                //         // Lưu trữ controller nếu cần thiết
                //       },
                //       markers: {
                //         Marker(
                //           markerId: MarkerId("currentLocation"),
                //           position: LatLng(latitude, longitude),
                //           infoWindow: InfoWindow(title: "Vị trí của bạn"),
                //           icon: BitmapDescriptor.defaultMarkerWithHue(
                //             BitmapDescriptor.hueBlue,
                //           ),
                //         ),
                //         Marker(
                //           markerId: MarkerId("officeLocation"),
                //           position:
                //               LatLng(10.346246800237312, 107.09377785263734),
                //           infoWindow: InfoWindow(title: "Văn phòng"),
                //           icon: BitmapDescriptor.defaultMarkerWithHue(
                //             BitmapDescriptor.hueRed,
                //           ),
                //         ),
                //       },
                //     ),
                //   ),
                // ),

                SizedBox(height: getProportionateScreenHeight(16)),

                // 🟢 Nút thử lại
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("Thử lại", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
