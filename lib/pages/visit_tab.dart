import 'package:flutter/material.dart';
import 'package:nsai_id/pages/visit_list_page.dart';

import '../models/outlet_model.dart';
import 'list_test_page2.dart';

class VisitTab extends StatefulWidget {
  List<OutletModel> outlet;
  VisitTab(this.outlet, {Key? key}) : super(key: key);

  @override
  State<VisitTab> createState() => _VisitTabState();
}

class _VisitTabState extends State<VisitTab> {
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
            body: TabBarView(
              children: <Widget>[
                VisitListPage(widget.outlet),
                Container(
                  child: Text('1'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
