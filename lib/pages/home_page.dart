import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nsai_id/models/user_model.dart';
import 'package:nsai_id/pages/attendance_page.dart';
import 'package:nsai_id/pages/distributor_page.dart';
import 'package:nsai_id/pages/faq_page.dart';
import 'package:nsai_id/pages/outlet_page.dart';
import 'package:nsai_id/pages/transaction_page.dart';
import 'package:nsai_id/pages/visit_page.dart';

import 'package:nsai_id/providers/auth_provider.dart';
import 'package:nsai_id/providers/distributor_provider.dart';
import 'package:nsai_id/providers/outlet_provider.dart';
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
  initState() {
    // shopHandler();
    distributorHandler();
    // attendanceHandler();
    super.initState();
  }

  distributorHandler() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (await DistributorProvider().getDistributors(token)) setState(() {});
  }

  // shopHandler() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');
  //   await OutletProvider().getShops(token);
  // }

  List<Color> raisingGradient = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  List<Color> lowerGradient = [
    Color.fromARGB(255, 230, 126, 35),
    Color.fromARGB(255, 245, 57, 63),
  ];

  List<LineChartBarData> get comparisonData => [
        currentMonthData,
        previousMonthData,
      ];

  LineChartBarData get currentMonthData => LineChartBarData(
        spots: const [
          FlSpot(0, 3),
          FlSpot(2.6, 2),
          FlSpot(4.9, 5),
          FlSpot(6.8, 3.1),
          FlSpot(8, 4),
          FlSpot(9.5, 3),
          FlSpot(11, 4),
          FlSpot(12, 7),
        ],
        isCurved: false,
        gradient: LinearGradient(
          colors: raisingGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                raisingGradient.map((color) => color.withOpacity(0.3)).toList(),
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      );

  LineChartBarData get previousMonthData => LineChartBarData(
        spots: const [
          FlSpot(0, 7),
          FlSpot(2.6, 4),
          FlSpot(4.9, 3),
          FlSpot(6.8, 4),
          FlSpot(8, 3),
          FlSpot(9.5, 1),
          FlSpot(11, 2),
          FlSpot(12, 0),
        ],
        isCurved: false,
        gradient: LinearGradient(
          colors: lowerGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                lowerGradient.map((color) => color.withOpacity(0.3)).toList(),
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    UserModel user = authProvider.user;

    loader() async {
      WidgetsFlutterBinding.ensureInitialized();

      Loader.show(
        context,
        isSafeAreaOverlay: false,
        // isBottomBarOverlay: false,
        // overlayFromBottom: 80,
        overlayColor: Colors.black26,
        progressIndicator: CircularProgressIndicator(
          color: blueBrightColor,
        ),
        themeData: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: whiteColor),
        ),
      );
    }

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
                            // user.name!,
                            'tester',
                            style: whiteRobotoTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text('Jakarta',
                              style: whiteRobotoTextStyle.copyWith(
                                  fontSize: 12, fontWeight: reguler))
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/ava.png')),
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

    LineChartData currentMonthChart() {
      return LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
            show: false,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        minX: 0,
        maxX: 12,
        minY: 0,
        maxY: 5,
        lineBarsData: [currentMonthData],
      );
    }

    Widget currentMonth() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Color(0xffF4F6F9)),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Bulan Ini',
                        style: trueBlackRobotoTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Januari',
                        style: trueBlackInterTextStyle.copyWith(
                            fontSize: 12, fontWeight: reguler),
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                      child: LineChart(currentMonthChart())),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      );
    }

    LineChartData previousMonthChart() {
      return LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
            show: false,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        minX: 0,
        maxX: 12,
        minY: 0,
        maxY: 5,
        lineBarsData: [previousMonthData],
      );
    }

    Widget previousMonth() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Color(0xffF4F6F9)),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Bulan Lalu',
                        style: trueBlackRobotoTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Desember',
                        style: trueBlackInterTextStyle.copyWith(
                            fontSize: 12, fontWeight: reguler),
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                      child: LineChart(previousMonthChart())),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      );
    }

    LineChartData comparisonChart() {
      return LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
            show: false,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        minX: 0,
        maxX: 12,
        minY: 0,
        maxY: 5,
        lineBarsData: comparisonData,
      );
    }

    Widget comparison() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            color: Color(0xffF4F6F9)),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Perbandingan',
                        style: trueBlackRobotoTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Desember - Januari',
                        style: trueBlackInterTextStyle.copyWith(
                            fontSize: 12, fontWeight: reguler),
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                      child: LineChart(comparisonChart())),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
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
                              route: DistributorListPage(),
                              // function: attendanceHandler(),
                            ),
                            HomeMenu(
                              title: 'Visit',
                              imgpath: 'assets/pin.png',
                              route: OutletListPage(),
                            ),
                            HomeMenu(
                                title: 'Transaksi',
                                imgpath: 'assets/chart.png',
                                route: TransactionPage()),
                            HomeMenu(
                              title: 'FAQ',
                              imgpath: 'assets/faq.png',
                              route: FaqPage(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      decoration: BoxDecoration(
                          // color: Colors.blue,
                          ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              children: [
                                Text('Sales Peformance',
                                    style: trueBlackRobotoTextStyle.copyWith(
                                        fontSize: 16, fontWeight: semiBold)),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 14),
                            child: currentMonth(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 14),
                            child: previousMonth(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, bottom: 14),
                            child: comparison(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
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
