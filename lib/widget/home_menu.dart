import 'package:flutter/material.dart';
import 'package:nsai_id/providers/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';

class HomeMenu extends StatelessWidget {
  final String? title;
  final String? imgpath;
  final route;
  final ontap;
  final function;
  const HomeMenu(
      {Key? key,
      this.function,
      this.title,
      this.imgpath,
      this.route,
      this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // attendanceHistoryHandler() async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();

    //   var token = prefs.getString('token');
    //   var id = prefs.getString('id');
    //   await Provider.of<AttendanceProvider>(context, listen: false)
    //       .getAttendancesHistory(token, id);
    //   // if () setState(() {});
    // }

    return InkWell(
      onTap: () async {
        function;
        final page = route;
        // await attendanceHistoryHandler();
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => page)));

        ontap;
      },
      child: Container(
        height: 80,
        width: 80,
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
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Image.asset('$imgpath', width: 36, height: 36),
              Text('$title',
                  style: trueBlackRobotoTextStyle.copyWith(fontSize: 12))
            ],
          ),
        ),
      ),
    );
  }
}
