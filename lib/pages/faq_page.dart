import 'package:flutter/material.dart';
import 'package:nsai_id/pages/guide_page.dart';
import 'package:nsai_id/pages/home_page.dart';
import 'package:nsai_id/pages/auth/prelogin_page.dart';
import 'package:nsai_id/pages/test_print.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/faq_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auth_provider.dart';
import 'transaction_report_page.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleLogout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      if (await authProvider.logout(token: token)) {
        prefs.clear();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PreloginPage()),
            (route) => false);
      }
    }

    Widget body() {
      return Expanded(
        child: Stack(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Image(
                    image: AssetImage('assets/faq.png'),
                    height: 130,
                    width: 130,
                  ),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Column(
                    children: [
                      FaqMenu(title: 'Menu 1'),
                      FaqMenu(title: 'Menu 2'),
                      FaqMenu(title: 'Menu 3'),
                      FaqMenu(title: 'Menu 4'),
                      FaqMenu(title: 'Menu 5'),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: InkWell(
                          onTap: () {
                            handleLogout();
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 166, 14, 3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                'Log Out',
                                style:
                                    whiteInterTextStyle.copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            titleSpacing: 0,
            toolbarHeight: 120,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: whiteColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0.0,
            title: Text(
              'Lainnya',
              style: whiteRobotoTextStyle.copyWith(
                  fontSize: 20, fontWeight: semiBold),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bgyellow.png'),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                // header(),
                body(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
