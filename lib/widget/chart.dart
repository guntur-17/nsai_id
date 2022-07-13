import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nsai_id/models/history_attendance_model.dart';
import 'package:nsai_id/models/item_taken_model.dart';
import 'package:nsai_id/services/item_taken_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/attendance_provider.dart';
import '../theme.dart';
import 'loading_widget.dart';

class ChartBar extends StatefulWidget {
  const ChartBar({Key? key}) : super(key: key);

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  bool isLoading = false;
  List<ItemTakenModel> data = allItemTaken;
  List<ItemTakenModel> _itemTaken = [];
  List<FlSpot> _widgetsCurrent = [];
  List<FlSpot> _widgetsPrevious = [];
  List months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

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

  List<FlSpot> getAccData() {
    List<FlSpot> accList = [];
    for (int i = 0; i <= data.length; i++) {
      accList.add(FlSpot((i * 1.00), data[i].sales_result!.toDouble() / 1.00));
    }
    return accList;
  }

  getCurrentMonthData() {
    List<FlSpot> widgets = [];
    List<ItemTakenModel> currentMonth = [];
    var i = 0;
    var sumMap = {};

    DateTime current = DateTime.now();
    String month = current.month.toString();
    currentMonth = _itemTaken
        .where((element) => element.createdAt!.month.toString() == month)
        .toList();

    for (var element in currentMonth) {
      String key = element.createdAt!.day.toString();
      if (sumMap.containsKey(key)) {
        sumMap[key] += element.sales_result;
      } else {
        sumMap[key] = element.sales_result!;
      }
    }

    // print(currentMonth);
    // print(sumMap);
    for (var item in sumMap.values) {
      widgets.add(FlSpot(i.toDouble(), (item / 1000000.00)));
      i++;
    }
    _widgetsCurrent = widgets;
    // print(_widgetsCurrent);
    return widgets;
  }

  getPreviousMonthData() {
    List<FlSpot> widgets = [];
    List<ItemTakenModel> previousMonth = [];
    var i = 0;
    var sumMap = {};

    DateTime current = DateTime.now();
    int month = current.month;
    previousMonth = _itemTaken
        .where((element) => element.createdAt!.month - month == -1)
        .toList();

    for (var element in previousMonth) {
      String key = element.createdAt!.day.toString();
      if (sumMap.containsKey(key)) {
        sumMap[key] += element.sales_result;
      } else {
        sumMap[key] = element.sales_result!;
      }
    }

    // print(previousMonth);
    // print(sumMap);
    for (var item in sumMap.values) {
      widgets.add(FlSpot(i.toDouble(), (item / 1000000.00)));
      i++;
    }
    _widgetsPrevious = widgets;
    // print('ini' + _widgetsPrevious.toString());
    return widgets;

    // List<FlSpot> widgets = [];
    // var i = 0;
    // for (var item in data) {
    //   DateTime current = DateTime.now();
    //   int month = current.month;
    //   if (item.createdAt!.month - month == -1) {
    //     widgets
    //         .add(FlSpot(i.toDouble(), (item.sales_result!.toDouble() / 1.00)));
    //     i++;
    //   }
    // }
    // return widgets;
  }

  maxValue() {
    List<int> _max = [];

    for (var max in data) {
      _max.add(max.sales_result!);
    }
    int _maxed = _max.reduce(max);

    return _maxed.toDouble();
  }

  // listOfSum() {
  //   var sumMap = {};

  //   for (var product in data) {
  //     if (sumMap.containsKey(product.createdAt!.day)) {
  //       sumMap[product.createdAt!.day.toString()] += product.total_item_sold!;
  //     } else {
  //       sumMap[product.createdAt!.day.toString()] = product.total_item_sold!;
  //     }
  //   }
  //   print(sumMap);
  //   return sumMap;
  // }

  @override
  void initState() {
    handler();
    super.initState();
  }

  handler() async {
    setState(() {
      isLoading = true;
    });
    await _handlefunction();

    if (!mounted) return;
    await getCurrentMonthData();
    await getPreviousMonthData();
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  handlerHistory() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    // var token = prefs.getString('token');
    // var id = prefs.getString('id');
    // await Provider.of<AttendanceProvider>(context, listen: false)
    //     .getAttendancesHistory(token, id);
    AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    // List distributor = distributorProvider.distributors.toList();

    List<AttendanceHistoryModel> list =
        attendanceProvider.attendancesHistory.toList();
    for (var _item in list) {
      _itemTaken.addAll(_item.item!);
    }
  }

  Future _handlefunction() async {
    await handlerHistory();
    if (!mounted) return;
    print(_itemTaken);
  }

  LineChartBarData get currentMonthData => LineChartBarData(
        spots: getCurrentMonthData(),
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
        spots: getPreviousMonthData(),
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
    // double revenueSum = 0;
    // for (var item in data) {
    //   revenueSum += item.total_item_sold!;
    // }
    // listOfSum();
    var now = DateTime.now();
    final monthName = now.month;

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
        maxX: _widgetsCurrent.length / 1.00 - 1,
        minY: 0,
        maxY: 25,
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
                        months[monthName - 1],
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
        maxX: _widgetsPrevious.length / 1.00 - 1,
        minY: 0,
        maxY: 25,
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
                        months[monthName - 2],
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
        maxX: 31,
        minY: 0,
        maxY: 25,
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
                        months[monthName - 2] + ' - ' + months[monthName - 1],
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

    return Expanded(
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
            isLoading
                ? Loading()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 14),
                        child: currentMonth(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 14),
                        child: previousMonth(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 14),
                        child: comparison(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
