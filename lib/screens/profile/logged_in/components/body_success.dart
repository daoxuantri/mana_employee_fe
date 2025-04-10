import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mana_employee_fe/model/user/get_infor_user_model.dart';
import 'package:mana_employee_fe/screens/profile/components/container_rad35.dart';
import 'package:mana_employee_fe/screens/profile/logged_in/components/personal_information_screen.dart';
import 'package:mana_employee_fe/size_config.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../bloc/profile_bloc.dart';

class BodySuccess extends StatelessWidget {
  const BodySuccess(
      {super.key, required this.profile, required this.profileBloc});

  final InfoUserDataModel profile;
  final ProfileBloc profileBloc;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Phần Thông tin nhân viên (Không có AppBar)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white, // Nền xám nhẹ
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(0)), // Bo góc dưới
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showQRCodeDialog(context);
                        },
                        child: Icon(
                        Icons.qr_code,
                        size: 23,
                      ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context ,PersonalInformationScreen.routeName);
                        },
                        child: Text(
                          'Sửa',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5),
                  ),
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(10.0), // Đặt bán kính bo tròn góc
                    child: Container(
                      width: 100.0, // Đặt chiều rộng hình vuông
                      height: 100.0, // Đặt chiều cao hình vuông
                      child: profile.images == null
                          ? Image.asset('assets/images/ic_default_avatar.png',
                              fit: BoxFit.cover)
                          : Image.network(profile.images.toString(),
                              fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    profile.fullname ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Nhân viên • ${profile.contact}",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Danh sách menu bên dưới
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: ContainerRad35(
                    child: Column(
                      children: [
                        _buildListItem(Icons.bar_chart, "Báo cáo"),
                        _buildListItem(Icons.calendar_today, "Quản lý phép"),
                        _buildListItem(Icons.attach_money, "Phiếu lương"),
                        _buildListItem(Icons.language, "Ngôn ngữ",
                            trailing: Text("Tiếng Việt")),
                        _buildListItem(Icons.notifications, "Cài đặt cảnh báo"),
                        _buildListItem(Icons.business, "Đổi doanh nghiệp"),
                        _buildListItem(Icons.info, "Thông tin ứng dụng"),
                        _buildListItem(Icons.refresh, "Làm mới ứng dụng"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  //create function
void _showQRCodeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("QR Code của bạn", textAlign: TextAlign.center,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(200), // Kích thước cố định
              height: getProportionateScreenHeight(200),
              child: QrImageView(
                data: "${profile.fullname}|${profile.contact}", // Thông tin user
                version: QrVersions.auto,
                size: 200,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10),),
            Text("Quét mã để lấy thông tin",style: TextStyle(color: Colors.blueGrey, fontSize: 13, fontWeight: FontWeight.w500),),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Đóng",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
          ),
        ],
      );
    },
  );
}


  Widget _buildListItem(IconData icon, String title, {Widget? trailing}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}


