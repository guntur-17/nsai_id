import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nsai_id/pages/register_page.dart';
import 'package:nsai_id/pages/test_page.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/checkbox.dart';
import 'package:relative_scale/relative_scale.dart';

class VisitPage extends StatefulWidget {
  VisitPage({Key? key}) : super(key: key);

  @override
  State<VisitPage> createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {
  TextEditingController jumlahController = TextEditingController(text: '');
  TextEditingController totalController = TextEditingController(text: '123556');

  bool isLoading = false;

  bool isChecked = false;

  void iniState() {
    setState(() {});
  }

  String? _dropDownValue;

  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode2 = FocusNode();

  String? selectedcategory;
  String? selectedNamacategory;
  String? selectedProduct;
  String? selectedSatuan;

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
    // final List<String> roles = _roles;

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

        Widget kategoriOutlet() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kategori Outlet",
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
                            'pilih',
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
                    items: categories
                        .map((category) => DropdownMenuItem<String>(
                              value: category,
                              child: Text(
                                category,
                                style: trueBlackInterTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedcategory,
                    onChanged: (value) {
                      setState(() {
                        selectedcategory = value as String;
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

        Widget namaOutlet() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nama Outlet",
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
                            'pilih',
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
                    items: nama_categories
                        .map((nama_category) => DropdownMenuItem<String>(
                              value: nama_category,
                              child: Text(
                                nama_category,
                                style: trueBlackInterTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedNamacategory,
                    onChanged: (value) {
                      setState(() {
                        selectedNamacategory = value as String;
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

        Widget satuan() {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Satuan",
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
                            'Pilih satuan',
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
                    items: satuans
                        .map((satuan) => DropdownMenuItem<String>(
                              value: satuan,
                              child: Text(
                                satuan,
                                style: trueBlackInterTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedSatuan,
                    onChanged: (value) {
                      setState(() {
                        selectedSatuan = value as String;
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

        Widget takePhoto() {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Ambil Gambar Toko",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                          width: MediaQuery.of(context).size.width * 0.4,
                          // height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: primaryBlue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                color: blueBrightColor,
                              ),
                              Text(
                                'Ambil Gambar',
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

        Widget input() {
          return RelativeBuilder(builder: (context, height, width, sy, sx) {
            return Padding(
              padding: const EdgeInsets.only(top: 21, bottom: 20),
              child: Container(
                // padding: const EdgeInsets.all(30.0),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    kategoriOutlet(),
                    produk(),
                    jumlah(),
                    satuan(),
                    total(),
                    takePhoto(),
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
                  style: ElevatedButton.styleFrom(primary: primaryBlue),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => StockListPage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,

                    // height: 36,
                    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // color: primaryBlue,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Calculate',
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
                          Icons.check_circle_outline,
                          color: blueBrightColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Save',
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

        Widget body() {
          return Expanded(
            flex: 10,
            child: Container(
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
                  button(),
                  download(),
                  // check(),
                ],
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
                    "09:00 - 18:00",
                    style: trueBlackRobotTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 24,
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryBlue),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) => StockListPage()));
                        },
                        child: Container(
                          // width: 137,
                          // height: 36,
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: primaryBlue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Log In',
                                style: whiteInterTextStyle.copyWith(
                                    fontSize: 16, fontWeight: medium),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: redColor),
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) => StockListPage()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                          // width: 137,
                          // height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: primaryBlue,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Log In',
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
          return Expanded(
            flex: 4,
            child: Container(
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
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            // backgroundColor: orangeYellow,
            body: CustomScrollView(slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/bgvisit.png'),
                            fit: BoxFit.cover)),
                    // height: MediaQuery.of(context).size.height,
                    // constraints: BoxConstraints(
                    //     maxHeight: MediaQuery.of(context).size.height),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisSize: MainAxisSize.min,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        header(),
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