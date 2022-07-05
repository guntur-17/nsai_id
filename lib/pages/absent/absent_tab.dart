import 'package:flutter/material.dart';
import 'package:nsai_id/pages/absent/blank_page.dart';
import 'package:nsai_id/pages/absent/distributor_list_page.dart';
import 'package:nsai_id/pages/absent/history_list_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/history_attendance_model.dart';
import '../../providers/attendance_provider.dart';
import '../../widget/loading_widget.dart';

class AbsentTab extends StatefulWidget {
  const AbsentTab({Key? key}) : super(key: key);

  @override
  State<AbsentTab> createState() => _AbsentTabState();
}

class _AbsentTabState extends State<AbsentTab> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _handlefunction();
  }

  Future _handlefunction() async {
    setState(() {
      isLoading = true;
    });
    await handler();
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  handler() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    var id = prefs.getString('id');
    await Provider.of<AttendanceProvider>(context, listen: false)
        .getAttendancesHistory(token, id);
  }

  @override
  Widget build(BuildContext context) {
    AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    List<AttendanceHistoryModel> list =
        attendanceProvider.attendancesHistory.toList();
    // List<AttendanceHistoryModel> _listYesterday = [];
    // -- fungsi untuk menghitung perbedaan hari --
    int calculateDifference(DateTime date) {
      DateTime now = DateTime.now();
      return DateTime(date.year, date.month, date.day)
          .difference(DateTime(now.year, now.month, now.day))
          .inDays;
    }

    // _listYesterday = list
    //     .where((element) => calculateDifference(element.createdAt!) <= -1)
    //     .toList();
    // // -- Cek kondisi jika ada history yang kemarin dan kemarinnya belum clock out --
    // if (_listYesterday.any((item) => item.clock_out == '00:00:00')) {
    //   print('berhasil');
    //   print(_listYesterday);
    // }
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  flexibleSpace: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/bgatthead.png'),
                                fit: BoxFit.fitWidth)),
                      ),
                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  toolbarHeight: 80,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  iconTheme: const IconThemeData(color: Colors.black),
                  centerTitle: false,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  title: Text(
                    'Absensi',
                  ),
                  forceElevated: innerBoxIsScrolled,
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0xff9ECA55),
                    indicatorColor: Color(0xff9ECA55),
                    tabs: [
                      Tab(
                        text: 'Distributor',
                      ),
                      Tab(
                        text: 'Riwayat',
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
              ];
            },
            body: isLoading
                ? Loading()
                : TabBarView(
                    children: <Widget>[
                      (list.any((item) =>
                              item.clock_out == '00:00:00' &&
                              calculateDifference(item.createdAt!) <= -1))
                          ? AbsentBlank()
                          : DistributorListPage(),
                      AbsentHistoryList()
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
