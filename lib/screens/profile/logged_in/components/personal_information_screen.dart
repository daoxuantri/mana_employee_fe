import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:mana_employee_fe/size_config.dart';

class PersonalInformationScreen extends StatefulWidget {
  static String routeName = 'personal_information';
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() => _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  File? _imageFile;
  final picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController(text: "Đào Xuân Trí");
  final TextEditingController _dobController = TextEditingController(text: "26-11-2002");
  final TextEditingController _employeeIdController = TextEditingController(text: "GT01-1");
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(text: "0964933467");

  String _selectedGender = "Nam";

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ảnh đại diện
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!) as ImageProvider
                      : AssetImage('assets/images/anhchinh.png'),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, size: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),

            // Thông tin cá nhân
            _buildSectionTitle("THÔNG TIN CÁ NHÂN"),
            _buildTextField(label: "Họ và tên", controller: _nameController),
            _buildDatePicker(),
            _buildTwoColumnFields("Mã nhân viên", _employeeIdController, "Giới tính"),
            _buildTextField(label: "Địa chỉ", controller: _addressController),
            _buildTextField(label: "Số điện thoại", controller: _phoneController, keyboardType: TextInputType.phone),

            SizedBox(height: getProportionateScreenHeight(20)),
            _buildSectionTitle("HỒ SƠ CÔNG TY"),
            // Các trường bổ sung nếu cần

            SizedBox(height: getProportionateScreenHeight(30)),
            ElevatedButton(
              onPressed: () {
                // Xử lý lưu thông tin
              },
              child: Text("Lưu thông tin"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
      ),
    );
  }

  Widget _buildTwoColumnFields(String label1, TextEditingController controller1, String label2) {
    return Row(
      children: [
        Expanded(child: _buildTextField(label: label1, controller: controller1)),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedGender,
            items: ["Nam", "Nữ", "Khác"].map((gender) {
              return DropdownMenuItem(value: gender, child: Text(gender));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
            decoration: InputDecoration(
              labelText: label2,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return GestureDetector(
      onTap: () async {
        DateTime initialDate = DateFormat("dd-MM-yyyy").parse(_dobController.text);
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            _dobController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
          });
        }
      },
      child: AbsorbPointer(
        child: _buildTextField(label: "Ngày sinh", controller: _dobController),
      ),
    );
  }
}
