import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:nsai_id/pages/visit/v_history_no_item.dart';
import 'package:nsai_id/pages/visit/v_history_page.dart';
import 'package:nsai_id/providers/visiting_provider.dart';
import 'package:nsai_id/widget/visiting_history_card.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';
import '../../widget/loading_widget.dart';
import '../absent/history_no_item_page.dart';
import '../absent/history_page.dart';

class VisitingHistoryList extends StatefulWidget {
  const VisitingHistoryList({Key? key}) : super(key: key);

  @override
  State<VisitingHistoryList> createState() => _VisitingHistoryListState();
}

class _VisitingHistoryListState extends State<VisitingHistoryList>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _handlefunction();
  }

  @override
  bool get wantKeepAlive => true;

  Future _handlefunction() async {
    setState(() {
      isLoading = true;
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    VisitingProvider visitingProvider =
        Provider.of<VisitingProvider>(context, listen: false);
    // List distributor = distributorProvider.distributors.toList();

    List list = visitingProvider.visitingsHistory
        .where(
          (element) => element.createdAt!.day == DateTime.now().day,
        )
        .toList();
    print(list);
    Widget card() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: list.length,
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final visit = list[index];
            return LazyLoadingList(
              initialSizeOfItems: 5,
              index: index,
              hasMore: true,
              loadMore: () => print('Loading More'),
              child: VisitingCard(
                historyVisit: visit,
                route: HistoryVisiting(
                  visitingHistory: visit,
                ),
                route2: VisitingNoItem(visiting: visit),
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
                      card(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
