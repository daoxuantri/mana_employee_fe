import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mana_employee_fe/screens/dutyschedule/bloc/dutyschedule_bloc.dart';
import 'package:mana_employee_fe/size_config.dart';

class DutyScheduleScreen extends StatefulWidget {
  static String routeName = 'duty-schedule';

  const DutyScheduleScreen({super.key});

  @override
  _DutyScheduleScreenState createState() => _DutyScheduleScreenState();
}

class _DutyScheduleScreenState extends State<DutyScheduleScreen> {
  final List<Map<String, dynamic>> dutySchedule = const [
    {
      "day": "Thứ Hai",
      "tasks": [
        {"role": "Quét dọn vệ sinh", "person": "Vũ Thị Thơm"},
        {
          "role": "Chăm sóc cây & Kiểm tra thiết bị",
          "person": "Đào Xuân Trí"
        },
        {"role": "Giám sát thực hiện", "person": "Hoàng Thị Tuyết"},
      ]
    },
    {
      "day": "Thứ Ba",
      "tasks": [
        {"role": "Quét dọn vệ sinh", "person": "Bùi Diệu Linh"},
        {
          "role": "Chăm sóc cây & Kiểm tra thiết bị",
          "person": "Nguyễn Hoài Phong"
        },
        {"role": "Giám sát thực hiện", "person": "Hoàng Thị Tuyết"},
      ]
    },
    {
      "day": "Thứ Tư",
      "tasks": [
        {"role": "Quét dọn vệ sinh", "person": "Trần Thị Bích Phương"},
        {
          "role": "Chăm sóc cây & Kiểm tra thiết bị",
          "person": "Nguyễn Thành Long"
        },
        {"role": "Giám sát thực hiện", "person": "Hoàng Thị Tuyết"},
      ]
    },
    {
      "day": "Thứ Năm",
      "tasks": [
        {"role": "Quét dọn vệ sinh", "person": "Bùi Diệu Linh"},
        {
          "role": "Chăm sóc cây & Kiểm tra thiết bị",
          "person": "Nguyễn Hoài Phong"
        },
        {"role": "Giám sát thực hiện", "person": "Hoàng Thị Tuyết"},
      ]
    },
    {
      "day": "Thứ Sáu",
      "tasks": [
        {"role": "Quét dọn vệ sinh", "person": "Trần Thị Bích Phương"},
        {
          "role": "Chăm sóc cây & Kiểm tra thiết bị",
          "person": "Đào Xuân Trí"
        },
        {"role": "Giám sát thực hiện", "person": "Hoàng Thị Tuyết"},
      ]
    },
    {
      "day": "Thứ Bảy",
      "tasks": [
        {"role": "Quét dọn vệ sinh", "person": "Phạm Thành Long"},
        {
          "role": "Chăm sóc cây & Kiểm tra thiết bị",
          "person": "Phạm Thành Long"
        },
        {"role": "Giám sát thực hiện", "person": "Nguyễn Ngọc Toàn"},
      ]
    },
    {
      "day": "Chủ Nhật",
      "tasks": [
        {"role": "Quét dọn vệ sinh", "person": "Nguyễn Thành Long"},
        {
          "role": "Chăm sóc cây & Kiểm tra thiết bị",
          "person": "Nguyễn Thành Long"
        },
        {"role": "Giám sát thực hiện", "person": "Nguyễn Ngọc Toàn"},
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<DutyScheduleBloc, DutyScheduleState>(
      // buildWhen: ,
      // listenWhen: ,
      // builder: builder, 
      // listener: listener
      );

    
  }





// return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Lịch trực nhật',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         centerTitle: true,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemCount: dutySchedule.length,
//         itemBuilder: (context, index) {
//           return _buildDutyCard(dutySchedule[index]);
//         },
//       ),
//     );


  Widget _buildDutyCard(Map<String, dynamic> duty) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.0), // Giả sử "bottom" là ý của bạn
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              duty["day"],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(8)),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (duty["tasks"] as List<Map<String, String>>)
                    .map(
                      (task) => Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                task["role"]!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              task["person"]!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}