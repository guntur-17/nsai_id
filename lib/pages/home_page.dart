import 'dart:async';
import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsai_id/models/outlet_model.dart';
import 'package:nsai_id/models/user_model.dart';
import 'package:nsai_id/pages/absent/absent_tab.dart';
import 'package:nsai_id/pages/absent/attendance_page.dart';
import 'package:nsai_id/pages/absent/distributor_list_page.dart';
import 'package:nsai_id/pages/document_page.dart';
import 'package:nsai_id/pages/faq_page.dart';
import 'package:nsai_id/pages/list_test_page.dart';
import 'package:nsai_id/pages/list_test_page2.dart';
import 'package:nsai_id/pages/profile_page.dart';
import 'package:nsai_id/pages/visit/visit_list_page.dart';
import 'package:nsai_id/pages/transaction_page.dart';
import 'package:nsai_id/pages/outlet_page.dart';
import 'package:nsai_id/pages/visit/visit_tab.dart';
import 'package:nsai_id/providers/attendance_provider.dart';

import 'package:nsai_id/providers/auth_provider.dart';
import 'package:nsai_id/providers/distributor_provider.dart';
import 'package:nsai_id/providers/outlet_provider.dart';
import 'package:nsai_id/widget/chart.dart';
import 'package:nsai_id/widget/home_menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // shopHandler();
    // distributorHandler();
    // attendanceHandler();
    Timer(
      const Duration(microseconds: 10),
      () {
        int randomIndex = Random().nextInt(yourList.length);

        var snackBar = SnackBar(
          /// need to set following properties for best effect of awesome_snackbar_content
          elevation: 0,
          duration: Duration(seconds: 5),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Halo!',
            message: yourList[randomIndex],

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.help,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
    parentHandler();
    super.initState();
  }

  // getUser(token, id) async {
  //   if (await Provider.of<AuthProvider>(context, listen: false)
  //       .getUser(token: token, id: id)) {
  //     setState(() {});
  //   }
  // }

  parentHandler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var id = prefs.getString('id');

    // getUser(token, id);
  }

  // shopHandler() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');
  //   await OutletProvider().getShops(token);
  // }
  List yourList = [
    "Kalimat 1",
    "Kalimat 2",
    "Kalimat 3",
    "Kalimat 4",
    "Kalimat 5"
  ];

  @override
  Widget build(BuildContext context) {
    OutletProvider outletProvider =
        Provider.of<OutletProvider>(context, listen: false);
    late List<OutletModel> outlet = outletProvider.outlets;
    late List<OutletModel> _outlet = outlet;

    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    // OutletProvider outletProvider = context.watch<OutletProvider>();

    AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    // List distributor = distributorProvider.distributors.toList();

    List list = attendanceProvider.attendancesHistory.toList();
    print(list);

    UserModel user = authProvider.user;

    Widget header() {
      return Expanded(
        flex: 9,
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Image.asset(
                  'assets/logo_inv.png',
                  height: 95,
                  width: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 43.5,
                  right: 20.0,
                ),
                child: Container(
                  // decoration: BoxDecoration(color: redColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.nick_name!,
                            style: whiteRobotoTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            user.region!,
                            style: whiteRobotoTextStyle.copyWith(
                                fontSize: 12, fontWeight: reguler),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(),
                                  ));
                            }),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/ava.png')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12.0, right: 8, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DocumentPage(),
                              ));
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff101828).withOpacity(0.1),
                                spreadRadius: -4,
                                blurRadius: 16,
                                offset:
                                    Offset(0, 12), // changes position of shadow
                              ),
                            ],
                          ),
                          height: 70,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/case.png',
                                height: 36,
                                width: 36,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  'Dokumenku',
                                  style: trueBlackRobotoTextStyle.copyWith(
                                      fontSize: 12, fontWeight: reguler),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff101828).withOpacity(0.1),
                              spreadRadius: -4,
                              blurRadius: 16,
                              offset:
                                  Offset(0, 12), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 70,
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 8, bottom: 8, right: 16, left: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Kehadiran',
                                      style: trueBlackRobotoTextStyle.copyWith(
                                          fontSize: 12, fontWeight: semiBold)),
                                ],
                              ),
                              Divider(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hadir',
                                    style: trueBlackRobotoTextStyle.copyWith(
                                        fontSize: 12),
                                  ),
                                  Text(
                                    'XX',
                                    style: blueRobotoTextStyle.copyWith(
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tidak',
                                    style: trueBlackRobotoTextStyle.copyWith(
                                        fontSize: 12),
                                  ),
                                  Text(
                                    'XX',
                                    style: redRobotoTextStyle.copyWith(
                                        fontSize: 12),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      return Expanded(
        flex: 31,
        child: Container(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                // top: 12.0,
                right: 16,
                left: 16,
                bottom: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.red,
                            ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            HomeMenu(
                              title: 'Absensi',
                              imgpath: 'assets/check.png',
                              route: AbsentTab(),
                              // function: attendanceHistoryHandler(),
                              // function: attendanceHandler(),
                            ),
                            HomeMenu(
                              title: 'Visit',
                              imgpath: 'assets/pin.png',
                              route: VisitTab(_outlet),
                              // function: outlethandler(),
                            ),
                            HomeMenu(
                                title: 'Transaksi',
                                imgpath: 'assets/chart.png',
                                route: TransactionPage()),
                            HomeMenu(
                              title: 'Lain-lain',
                              imgpath: 'assets/faq.png',
                              route: FaqPage(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  ChartBar()
                ],
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bghome.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    header(),
                    body(),
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
