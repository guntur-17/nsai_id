import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nsai_id/models/item_taken_model.dart';
import 'package:nsai_id/services/item_taken_service.dart';

import '../theme.dart';

class ChartBar extends StatefulWidget {
  const ChartBar({Key? key}) : super(key: key);

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  List<itemTakenModel> data = allItemTaken;
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
      accList.add(FlSpot((i * 1.00), data[i].sales_result! / 1.00));
    }
    return accList;
  }

  getCurrentMonthData() {
    List<FlSpot> widgets = [];
    var i = 0;
    for (var item in data) {
      DateTime current = DateTime.now();
      String month = current.month.toString();
      if (item.createdAt!.month.toString() == month) {
        widgets.add(FlSpot(i.toDouble(), (item.sales_result! / 1.00)));
        i++;
      }
    }
    return widgets;
  }

  getPreviousMonthData() {
    List<FlSpot> widgets = [];
    var i = 0;
    for (var item in data) {
      DateTime current = DateTime.now();
      int month = current.month;
      // print(month);
      // print(item.createdAt!.month);
      // print(item.createdAt!.month - month);
      if (item.createdAt!.month - month == -1) {
        widgets.add(FlSpot(i.toDouble(), (item.sales_result! / 1.00)));
        i++;
      }
    }
    return widgets;
  }

  maxValue() {
    List<double> _max = [];

    for (var max in data) {
      _max.add(max.sales_result!);
    }
    double _maxed = _max.reduce(max);

    return _maxed;
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
        maxX: data
                    .where((element) =>
                        element.createdAt!.month.toString() ==
                        DateTime.now().month.toString())
                    .length /
                1.00 -
            1,
        minY: 0,
        maxY: maxValue(),
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
        maxX: data
                    .where((element) =>
                        element.createdAt!.month - DateTime.now().month == -1)
                    .length /
                1.00 -
            1,
        minY: 0,
        maxY: 7,
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
        maxX: data
                    .where((element) =>
                        element.createdAt!.month - DateTime.now().month == -1)
                    .length /
                1.00 -
            1,
        minY: 0,
        maxY: 7,
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
      ),
    );
  }
}
