import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mana_employee_fe/api/authencation.dart';
import 'package:mana_employee_fe/components_buttons/bottom_navbar_home.dart';
import 'package:mana_employee_fe/components_buttons/colors.dart';
import 'package:mana_employee_fe/screens/login_register/login/login_screen.dart';
import 'package:mana_employee_fe/security_user/secure_storage_user.dart';
import 'package:mana_employee_fe/size_config.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final String? email;
  late final String? password;
  late bool firstTime;

  @override
  void initState() {
    super.initState();
    _initialize();

  }

  Future<void> _initialize() async {
  await getdata();
  startTimer();
}

  Future<void> getdata() async{
    email = await UserSecurityStorage.getEmail();
    password = await UserSecurityStorage.getPassword();
  }

  Timer ?_timer ; 
  void startTimer() {
  _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
    try {
      if (!mounted) return; 

      if (email != null && password != null) {
        await ApiServiceAuth().login(email!, password!);
        if (!mounted) return; 
        Navigator.pushReplacementNamed(
            context, NavigatorBottomBarHome.routeName);
      } else {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    } catch (e) {
      if (mounted) { 
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    } finally {
      timer.cancel();
    }
  });
}

@override
void dispose() {
  _timer?.cancel();  
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: AppColor.colorWhite,
      child: Center(
        child: Image.asset(
          "assets/images/logo_tecapro.png",
          width: 200,
          height: getProportionateScreenHeight(140),
        ),
      ),
    );
  }
  
  


}