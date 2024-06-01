import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:quizapp/config/get_it_config.dart';
import 'package:quizapp/view/quiz_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        padding: const EdgeInsets.all(20),
        // height: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topLeft,
            image: AssetImage(
              'assets/images/pecture.png',
            ),
          ),
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topLeft,
            image: AssetImage(
              'assets/images/Ellipse 14.png',
            ),
          ),
        ),
      ),
      Positioned(
        right: 177,
        bottom: 550,
        child: Container(
          child: Text(
            "LOGIN",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color(0xff914576)),
          ),
        ),
      ),
      Positioned(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topLeft,
              image: AssetImage(
                'assets/images/Ellipse 12.png',
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 500,
        child: Container(
          height: 41,
          width: 41,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffE8C082), Color(0xff914576)]),
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
      ),
      Positioned(
        bottom: 650,
        right: 150,
        child: Container(
          height: 20,
          width: 20,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffE8C082), Color(0xffB76C92)]),
              borderRadius: BorderRadius.all(Radius.circular(100))),
        ),
      ),
      Positioned(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.bottomRight,
              image: AssetImage(
                'assets/images/Ellipse 8.png',
              ),
            ),
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 200),
          Container(
            width: 300,
            child: TextField(
              enabled: true,
              controller: email,
              onChanged: (value) {},
              
              decoration: const InputDecoration(
             
                prefixIcon: Icon(
                  Icons.email,
                  color: Color(0xff914576),
                ),
                hintText: "user@gmail.com",
                hintStyle: TextStyle(color: Color(0xff914576), fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff914576), width: 2),
                
                  borderRadius: BorderRadius.all(Radius.circular(
                    30,
                  )),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 300,
            child: TextField(
              controller: password,
              onChanged: (value) {},
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Color(0xff914576),
                ),
                hintText: "Password",
                hintStyle: TextStyle(color: Color(0xff914576), fontSize: 15),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff914576), width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              obscureText: true,
            ),
          ),
          InkWell(
            onTap: () {
              core.get<SharedPreferences>().setString('email', email.text);
              if (email.text == 'Haitham' && password.text == '123') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  showCloseIcon: true,
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  content: Text("Success"),
                  backgroundColor: Colors.green,
                ));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizApp()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  showCloseIcon: true,
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  content: Text("Erorr"),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                width: 400,
                height: 59,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                        colors: [Color(0xffDA8BD9), Color(0xffF3BD6B)]),
                    color: const Color(0xff230C02)),
                child: const Center(
                    child: Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                )),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    ]));
  }
}
