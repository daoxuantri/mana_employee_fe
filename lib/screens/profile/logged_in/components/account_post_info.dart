
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mana_employee_fe/model/user/get_infor_user_model.dart';
// import 'package:mana_employee_fe/screens/profile/components/container_rad35.dart';
// import 'package:mana_employee_fe/size_config.dart'; 

// class AccountPostInfo extends StatelessWidget {
//   const AccountPostInfo(
//       {super.key, required this.profile,
//       });

//     final InfoUserDataModel profile;


//   @override
//   Widget build(BuildContext context) {
//     return ContainerRad35(
//       padding: const EdgeInsets.all(25),
//         child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // Post
//         customText(profile.bonuspoint, "Điểm tích lũy"),
//         verticalDivider(),
//         customText(profile.ordersTotalItems, "Đơn hàng"),
//         verticalDivider(),
//         customText(0, "Yêu thích"),
//         verticalDivider(),
//         customText(profile.cartTotalItems, "Giỏ hàng"),
//       ],
//     ));
//   }

//   Widget customText(int? number, String text) {
//     return Column(children: [
//       Center(
//         child: Text(
//           number.toString(),
//           style: const TextStyle(
//             fontWeight: FontWeight.w600,
//             fontSize: 15,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       Text(
//         "\n$text",
//         style: const TextStyle(
//           fontWeight: FontWeight.w400,
//           fontSize: 12,
//           color: Color(0xff8E8E93),
//           height: 0.5
//         ),
//       ),
//     ]);
//   }

//   Widget verticalDivider() {
//     return Container(
//       width: 1,
//       color: const Color(0xff8E8E93),
//       height: getProportionateScreenHeight(30),
//     );
//   }
// }
