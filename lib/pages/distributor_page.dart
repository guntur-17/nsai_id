import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nsai_id/models/distributor_model.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';
import 'package:nsai_id/pages/attendance_page.dart';

import 'package:nsai_id/providers/distributor_provider.dart';
import 'package:nsai_id/providers/outlet_provider.dart';
import 'package:nsai_id/services/outlet_service.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/distributor_card.dart';
import 'package:nsai_id/widget/loading_widget.dart';
import 'package:nsai_id/widget/shop_card.dart';
import 'package:provider/provider.dart';

import 'package:relative_scale/relative_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DistributorListPage extends StatefulWidget {
  // final String? addressUser;

  const DistributorListPage({Key? key}) : super(key: key);

  @override
  _DistributorListPageState createState() => _DistributorListPageState();
}

class _DistributorListPageState extends State<DistributorListPage> {
  // List<OutletModel> shops = [];
  // List<Map<String, dynamic>> distributor = [];
  // List<Map<String, dynamic>> _distributor = [];

  String query = '';
  Timer? debouncer;

  String currentAddress = 'My Address';
  Position? currentposition;

  bool isLoading = false;

  // bool isLoading = false;
  @override
  void initState() {
    // shopListHandler();
    super.initState();
    _handlefunction();

    // init();
  }

  Future _handlefunction() async {
    setState(() {
      isLoading = true;
      isLoading = false;
    });
    // _determinePosition();
    // distributorHandler();
    // attendanceHandler();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    // ShopProvider shopProvider = Provider.of<ShopProvider>(context);
    // List list = shopProvider.shopdistance.toList();

    DistributorProvider distributorProvider =
        Provider.of<DistributorProvider>(context, listen: false);

    // List distributor = distributorProvider.distributors.toList();
    List list2 = distributorProvider.distributors.reversed.toList();
    // print(list2);
    Widget card() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          children: list2
              .map((distributor) => DistributorCard(
                  distributor,
                  AttendancePage(
                    distributor: distributor,
                  )))
              .toList(),
        ),
        // child: ListView.builder(
        //   itemCount: distributor.length,
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     final distributor = _distributor[index];
        //     // ignore: avoid_print
        //     print(distributor);
        //     // setState(() {});
        //     return ShopCard(
        //         distributor,
        //         AttendancePage(
        //           distributor: distributor as DistributorModel,
        //         ));
        //   },
        // ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            toolbarHeight: 120,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: trueBlack,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            title: Text(
              'Distributor',
              style: trueBlackTextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
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

  // Widget buildSearch() => SearchWidget(
  //       text: query,
  //       hintText: 'Shop name',
  //       onChanged: searchShop,
  //     );

  // Future searchShop(String query) async => debounce(() async {
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       var token = prefs.getString('token');
  //       final outlet = await OutletService().getShops(token: token);

  //       if (!mounted) return;

  //       setState(() {
  //         this.query = query;
  //         this.shops = shops;
  //       });
  //     });

  // Widget cardShop({ShopModel? shop}) => RelativeBuilder(
  //       builder: (context, height, width, sy, sx) {
  //         return InkWell(
  //           onTap: () {
  //             // Navigator.push(
  //             //   context,
  //             //   MaterialPageRoute(
  //             //     builder: (context) =>
  //             //         CameraPages(shop!.id, shop.name, widget.addressUser),
  //             //   ),
  //             // );
  //           },
  //           child: Container(
  //             margin: const EdgeInsets.only(bottom: 15),
  //             width: MediaQuery.of(context).size.width - 60,
  //             height: sy(40),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 // Image.asset(
  //                 //   'assets/toko.png',
  //                 //   width: sy(40),
  //                 //   height: sy(40),
  //                 // ),
  //                 const SizedBox(
  //                   width: 16,
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Row(
  //                       children: [
  //                         SizedBox(
  //                           width: MediaQuery.of(context).size.width * 0.6,
  //                           child: Text(
  //                             shop!.name,
  //                             overflow: TextOverflow.ellipsis,
  //                             textAlign: TextAlign.left,
  //                             style: trueBlackTextStyle.copyWith(
  //                                 fontSize: 18, fontWeight: FontWeight.w500),
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 ),
  //                 // Image.asset(
  //                 //   'assets/rightButton.png',
  //                 //   width: sx(20),
  //                 //   height: sx(20),
  //                 // ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
}
