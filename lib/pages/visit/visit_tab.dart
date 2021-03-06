import 'package:flutter/material.dart';
import 'package:nsai_id/pages/visit/blank_v_page.dart';
import 'package:nsai_id/pages/visit/v_history_list_page.dart';
import 'package:nsai_id/pages/visit/visit_list_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/history_attendance_model.dart';
import '../../models/item_taken_model.dart';
import '../../models/outlet_model.dart';
import '../../providers/attendance_provider.dart';
import '../../providers/visiting_provider.dart';
import '../../widget/loading_widget.dart';
import '../list_test_page2.dart';

class VisitTab extends StatefulWidget {
  List<OutletModel> outlet;
  VisitTab(this.outlet, {Key? key}) : super(key: key);

  @override
  State<VisitTab> createState() => _VisitTabState();
}

class _VisitTabState extends State<VisitTab> {
  bool isLoading = false;
  List<ItemTakenModel> _itemTaken = [];

  @override
  void initState() {
    _handlefunction();
    super.initState();
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
        .getItemTaken(token, id);
    await Provider.of<VisitingProvider>(context, listen: false)
        .getVisitingHistory(token, id);
    AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    List<AttendanceHistoryModel> list = attendanceProvider.itemTaken.toList();
    for (var _item in list) {
      _itemTaken.addAll(_item.item!);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                image: AssetImage('assets/bgvisits.png'),
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
                    'Visit',
                  ),
                  forceElevated: innerBoxIsScrolled,
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Color(0xffFF6C60),
                    indicatorColor: Color(0xffFF6C60),
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
                      (_itemTaken.isEmpty)
                          ? BlankVPage()
                          : VisitListPage(widget.outlet),
                      VisitingHistoryList(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
