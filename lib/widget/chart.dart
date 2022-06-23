import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class ChartBar extends StatefulWidget {
  const ChartBar({Key? key}) : super(key: key);

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
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
