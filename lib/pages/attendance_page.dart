import 'dart:ffi';

import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:nsai_id/models/attendance_model.dart';

import 'package:nsai_id/models/distributor_model.dart';
import 'package:nsai_id/pages/register_page.dart';
import 'package:nsai_id/pages/test_page.dart';
import 'package:nsai_id/providers/attendance_provider.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/checkbox.dart';
import 'package:nsai_id/widget/currency.dart';
import 'package:nsai_id/widget/loading_widget.dart';
import 'package:nsai_id/widget/takePhoto_widget.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendancePage extends StatefulWidget {
  DistributorModel distributor;

  AttendancePage({required this.distributor, Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  TextEditingController jumlahController = TextEditingController(text: '');
  TextEditingController totalController = TextEditingController(text: '');

  List<Map<String, dynamic>> test = [];

  AttendanceModel? dataAttendance;

  String currentAddress = 'My Address';
  Position? currentposition;

  num totalprice = 0;

  bool isLoading = false;

  bool isChecked = false;

  bool isCheckin = false;

  dynamic currentTime = DateFormat.Hm().format(DateTime.now());

  String? _dropDownValue;

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  String? selectedDistributor;
  String? selectedProduct;
  String? selectedSatuan;

  @override
  void initState() {
    super.initState();

    // _determinePosition();
    _handlefunction();

    // setState(() {});
  }

  Future _handlefunction() async {
    setState(() {
      isLoading = true;
    });
    await _determinePosition();
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
      setState(
        () {
          currentposition = position;

          currentAddress =
              " ${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea} ${place.postalCode}";
          // Loader.hide();
          isLoading = false;
        },
      );

      return currentposition;
    } catch (e) {
      print(e);
      isLoading = false;
    }
  }

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  final List<String> produks = [
    'product 1',
    'product 2',
    'product 3',
    'product 4',
    'product 5',
  ];

  final List<String> satuans = [
    'satuan 1',
    'satuan 2',
    'satuan 3',
    'satuan 4',
    'satuan 5',
  ];

  @override
  Widget build(BuildContext context) {
    // final List<String> roles = _roles;
    AttedanceProvider attedanceProvider =
        Provider.of<AttedanceProvider>(context);

    Future handleadd() async {
      if (test.any((element) => element["produk"] == selectedProduct)) {
        // final text2 = test[test.indexWhere((element) => element["produk"]== selectedProduct)];
        //  // test[]i
        totalprice += int.parse(totalController.text);

        test[test.indexWhere((element) => element["produk"] == selectedProduct)]
            ['jumlah'] = (int.parse(test[test.indexWhere(
                        (element) => element["produk"] == selectedProduct)]
                    ['jumlah']) +
                int.parse(jumlahController.text))
            .toString();
        test[test.indexWhere((element) => element["produk"] == selectedProduct)]
            ['total'] = (int.parse(test[test.indexWhere(
                        (element) => element["produk"] == selectedProduct)]
                    ['total']) +
                int.parse(totalController.text))
            .toString();
        // test.contains(selectedProduct)
        //     ? {

        //       }
        //     : test;
      } else {
        totalprice += int.parse(totalController.text);
        test.add({
          // 'distributor': selectedDistributor,
          'produk': selectedProduct,
          'jumlah': jumlahController.text,
          'total': totalController.text,
        });
      }

      setState(() {
        selectedProduct = null;
        jumlahController.text = '';
        totalController.text = '';
      });
      print(test);
    }

    handleCheckin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      Loader.show(
        context,
        isSafeAreaOverlay: false,
        // isBottomBarOverlay: false,
        // overlayFromBottom: 80,
        overlayColor: Colors.black26,
        progressIndicator: CircularProgressIndicator(
          color: blueBrightColor,
        ),
        themeData: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: whiteColor),
        ),
      );
      if (await attedanceProvider.attendanceIn(
        'Bearer 241|RNO7WPj6frL2OH2KWwrqSQoGWNw0BkU5KZHjS8qa',
        currentTime,
        currentposition!.latitude,
        currentposition!.longitude,
      )) {
        setState(() {
          isCheckin = true;
          dataAttendance = attedanceProvider.data;
        });
        Loader.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: greenColor,
            content: const Text(
              'berhasil clockin',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        Loader.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: redColor,
            content: const Text(
              'gagal clockin',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        // Widget distributor() {
        //   return DropdownButton(
        //     hint: _dropDownValue == null
        //         ? Text('Dropdown')
        //         : Text(
        //             _dropDownValue!,
        //             style: TextStyle(color: Colors.blue),
        //           ),
        //     isExpanded: true,
        //     iconSize: 30.0,
        //     style: TextStyle(color: Colors.blue),
        //     items: ['One', 'Two', 'Three'].map(
        //       (val) {
        //         return DropdownMenuItem<String>(
        //           value: val,
        //           child: Text(val),
        //         );
        //       },
        //     ).toList(),
        //     onChanged: (val) {
        //       setState(
        //         () {
        //           _dropDownValue = val.toString();
        //         },
        //       );
        //     },
        //   );
        // }

        Widget produk() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Produk",
                    style: trueBlackInterTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Pilih Produk',
                            style: trueBlackInterTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              // color: Colors.yellow,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: produks
                        .map((produk) => DropdownMenuItem<String>(
                              value: produk,
                              child: Text(
                                produk,
                                style: trueBlackInterTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedProduct,
                    onChanged: (value) {
                      setState(() {
                        selectedProduct = value as String;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    iconSize: 14,
                    // iconEnabledColor: Colors.yellow,
                    // iconDisabledColor: Colors.grey,
                    buttonHeight: 50,
                    buttonWidth: MediaQuery.of(context).size.width * 0.9,
                    buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      // color: Colors.redAccent,
                    ),
                    // buttonElevation: 2,
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownWidth: MediaQuery.of(context).size.width * 0.9,
                    dropdownPadding: null,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      // color: Colors.redAccent,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: false,
                    offset: const Offset(0, 0),
                  ),
                ),
              ],
            ),
          );
        }

        Widget jumlah() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Jumlah",
                    style: trueBlackInterTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  onChanged: ((value) {
                    String jumlah = jumlahController.text;
                    int? jumlah2 = int.tryParse(jumlah);
                    print(jumlah2);
                    selectedProduct != null || jumlahController.text != ''
                        ? totalController.text = (jumlah2! * 2000).toString()
                        : '';
                  }),
                  // scrollPadding: EdgeInsets.only(
                  //     bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
                  focusNode: myFocusNode,
                  controller: jumlahController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),

                    labelStyle: TextStyle(
                        color: myFocusNode.hasFocus ? primaryBlue : grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: Colors.black26,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: Colors.black26,
                        width: 1.0,
                      ),
                    ),

                    // errorText: 'Error message',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          );
        }

        Widget total() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Total",
                    style: trueBlackInterTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                    color: grey40,
                  ),
                  child: TextFormField(
                    enabled: false,
                    focusNode: myFocusNode2,
                    controller: totalController,

                    // style: TextStyle(color: grey40),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),

                      labelStyle: TextStyle(
                          color: myFocusNode2.hasFocus ? primaryBlue : grey),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: BorderSide(
                          color: Colors.black26,
                        ),
                      ),

                      // errorText: 'Error message',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        Widget input() {
          return RelativeBuilder(builder: (context, height, width, sy, sx) {
            return Padding(
              padding: const EdgeInsets.only(top: 21, bottom: 20),
              child: Container(
                // padding: const EdgeInsets.all(30.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    // distributor(),
                    produk(),
                    jumlah(),
                    // satuan(),
                    total(),
                  ],
                ),
              ),
            );
          });
        }

        Widget button() {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: whiteColor,
                      side: BorderSide(
                        width: 1.0,
                        color: blueBrightColor,
                      )),
                  onPressed: () {
                    handleadd();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                    width: MediaQuery.of(context).size.width * 0.3,
                    // height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: primaryBlue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add',
                          style: whiteInterTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                              color: blueBrightColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        Widget disable() {
          return Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryBlue),
              onPressed: null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                width: MediaQuery.of(context).size.width * 0.3,
                // height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: primaryBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: grey40,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'add',
                      style: whiteInterTextStyle.copyWith(
                          fontSize: 16, fontWeight: medium, color: grey40),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        Widget result2() {
          return Column(
            children: [
              // test
              for (var produk
                  in test..sort(((a, b) => a['produk'].compareTo(b["produk"]))))
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  // color: redColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            produk['produk'],
                            style: trueBlackInterTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "x" + produk['jumlah'],
                            style: trueBlackInterTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                            ),
                            // textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Text(
                        // 'Rp.' + produk['total'].toString(),
                        CurrencyFormat.convertToIdr(
                            int.parse(produk['total']), 2),
                        style: trueBlackInterTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        }

        Widget submit() {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.86,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: whiteColor,
                    side: BorderSide(
                      width: 1.0,
                      color: blueBrightColor,
                    )),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => StockListPage()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                  // width: MediaQuery.of(context).size.width,
                  // height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: primaryBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload,
                        color: blueBrightColor,
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Text(
                        'Submit',
                        style: whiteInterTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                            color: blueBrightColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        Widget download() {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.86,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: whiteColor,
                    side: BorderSide(
                      width: 1.0,
                      color: blueBrightColor,
                    )),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => StockListPage()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                  // height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: primaryBlue,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_download_outlined,
                        color: blueBrightColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Download Transaksi Saya',
                        style: whiteInterTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                            color: blueBrightColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        Widget ssj() {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sudah Siap Jualan?",
                      style: trueBlackInterTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryBlue),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) => StockListPage()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,

                          // height: 36,
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: primaryBlue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ya',
                                style: whiteInterTextStyle.copyWith(
                                    fontSize: 16, fontWeight: medium),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: whiteColor,
                            side: BorderSide(
                              width: 1.0,
                              color: blueBrightColor,
                            )),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) => StockListPage()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                          width: MediaQuery.of(context).size.width * 0.3,
                          // height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: primaryBlue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tidak',
                                style: whiteInterTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: medium,
                                    color: blueBrightColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        Widget body() {
          return Expanded(
            // flex: 10,
            child: AbsorbPointer(
              absorbing: !isCheckin,
              child: Container(
                // height: MediaQuery.of(context).size.height,
                // width: double.infinity,
                foregroundDecoration: BoxDecoration(
                  color: isCheckin == true ? Colors.transparent : grey,
                  backgroundBlendMode: BlendMode.darken,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // logo(),
                    input(),
                    selectedProduct != null && jumlahController.text != ''
                        ? button()
                        : disable(),

                    // SizedBox(height: 10),
                    // result2(),
                    // submit(),
                    // download(),
                    // ssj(),
                    // check(),
                  ],
                ),
              ),
            ),
          );
        }

        Widget attendance() {
          return Padding(
            padding: const EdgeInsets.only(
                bottom: 22.5, top: 22.5, left: 10, right: 10),
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.distributor.name,
                    style: trueBlackRobotTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 24,
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dataAttendance != null
                          ? Text(dataAttendance!.time.toString(),
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: medium))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: primaryBlue),
                              onPressed: () async {
                                await handleCheckin();
                                // Navigator.of(context).push
                                // (MaterialPageRoute(
                                //     builder: (BuildContext context) => StockListPage()));
                              },
                              child: Container(
                                // width: 137,
                                // height: 36,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: primaryBlue,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Check In',
                                      style: whiteInterTextStyle.copyWith(
                                          fontSize: 16, fontWeight: medium),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        Widget header() {
          return Container(
            // color: orangeYellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  // mainAxisAlignment: ,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: whiteColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Absensi & Pengambilan Barang',
                      softWrap: true,
                      style: whiteRobotoTextStyle.copyWith(
                        fontWeight: extraBold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // color: whiteColor,
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.9,
                  // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: attendance(),
                ),
              ],
            ),
          );
        }

        Widget showModalcontent() {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // attedanceProvider.data.? Text(attedanceProvider.):
                          Text(
                            "Produk",
                            style: trueBlackInterTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          test.isEmpty ? Container() : result2(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Harga Keseluruhan",
                                style: trueBlackInterTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: medium,
                                ),
                              ),
                              Text(
                                // "Rp." + totalprice.toString(),
                                CurrencyFormat.convertToIdr(totalprice, 2),
                                style: trueBlackInterTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: medium,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TakePhoto(
                            text: "Ambil Gambar Distributor",
                          ),
                          TakePhoto(
                            text: "Ambil Gambar Produk",
                          ),

                          submit(),
                          // download(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        Widget showModal() {
          return Visibility(
            visible: test.isNotEmpty,
            child: Builder(
              builder: (context) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryBlue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            showModalcontent(),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          test.length.toString() + " Produk telah ditambahkan",
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            // backgroundColor: orangeYellow,
            bottomNavigationBar: showModal(),
            body: isLoading
                ? Loading()
                : CustomScrollView(slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: GestureDetector(
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/bgatt.png'),
                                  fit: BoxFit.cover)),
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 20,
                              ),
                              header(),
                              const SizedBox(
                                height: 20,
                              ),
                              body(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
          ),
        );
      },
    );
  }
}
