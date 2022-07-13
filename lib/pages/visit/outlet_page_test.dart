import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:nsai_id/models/attendance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';
import 'package:nsai_id/models/product_model.dart';
import 'package:nsai_id/models/visiting_model.dart';
import 'package:nsai_id/pages/auth/register_page.dart';
import 'package:nsai_id/pages/test2_page.dart';
import 'package:nsai_id/pages/test_page.dart';
import 'package:nsai_id/providers/Product_provider.dart';
import 'package:nsai_id/providers/attendance_provider.dart';
import 'package:nsai_id/providers/visiting_provider.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/checkbox.dart';
import 'package:nsai_id/widget/currency.dart';
import 'package:nsai_id/widget/takePhoto_widget.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/history_attendance_model.dart';
import '../../models/item_taken_model.dart';
import '../../widget/loading_widget.dart';
import '../../widget/retakePhoto_widget.dart';
import '../home_page.dart';

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min <= max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    } else {
      var value = int.parse(newValue.text);
      if (value < min) {
        return TextEditingValue(text: min.toString());
      } else if (value > max) {
        return TextEditingValue(text: max.toString());
      }
    }
    return newValue;
  }
}

class OutletPage2 extends StatefulWidget {
  final longUser;
  final latUser;
  final String? address;
  final OutletModel? outlet;
  OutletPage2(
      {this.latUser, this.longUser, this.outlet, this.address, Key? key})
      : super(key: key);

  @override
  State<OutletPage2> createState() => _VisitPageState();
}

class _VisitPageState extends State<OutletPage2> {
  TextEditingController jumlahController = TextEditingController(text: '');
  TextEditingController totalController = TextEditingController(text: '');
  List<Map<String, dynamic>> test = [];
  List<ItemTakenModel> _itemTaken = [];
  List<ProductModel> _productTaken = [];
  List<Map<String, dynamic>> listItemTaken = [];
  VisitingModel? dataAttendance;
  num totalprice = 0;

  bool isLoading = false;

  bool isChecked = false;

  bool isCheckin = false;

  // bool condition = false;

  dynamic currentTime = DateFormat.Hm().format(DateTime.now());

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  String? selectedcategory;
  String? selectedNamacategory;
  ProductModel? selectedProduct;
  String? selectedSatuan;
  String? _dropDownValue;

  File? imageDistributor;
  File? imageProduct;
  File? imageOther;

  String currentAddress = 'My Address';
  Position? currentposition;

  @override
  void initState() {
    _handlefunction();
    super.initState();

    // _determinePosition();

    // setState(() {});
  }

  Future getPhotoDistributor(StateSetter updateState) async {
    final ImagePicker _picker = ImagePicker();

    // Capture a photo
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    //mengubah Xfile jadi file

    updateState(() {
      if (photo != null) {
        imageDistributor = File(photo.path);
      }
    });
  }

  Future getPhotoProduct(StateSetter updateState) async {
    final ImagePicker _picker2 = ImagePicker();

    // Capture a photo
    final XFile? photo2 =
        await _picker2.pickImage(source: ImageSource.camera, imageQuality: 50);
    //mengubah Xfile jadi file

    updateState(() {
      if (photo2 != null) {
        imageProduct = File(photo2.path);
      }
    });
  }

  Future getPhotoOther(StateSetter updateState) async {
    final ImagePicker _picker = ImagePicker();

    // Capture a photo
    final XFile? photo3 =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    //mengubah Xfile jadi file

    updateState(() {
      if (photo3 != null) {
        imageOther = File(photo3.path);
      }
    });
  }

  handlerItemTaken() async {
    AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    List<AttendanceHistoryModel> list = attendanceProvider.itemTaken.toList();

    for (var _item in list) {
      _itemTaken.addAll(_item.item!);
    }

    for (var _product in _itemTaken) {
      _productTaken.add(_product.product!);
    }

    print(_itemTaken.toList());
    print(_productTaken.toList());
  }

  Future _handlefunction() async {
    await handlerItemTaken();
    if (!mounted) return;
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
  // void iniState() {
  //   setState(() {});

  // }

  final List<String> categories = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  final List<String> nama_categories = [
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
    VisitingProvider visitingProvider = Provider.of<VisitingProvider>(context);
    late ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    late List<ProductModel> products = productProvider.products.toList();

    // List<AttendanceModel> absent = attedanceProvider.attendances;

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
          'absentId': _itemTaken
              .firstWhere(
                  (element) => element.product!.id == selectedProduct!.id)
              .absent_id,
          'produkId': selectedProduct!.id,
          'produkPrice': selectedProduct!.price,
          'produkUnit': selectedProduct!.unit,
          'produk': selectedProduct!.name,
          'jumlah': jumlahController.text,
          'total': totalController.text,
        });
      }

      setState(() {
        selectedProduct = null;
        jumlahController.text = '';
        totalController.text = '';
      });
      // print(test);
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
      if (await visitingProvider.visitingIn(
          token: token,
          outlet_id: widget.outlet!.id,
          clock_in: currentTime,
          address: widget.outlet!.address)) {
        setState(() {
          isCheckin = true;
          dataAttendance = visitingProvider.data;
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

    handlePhoto(
      String id,
      File image,
      File image2,
      File image3,
    ) async {
      for (var item in test) {
        listItemTaken.add({
          'absent_id': item['absentId'],
          'product_id': item['produkId'],
          'item_sold': item['jumlah'],
          'total_sales': item['total']
        });
        print(listItemTaken);
      }
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
      if (await visitingProvider.visitingPhoto(
          id, token, image, image2, image3, listItemTaken)) {
        Loader.hide();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: greenColor,
            content: const Text(
              'Berhasil Visiting',
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
              'Gagal, foto tidak lengkap',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        Widget produk2() {
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
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    hintText: 'Pilih Produk',
                    hintStyle: TextStyle(fontSize: 16.0, color: trueBlack),
                  ),
                  // Initial Value
                  value: selectedProduct,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: _productTaken.map((ProductModel product) {
                    return DropdownMenuItem(
                      value: product,
                      child: Text(product.name!),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value

                  onChanged: (ProductModel? newValue) {
                    setState(() {
                      selectedProduct = newValue!;
                      // sendedDropDownValue = newValue.id!;
                    });
                  },
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LimitRangeTextInputFormatter(
                        0,
                        _itemTaken
                                .firstWhere((element) =>
                                    element.product!.id == selectedProduct!.id)
                                .item_taken! -
                            _itemTaken
                                .firstWhere((element) =>
                                    element.product!.id == selectedProduct!.id)
                                .total_item_sold!)
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: ((value) {
                    String jumlah = jumlahController.text;
                    int? jumlah2 = int.tryParse(jumlah);
                    int? harga = selectedProduct?.price;

                    if (jumlah2 != null && selectedProduct != null) {
                      selectedProduct != null || jumlahController.text != ''
                          ? totalController.text = (jumlah2 * harga!).toString()
                          : '';
                    } else {
                      setState(() {
                        totalController.text = "";
                      });
                    }
                  }),
                  // scrollPadding: EdgeInsets.only(
                  //     bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
                  focusNode: myFocusNode,
                  controller: jumlahController,
                  decoration: InputDecoration(
                    suffixText: 'max:' +
                        (_itemTaken
                                    .firstWhere((element) =>
                                        element.product!.id ==
                                        selectedProduct!.id)
                                    .item_taken! -
                                _itemTaken
                                    .firstWhere((element) =>
                                        element.product!.id ==
                                        selectedProduct!.id)
                                    .total_item_sold!)
                            .toString(),
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

        Widget jumlahDisabled() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: AbsorbPointer(
              absorbing: selectedProduct == null,
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
                  Container(
                    foregroundDecoration: BoxDecoration(
                      color:
                          selectedProduct != null ? Colors.transparent : grey,
                      backgroundBlendMode: BlendMode.darken,
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      onChanged: ((value) {}),
                      // scrollPadding: EdgeInsets.only(
                      //     bottom: MediaQuery.of(context).viewInsets.bottom + 16 * 4),
                      focusNode: myFocusNode,
                      controller: jumlahController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 10.0),

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
                  ),
                ],
              ),
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

        Widget input() {
          return RelativeBuilder(builder: (context, height, width, sy, sx) {
            return Padding(
              padding: const EdgeInsets.only(top: 21, bottom: 20),
              child: Container(
                // padding: const EdgeInsets.all(30.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    // kategoriOutlet(),
                    produk2(),
                    selectedProduct != null ? jumlah() : jumlahDisabled(),
                    // satuan(),
                    total(),
                  ],
                ),
              ),
            );
          });
        }

        Widget buttonadd() {
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
                  onPressed: () async {
                    await handleadd();

                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => StockListPage()));
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
                        Icon(
                          Icons.add,
                          color: blueBrightColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'add',
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
                        Icons.file_download_outlined,
                        color: blueBrightColor,
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
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
                onPressed: () async {
                  String? id = dataAttendance?.id;
                  await handlePhoto(
                      id!, imageProduct!, imageDistributor!, imageOther!);

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

        Widget attendance() {
          return Padding(
            padding: const EdgeInsets.only(
                bottom: 22.5, top: 22.5, left: 10, right: 10),
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.outlet!.name,
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
                          ? Text(dataAttendance!.clock_in.toString(),
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: medium))
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: primaryBlue),
                              onPressed: () {
                                handleCheckin();

                                // Navigator.of(context).push(MaterialPageRoute(
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

        Widget body() {
          return Expanded(
            child: AbsorbPointer(
              absorbing: !isCheckin,
              child: IntrinsicHeight(
                child: Container(
                  // height: double.infinity,
                  foregroundDecoration: BoxDecoration(
                    color: isCheckin == true ? Colors.transparent : grey,
                    backgroundBlendMode: BlendMode.darken,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  // height: MediaQuery.of(context).size.height,
                  // width: double.infinity,
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
                      selectedProduct != null &&
                              jumlahController.text.isNotEmpty
                          ? buttonadd()
                          : disable(),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // test.isEmpty ? Container() : result2(),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // takePhoto(),
                      // submit(),

                      // download(),

                      // check(),
                    ],
                  ),
                ),
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
                      'Visiting & Penjualan Barang',
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

        Widget showModalcontent(StateSetter updateState) {
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
                          if (imageDistributor != null)
                            RetakePhoto(
                              function: () async {
                                getPhotoDistributor(updateState);

                                updateState(() {});
                              },
                              image: imageDistributor!,
                            )
                          else
                            TakePhoto(
                              text: "Ambil Gambar Distributor",
                              function: () async {
                                getPhotoDistributor(updateState);

                                updateState(() {});
                              },
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          if (imageProduct != null)
                            RetakePhoto(
                              function: () async {
                                getPhotoProduct(updateState);

                                updateState(() {});
                              },
                              image: imageProduct!,
                            )
                          else
                            TakePhoto(
                              text: "Ambil Gambar Produk",
                              function: () async {
                                getPhotoProduct(updateState);
                                updateState(() {});
                              },
                              // function: getPhoto(),
                            ),
                          if (imageOther != null)
                            RetakePhoto(
                              function: () async {
                                getPhotoOther(updateState);

                                updateState(() {});
                              },
                              image: imageProduct!,
                            )
                          else
                            TakePhoto(
                              text: "Ambil Gambar Lainnya",
                              function: () async {
                                getPhotoOther(updateState);
                                updateState(() {});
                              },
                              // function: getPhoto(),
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
                        return StatefulBuilder(builder: (context, state) {
                          return Wrap(
                            children: [
                              showModalcontent(state),
                            ],
                          );
                        });
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
                                  image: AssetImage('assets/bgvisit.png'),
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
