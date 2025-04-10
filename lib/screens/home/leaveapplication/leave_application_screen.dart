import 'package:flutter/material.dart';
import 'package:mana_employee_fe/size_config.dart';
import 'package:intl/intl.dart';

class LeaveApplicationScreen extends StatefulWidget {
  static String routeName = 'leave-app';
  const LeaveApplicationScreen({super.key});

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(label: "Phòng ban", controller: _departmentController),
            _buildTextField(label: "Nội dung", controller: _reasonController, maxLines: 4),
            SizedBox(height: getProportionateScreenHeight(20)),
            _buildDatePicker(),
            SizedBox(height: getProportionateScreenHeight(20)),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text("Gửi đơn"),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Xin nghỉ phép',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, int maxLines = 1}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return ListTile(
      title: Text("Chọn ngày nghỉ"),
      subtitle: Text(_selectedDate == null ? "Chưa chọn ngày" : DateFormat('dd/MM/yyyy').format(_selectedDate!)),
      trailing: Icon(Icons.calendar_today),
      onTap: () async {
        DateTime today = DateTime.now();

        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: today,
          firstDate: today,
          lastDate: DateTime(2100), // Cho phép chọn từ hôm nay trở đi
        );

        if (pickedDate != null && mounted) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
    );
  }

  void _submitForm() {
    String department = _departmentController.text;
    String reason = _reasonController.text;

    if (department.isEmpty || reason.isEmpty || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng điền đầy đủ thông tin")),
      );
      return;
    }

    // Xử lý gửi đơn ở đây
    print("Phòng ban: $department, Lý do: $reason, Ngày nghỉ: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đơn nghỉ phép đã được gửi")),
    );
  }
}
