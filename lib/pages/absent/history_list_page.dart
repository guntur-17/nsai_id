import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:nsai_id/pages/absent/history_page.dart';
import 'package:nsai_id/pages/absent/history_no_item_page.dart';
import 'package:nsai_id/providers/attendance_provider.dart';
import 'package:nsai_id/providers/distributor_provider.dart';
import 'package:nsai_id/widget/attendance_history_card.dart';
import 'package:nsai_id/widget/distributor_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme.dart';
import '../../widget/loading_widget.dart';

class AbsentHistoryList extends StatefulWidget {
  const AbsentHistoryList({Key? key}) : super(key: key);

  @override
  State<AbsentHistoryList> createState() => _AbsentHistoryListState();
}

class _AbsentHistoryListState extends State<AbsentHistoryList>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // _handlefunction();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    DistributorProvider distributorProvider =
        Provider.of<DistributorProvider>(context, listen: false);

    AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    // List distributor = distributorProvider.distributors.toList();

    List list = attendanceProvider.attendancesHistory.toList();
    DateTime date = DateTime.now();
    DateTime? historyDate;
    var formattedDate = "${date.day}-${date.month}-${date.year}";
    print(date);
    List listToday = attendanceProvider.attendancesHistory.reversed
        .where((element) =>
            "${element.createdAt!.day}-${element.createdAt!.month}-${element.createdAt!.year}" ==
            formattedDate)
        .toList();

    List listNotCheckOutYet = attendanceProvider.attendancesHistory.reversed
        .where((element) =>
            "${element.createdAt!.day}-${element.createdAt!.month}-${element.createdAt!.year}" !=
                formattedDate &&
            element.clock_out == "00:00:00")
        .toList();

    print(list);
    Widget card() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: ListView.builder(
          itemCount: listToday.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final absent = listToday[index];
            return LazyLoadingList(
              initialSizeOfItems: 5,
              index: index,
              hasMore: true,
              loadMore: () => print('Loading More'),
              child: AttendanceHistoryCard(
                historyDistributor: absent,
                route: HistoryPage(
                  attendanceHistory: absent,
                ),
                route2: HistoryWithoutItemPage(distributor: absent),
              ),
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
      );
    }

    Widget card2() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: ListView.builder(
          itemCount: listNotCheckOutYet.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final absent = listNotCheckOutYet[index];
            return LazyLoadingList(
              initialSizeOfItems: 5,
              index: index,
              hasMore: true,
              loadMore: () => print('Loading More'),
              child: AttendanceHistoryCard(
                historyDistributor: absent,
                route: HistoryPage(
                  attendanceHistory: absent,
                ),
                route2: HistoryWithoutItemPage(distributor: absent),
              ),
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
      );
    }

    // Widget card2() {
    //   return Container(
    //     width: MediaQuery.of(context).size.width * 0.90,
    //     child: Column(
    //       children: list.map((distributor) => Text("test")).toList(),
    //     ),
    //   );
    // }

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
                      Container(
                        padding: EdgeInsets.only(right: 20, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Today",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      card(),
                      Container(
                        padding: EdgeInsets.only(right: 20, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Belum Check Out",
                              style: blackTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      card2(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
