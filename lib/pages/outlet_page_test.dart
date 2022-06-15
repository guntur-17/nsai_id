import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';
import 'package:nsai_id/pages/visit_page.dart';
import 'package:nsai_id/providers/outlet_provider.dart';
import 'package:nsai_id/services/outlet_service.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/loading_widget.dart';
import 'package:nsai_id/widget/shop_card.dart';
import 'package:provider/provider.dart';

import 'package:relative_scale/relative_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OutletListPage4 extends StatefulWidget {
  // final String? addressUser;
  // late List<OutletModel> outlet;

  const OutletListPage4({Key? key}) : super(key: key);

  @override
  _OutletListPageState createState() => _OutletListPageState();
}

class _OutletListPageState extends State<OutletListPage4> {
  List<OutletModel> shops = [];
  List<Map<String, dynamic>> outletDistance = [];
  List<Map<String, dynamic>> _outletDistance = [];
  List<OutletModel> outlet = [];

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
    });
    _determinePosition();
  }

  // Future init() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');
  //   final shops = await ShopService().getShops(token: token);

  //   if (!mounted) return;
  //   setState(() => this.shops = shops);
  // }

  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please Keep your location on.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location Permission is denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Permission is denied Forever');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(
        () {
          currentposition = position;
          currentAddress =
              " ${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea} ${place.postalCode}";
          // Loader.hide();
          // shopListHandler();
        },
      );

      return currentposition;
    } catch (e) {
      print(e);
      isLoading = false;
      return null;
    }
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
    // print(list);
    Widget card() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: ListView.builder(
          itemCount: outletDistance.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final outlets = _outletDistance[index];
            // ignore: avoid_print
            print(outlets);
            // setState(() {});
            return ShopCard(
              outlets,
              VisitPage(),
            );
          },
        ),
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
                Icons.arrow_back,
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
              'Outlet',
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
