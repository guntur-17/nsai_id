import 'package:flutter/material.dart';
import 'package:nsai_id/pages/guide_page.dart';
import 'package:nsai_id/pages/home_page.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/faq_menu.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.8,
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
                    children: const [
                      FaqMenu('Tujuan', HomePage()),
                      FaqMenu('Manfaat', HomePage()),
                      FaqMenu('Registrasi', HomePage()),
                      FaqMenu('Lupa Password', HomePage()),
                      FaqMenu('Penggunaan', GuidePage()),
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
          preferredSize: const Size.fromHeight(80.0),
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
              'FAQ',
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
