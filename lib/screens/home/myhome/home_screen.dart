import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mana_employee_fe/components_buttons/loading.dart';
import 'package:mana_employee_fe/screens/home/myhome/bloc/home_bloc.dart';
import 'package:mana_employee_fe/screens/home/myhome/components/info_user.dart';
import 'package:mana_employee_fe/screens/home/myhome/components/loading_error/error.dart';
import 'package:mana_employee_fe/screens/home/myhome/components/slider_home.dart';
import 'package:mana_employee_fe/screens/rollcall/rollcall_screen.dart';
import 'package:mana_employee_fe/security_user/secure_storage_user.dart';
import 'package:mana_employee_fe/size_config.dart';

import '../../login_register/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();
  late final String? fullName, role, image, email;
  final List<Map<String, dynamic>> menuItems = [
  {
    'title': 'Phân công lịch trực',
    'image': 'assets/images/schedule_assi.png',
    'route': '/phan_cong_lich_truc' // Thay thế bằng route name thực tế
  },
  {
    'title': 'Điểm danh',
    'image': 'assets/images/roll_call.png',
    'route': 'RollCallScreen.routeName' // Thay thế bằng route name thực tế
  },
  {
    'title': 'Xin nghĩ phép',
    'image': 'assets/images/contract.png',
    'route': '/xin_nghi_phep' // Thay thế bằng route name thực tế
  },
  {
    'title': 'Báo cáo tiến độ cuối ngày',
    'image': 'assets/images/process.png',
    'route': '/bao_cao_tien_do' // Thay thế bằng route name thực tế
  },
  {
    'title': 'Đánh giá hiệu quả công việc',
    'image': 'assets/images/bar-chart.png',
    'route': '/danh_gia_hieu_qua' // Thay thế bằng route name thực tế
  },
  {
    'title': 'Tin tức',
    'image': 'assets/images/news.png',
    'route': '/tin_tuc' // Thay thế bằng route name thực tế
  },
];

  @override
  void initState() {
    // TODO: implement initState
    loadDataAndInitializeBloc();
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  Future<void> loadDataAndInitializeBloc() async {
    fullName = await UserSecurityStorage.getFullname();
    role = await UserSecurityStorage.getRole();
    image = await UserSecurityStorage.getImage();
    email = await UserSecurityStorage.getEmail();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeErrorScreenToLoginState) {
          Navigator.pushNamed(context, LoginScreen.routeName);
        }
        if (state is HomeProductClickedState) {
          // state -> chuyen man hinh sang vi tri tuong ung

          // Navigator.pushNamed(context, ProductScreen.routeName,
          //     arguments: state.productId);
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const LoadingScreen();
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              drawer: Drawer(
                  child: InfoUser(
                      fullName: fullName ?? "Not Found",
                      role: role ?? "Not Found",
                      image: image ?? 'assets/images/anhchinh.png',
                      email: email ?? 'Not Found')),
              appBar: buildAppBar(),
              body: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        getProportionateScreenWidth(0),
                        getProportionateScreenHeight(0),
                        getProportionateScreenWidth(0),
                        getProportionateScreenHeight(15)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        //Nội dung thông tin
                        SliderHome(
                            banner: successState.bannersPropose,
                            homeBloc: homeBloc),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),

                        //Phần Dashboard
                        Container(
                          child: SizedBox(
                            height: getFullHeight(),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  getProportionateScreenWidth(10),
                                  getProportionateScreenHeight(10),
                                  getProportionateScreenWidth(10),
                                  getProportionateScreenHeight(10)),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: menuItems.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 4,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          RollCallScreen.routeName,
                                          arguments: index, 
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            menuItems[index]['image'],
                                            height:
                                                40, // Chiều cao của hình ảnh
                                            width:
                                                40, // Chiều rộng của hình ảnh
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            menuItems[index]['title'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          //xemlai
          case HomeErrorState:
            final errorState = state as HomeErrorState;
            return ErrorStateScreen(
              message: errorState.errorMessage,
              homeBloc: homeBloc,
            );
          case HomeErrorScreenToLoginState:
            return const SizedBox(
                child: Center(
              child: Text('HomeErrorScreenToLoginState'),
            ));
          default:
            return const SizedBox();
        }
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo_tecapro.png',
            height: 70,
          ),
          Image.asset(
            'assets/images/tieudengang.png',
            height: getProportionateScreenHeight(40),
            width: getProportionateScreenWidth(270),
          ),
        ],
      ),
    );
  }
}
