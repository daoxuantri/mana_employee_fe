import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mana_employee_fe/model/user/get_infor_user_model.dart';
import 'package:mana_employee_fe/size_config.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar(
      {super.key, required this.isLogin, this.username, this.isActivate,required this.profile});

  final InfoUserDataModel profile;
  final bool isLogin;
  final String? username;
  final bool? isActivate;

  @override
  Widget build(BuildContext context) {
    double avatarHeight = getProportionateScreenHeight(75);
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight + 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                  height: avatarHeight,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Text('Text data')),
            ),
          ),
          space(10),
          // state
          if (isLogin == true)
            Container(
              padding:
                  const EdgeInsets.only(top: 5, right: 30, bottom: 5, left: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xffFF3B30)),
              child: const Text(
                "Chưa kích hoạt",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget space(double size) {
    return SizedBox(
      height: getProportionateScreenHeight(size),
    );
  }
}
