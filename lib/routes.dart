
import 'package:flutter/material.dart';
import 'package:mana_employee_fe/components_buttons/bottom_navbar_home.dart';
import 'package:mana_employee_fe/screens/assign_work/assignwork_screen.dart';
import 'package:mana_employee_fe/screens/dutyschedule/duty_schedule_screen.dart';
import 'package:mana_employee_fe/screens/home/leaveapplication/leave_application_screen.dart';
import 'package:mana_employee_fe/screens/home/myhome/home_screen.dart';
import 'package:mana_employee_fe/screens/login_register/login/login_screen.dart';
import 'package:mana_employee_fe/screens/profile/logged_in/components/personal_information_screen.dart';
import 'package:mana_employee_fe/screens/profile/profile_screen.dart';
import 'package:mana_employee_fe/screens/rollcall/rollcall_screen.dart';
import 'package:mana_employee_fe/screens/splash/splash_screen.dart';

final Map<String , WidgetBuilder> routes ={
  //splash
  SplashScreen.routeName : (context) => const SplashScreen(),

  // //login
  LoginScreen.routeName : (context) => const LoginScreen(),

  // //forgotpassword
  // ForgetPassWordScreen.routeName : (context) => const ForgetPassWordScreen(),

  // //signup
  // SignUpScreen.routeName :(context) => const SignUpScreen(),

  //  /*-------------------Dieu huong bottom navigation bar--------------------------*/
   
  // //Navigator Bottom bar
  NavigatorBottomBarHome.routeName : (context) => const NavigatorBottomBarHome(),

  //home
  HomeScreen.routeName : (context) => const HomeScreen(),
  // class children (home)
  LeaveApplicationScreen.routeName : (context) => LeaveApplicationScreen(),
  AssignWorkScreen.routeName : (context) => const AssignWorkScreen(),
  DutyScheduleScreen.routeName : (context) => const DutyScheduleScreen(),

  //roll-call
  RollCallScreen.routeName : (context) => const RollCallScreen(), 
  

  MyProfileScreen.routeName :(context) => const MyProfileScreen(),
  //children of My Profile Screen
  PersonalInformationScreen.routeName : (context) => const PersonalInformationScreen(),
  // //user 

  // /*-----------------------------------------------------------------------------*/

  // //form email pass
  // // FormEmailPass.routeName : (context) => const FormEmailPass(),
  // IDEmail.routeName : (context) => const IDEmail(),

  // //respass
  // ResetPassScreen.routeName : (context) => const ResetPassScreen(),
  
  // //all product screen
  // AllProductScreen.routeName :(context) => const AllProductScreen(),
  // ProductScreen.routeName :(context) => const ProductScreen(),
  // MyCartScreen.routeName :(context) => const MyCartScreen(),



  // //children file user profile 
  // EditUserInfo.routeName :(context) => const EditUserInfo(),
  // AddressScreen.routeName :(context) => const AddressScreen(),
  // AddAddressScreen.routeName: (context) => const AddAddressScreen(),

  // //check-out
  // CheckoutScreen.routeName : (context) => const CheckoutScreen(),
  // VNPayScreen.routeName : (context) => const VNPayScreen(),

  
  // MyOrdersScreen.routeName : (context) => const MyOrdersScreen(),
  // ListAllProductCategoryScreen.routeName : (context) => const ListAllProductCategoryScreen(),
  







};