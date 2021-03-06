import 'package:flutter/material.dart';
import 'package:flutter_nb/resource/colors.dart';
import 'package:flutter_nb/ui/page/login_page.dart';
import 'package:flutter_nb/ui/page/main/main_page.dart';
import 'package:flutter_nb/ui/page/splash_page.dart';
import 'package:flutter_nb/utils/object_util.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: ObjectUtil.getThemeColor(),
            accentColor: ObjectUtil.getThemeSwatchColor(color: 'lightBlue'),
            indicatorColor: ObjectUtil.getThemeColor()),
        home: new SplashPage(),
        routes: {
          '/LoginPage': (ctx) => LoginPage(),
          '/MainPage': (ctx) => MainPage(),
        });
  }
}
