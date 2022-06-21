import 'package:flutter/material.dart';
import 'package:nsai_id/pages/distributor_page.dart';

class AbsentTab extends StatefulWidget {
  const AbsentTab({Key? key}) : super(key: key);

  @override
  State<AbsentTab> createState() => _AbsentTabState();
}

class _AbsentTabState extends State<AbsentTab> {
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
            body: TabBarView(
              children: <Widget>[
                DistributorListPage(),
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
