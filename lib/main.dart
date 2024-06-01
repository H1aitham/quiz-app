import 'package:flutter/material.dart';
import 'package:quizapp/config/get_it_config.dart';
import 'package:quizapp/view/login_page.dart';
import 'package:quizapp/view/quiz_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MyApp());
}

// late double width;
// late double height;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // width = MediaQuery.sizeOf(context).width;

    return MaterialApp(
        // home: LayoutBuilder(builder: (context, screeninfo) {
        //   if (screeninfo.maxWidth < 300) {
        //     return MobileHomePage();
        //   } else {
        //     return TabletHomePage();
        //   }
        // }),
        debugShowCheckedModeBanner: false,
        home: LoginPage());
  }
}
