import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nsai_id/pages/faq_page.dart';
import 'package:nsai_id/pages/home_page.dart';
import 'package:nsai_id/pages/auth/login_page.dart';

import 'package:nsai_id/providers/auth_provider.dart';
import 'package:nsai_id/providers/distributor_provider.dart';
import 'package:nsai_id/providers/outlet_provider.dart';
import 'package:nsai_id/providers/region_provider.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';
import 'auth/prelogin_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Route route = MaterialPageRoute(builder: (context) => const HomePage());
  String currentAddress = 'My Address';
  Position? currentposition;
  // bool isLoading = false;

  @override
  void initState() {
    // clear();
    // getregion();
    validator();

    super.initState();
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Timer(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => PreloginPage()),
      ),
    );
  }

  // getattendance(token) async {
  //   // SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // var token = prefs.getString('token');
  //   await Provider.of<AttedanceProvider>(context, listen: false)
  //       .getAttendances(token);
  // }

  regionhandler() async {
    await Provider.of<RegionProvider>(context, listen: false).getRegion();
  }

  distributorHandler(token) async {
    await Provider.of<DistributorProvider>(context, listen: false)
        .getDistributors(token);
  }

  outlethandler(token) async {
    await Provider.of<OutletProvider>(context, listen: false).getShops(token);
  }

  userhandler(token, id) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // var token = prefs.getString('token');
    if (await Provider.of<AuthProvider>(context, listen: false)
        .getUser(token: token, id: id)) {
      await outlethandler(token);
      await distributorHandler(token);
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
    var id = prefs.getString('id');
    // var tokensebelah = prefs.getString('')
    if (token != null) {
      userhandler(token, id);
    } else {
      // regionhandler();
      Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => PreloginPage()),
        ),
      );
    }
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
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
