import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nsai_id/pages/faq_page.dart';
import 'package:nsai_id/pages/home_page.dart';
import 'package:nsai_id/pages/login_page.dart';
import 'package:nsai_id/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';
import 'prelogin_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Route route = MaterialPageRoute(builder: (context) => const HomePage());
  // bool isLoading = false;

  @override
  void initState() {
    validator();

    super.initState();
  }

  getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    if (await Provider.of<AuthProvider>(context, listen: false)
        .getUser(token: token)) {
      Navigator.pushReplacement(context, route);
    } else {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => PreloginPage()),
        ),
      );
    }
    // Navigator.pushReplacement(context, route);
  }

  validator() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    if (token != null) {
      setState(() {
        print(token);
        getUser();
      });
    } else {
      Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => PreloginPage()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/logo.png",
                  width: sx(200),
                  height: sy(200),
                ),
                Image.asset(
                  "assets/logo2.png",
                  width: sx(135),
                  height: sy(135),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
