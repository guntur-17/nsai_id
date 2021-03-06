import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nsai_id/models/distributor_model.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';
import 'package:nsai_id/pages/absent/attendance_page.dart';
import 'package:nsai_id/providers/Product_provider.dart';

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

class _DistributorListPageState extends State<DistributorListPage>
    with AutomaticKeepAliveClientMixin {
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

  @override
  bool get wantKeepAlive => true;

  // Future _handlefunction() async {
  //   setState(() {
  //     isLoading = true;
  //     isLoading = false;
  //   });
  //   // _determinePosition();
  //   // distributorHandler();
  //   // attendanceHandler();
  // }

  Future _handlefunction() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    if (!mounted) return;
    await _determinePosition();
  }

  producthandler(distributor_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('token');
    await Provider.of<ProductProvider>(context, listen: false)
        .getProduct(token, distributor_id);
  }

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
      if (mounted) {
        setState(
          () {
            currentposition = position;

            currentAddress =
                " ${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea} ${place.postalCode}";
            // Loader.hide();
            isLoading = false;
          },
        );
      }

      return currentposition;
    } catch (e) {
      print(e);
      isLoading = false;
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

    DistributorProvider distributorProvider =
        Provider.of<DistributorProvider>(context, listen: false);

    // List distributor = distributorProvider.distributors.toList();
    List list2 = distributorProvider.distributors.reversed.toList();

    Widget card() {
      return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          children: list2
              .map(
                (distributor) => DistributorCard(
                  latUser: currentposition!.latitude,
                  longUser: currentposition!.longitude,
                  distributor: distributor,
                  route: AttendancePage(
                    distributor: distributor,
                  ),
                ),
              )
              .toList(),
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
