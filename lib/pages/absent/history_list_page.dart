import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:nsai_id/pages/absent/history_page.dart';
import 'package:nsai_id/providers/attendance_provider.dart';
import 'package:nsai_id/providers/distributor_provider.dart';
import 'package:nsai_id/widget/attendance_history_card.dart';
import 'package:nsai_id/widget/distributor_card.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';
import '../../widget/loading_widget.dart';

class AbsentHistoryList extends StatefulWidget {
  const AbsentHistoryList({Key? key}) : super(key: key);

  @override
  State<AbsentHistoryList> createState() => _AbsentHistoryListState();
}

class _AbsentHistoryListState extends State<AbsentHistoryList> {
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
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    DistributorProvider distributorProvider =
        Provider.of<DistributorProvider>(context, listen: false);

    AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    // List distributor = distributorProvider.distributors.toList();

    List list = attendanceProvider.attendancesHistory.toList();
    print(list);
    Widget card() {
      return Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: list.length,
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final absent = list[index];
              return LazyLoadingList(
                initialSizeOfItems: 5,
                index: index,
                hasMore: true,
                loadMore: () => print('Loading More'),
                child: Text("test"),
              );

              // ignore: avoid_print
              // print(outlets);
              // // setState(() {});
              // return ShopCard(
              //   outlets,
              //   VisitPage(),
              // );
            },
          ),
        ),
      );
    }

    Widget card2() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          children: list.map((distributor) => Text("test")).toList(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: isLoading
            ? Loading()
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      // buildSearch(),
                      // isLoading ? const LoadingDefault() :
                      card2(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
