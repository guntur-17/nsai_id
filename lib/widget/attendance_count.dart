import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/history_attendance_model.dart';
import '../models/item_taken_model.dart';
import '../providers/attendance_provider.dart';
import '../theme.dart';

class AttCount extends StatefulWidget {
  const AttCount({Key? key}) : super(key: key);

  @override
  State<AttCount> createState() => _AttCountState();
}

class _AttCountState extends State<AttCount> {
  bool isLoading = false;
  final List<ItemTakenModel> _itemTaken = [];
  var _widgetsCurrent = [];

  @override
  void initState() {
    handler();
    super.initState();
  }

  handler() async {
    await _handlefunction();
    if (!mounted) return;
  }

  getCurrentMonthData() {
    AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);

    List<AttendanceHistoryModel> list =
        attendanceProvider.attendancesHistory.toList();
    var widgets = [];
    List<AttendanceHistoryModel> currentMonth = [];
    var sumMap = {};

    DateTime current = DateTime.now();
    String month = current.month.toString();
    currentMonth = list
        .where((element) => element.createdAt!.month.toString() == month)
        .toList();

    for (var element in currentMonth) {
      String key = element.createdAt!.day.toString();
      if (sumMap.containsKey(key)) {
        sumMap[key] += 1;
      } else {
        sumMap[key] = 1;
      }
    }
    print(sumMap);

    for (var item in sumMap.values) {
      widgets.add((1));
    }
    _widgetsCurrent = widgets;
    print(_widgetsCurrent.length);
    // print(_widgetsCurrent);
    return _widgetsCurrent;
  }

  Future _handlefunction() async {
    await getCurrentMonthData();
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Color(0xff101828).withOpacity(0.1),
            spreadRadius: -4,
            blurRadius: 16,
            offset: Offset(0, 12), // changes position of shadow
          ),
        ],
      ),
      height: 70,
      width: MediaQuery.of(context).size.width * 0.45,
      child: Container(
        margin: EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hadir',
                  style: trueBlackRobotoTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  _widgetsCurrent.length.toString(),
                  style: blueRobotoTextStyle.copyWith(fontSize: 12),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
