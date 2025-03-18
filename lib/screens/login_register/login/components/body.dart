import 'package:flutter/material.dart';
import 'package:mana_employee_fe/screens/login_register/login/components/sign_in_form.dart';
import 'package:mana_employee_fe/size_config.dart'; 

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Login Screen
        SizedBox(
          width: double.infinity,
          height: SizeConfig.screenHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
               Center(
                  child: Image.asset(
                    'assets/images/logo_tecapro.png',
                    width: getProportionateScreenWidth(200),
                    height: getProportionateScreenWidth(130),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(36),
                ),
                Center(
                  child: Text(
                    "Đăng nhập tài khoản thành viên",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(22),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),SizedBox(
                  height: getProportionateScreenHeight(45),
                ),
                Center(
                  child: SizedBox(
                    width: SizeConfig.screenWidth * 0.85,
                    child: SignInForm(),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}