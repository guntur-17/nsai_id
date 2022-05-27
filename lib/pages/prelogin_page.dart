import 'package:flutter/material.dart';
import 'package:nsai_id/pages/home_page.dart';
import 'package:nsai_id/pages/login_page.dart';
import 'package:nsai_id/theme.dart';
import 'package:relative_scale/relative_scale.dart';

class PreloginPage extends StatelessWidget {
  const PreloginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return RelativeBuilder(builder: (context, height, width, sy, sx) {
        return Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        );
      });
    }

    Widget footer() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginPage())));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.16,
                  decoration: const BoxDecoration(
                      color: Color(0xff4980FF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            'Log In',
                            style: whiteTextStyle.copyWith(
                                fontSize: 26, fontWeight: bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomePage())));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: const BoxDecoration(
                          color: Color(0xffF4B940),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                'Register',
                                style: whiteTextStyle.copyWith(
                                    fontSize: 26, fontWeight: bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
          child: Column(
            children: [
              Expanded(
                child: body(),
                flex: 45,
              ),
              Expanded(
                child: footer(),
                flex: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
