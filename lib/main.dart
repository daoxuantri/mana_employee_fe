import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mana_employee_fe/routes.dart';
import 'package:mana_employee_fe/screens/splash/splash_screen.dart';
import 'package:mana_employee_fe/theme.dart';

void main() {
  runApp(const MyApp());
}


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Management Employee',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
        
    );
  }
}
    