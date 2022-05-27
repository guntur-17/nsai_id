import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Expanded(
          flex: 2,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Image.asset(
                        'assets/logo_inv.png',
                        height: 95,
                        width: 200,
                      ),
                    ),
                    Column(
                      children: [
                        Text('User',
                            style: whiteTextStyle.copyWith(
                                fontSize: 20, fontWeight: reguler)),
                        Text('Address',
                            style: whiteTextStyle.copyWith(
                                fontSize: 12, fontWeight: reguler))
                      ],
                    )
                  ],
                )
              ],
            ),
          ));
    }

    Widget body() {
      return Expanded(
        flex: 8,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [],
          ),
        ),
      );
    }

    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bghome.png'), fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                header(),
                body(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
