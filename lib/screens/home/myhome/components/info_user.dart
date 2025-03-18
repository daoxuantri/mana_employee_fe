import 'package:flutter/material.dart';
import 'package:mana_employee_fe/screens/login_register/login/login_screen.dart';
import 'package:mana_employee_fe/security_user/secure_storage_user.dart';
import 'package:mana_employee_fe/size_config.dart';

class InfoUser extends StatelessWidget {
  final String fullName;
  final String role;
  final String image;
  final String email;
  const InfoUser({super.key, required this.fullName, required this.role, required this.image, required this.email});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(fullName),

          //sau này chuyển này thành role : Vị trí của người đó
          accountEmail: Text(email),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage(image),
          ),
          decoration: BoxDecoration(color: Colors.blueAccent),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Logout'),
          onTap: () {
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
        ),
      ],
    );
  }
}
