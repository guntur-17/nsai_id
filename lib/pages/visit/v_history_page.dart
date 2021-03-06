import 'dart:ffi';
import 'dart:io';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:nsai_id/models/attendance_model.dart';

import 'package:nsai_id/models/distributor_model.dart';
import 'package:nsai_id/models/history_attendance_model.dart';
import 'package:nsai_id/models/item_taken_model.dart';
import 'package:nsai_id/models/product_model.dart';
import 'package:nsai_id/models/visiting_history_model.dart';
import 'package:nsai_id/models/visiting_sales_model.dart';
import 'package:nsai_id/pages/auth/register_page.dart';
import 'package:nsai_id/pages/home_page.dart';
import 'package:nsai_id/pages/test_page.dart';
import 'package:nsai_id/providers/Product_provider.dart';
import 'package:nsai_id/providers/attendance_provider.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/checkbox.dart';
import 'package:nsai_id/widget/currency.dart';
import 'package:nsai_id/widget/loading_widget.dart';
import 'package:nsai_id/widget/retakePhoto_widget.dart';
import 'package:nsai_id/widget/takePhoto_widget.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryVisiting extends StatefulWidget {
  final VisitingHistoryModel visitingHistory;

  HistoryVisiting({required this.visitingHistory, Key? key}) : super(key: key);

  @override
  State<HistoryVisiting> createState() => _HistoryVisitingState();
}

class _HistoryVisitingState extends State<HistoryVisiting> {
  @override
  void initState() {
    super.initState();

    // _determinePosition();

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        bool? isCheckin = true;
        bool? isLoading = false;
        List<VisitingSalesModel>? product =
            widget.visitingHistory.item?.toList();
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

        Widget body() {
          return Expanded(
            // flex: 10,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.9,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: DataTable(
                                columnSpacing: 40,
                                border: TableBorder.all(
                                  width: 1.0,
                                  color: grey,
                                ),
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Color(0xff0354A6)),
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: Text(
                                      "Nama \nBarang",
                                      style: whiteInterTextStyle.copyWith(
                                          fontWeight: medium, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  DataColumn(
                                      label: Text(
                                    "Jumlah \nBarang",
                                    style: whiteInterTextStyle.copyWith(
                                        fontWeight: medium, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  )),
                                  DataColumn(
                                      label: Text(
                                    "Jumlah \nHarga",
                                    style: whiteInterTextStyle.copyWith(
                                        fontWeight: medium, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  )),
                                ],
                                rows: product!.map((e) {
                                  var index = product.indexOf(e);
                                  return DataRow(
                                    color: MaterialStateProperty.resolveWith<
                                        Color?>((Set<MaterialState> states) {
                                      if (index.isEven) {
                                        return Color(0xffF4F4F5);
                                      }
                                      return null; // Use the default value.
                                    }),
                                    cells: <DataCell>[
                                      DataCell(Center(
                                          child: Text(e.product!.name!))),
                                      DataCell(Center(
                                          child: Text(e.item_sold.toString()))),
                                      DataCell(Center(
                                          child:
                                              Text(e.total_sales!.toString()))),
                                    ],
                                  );
                                }).toList()),
                          )
                        ]

                        // product!
                        //     .map(
                        //       (e) => Container(
                        //         padding: EdgeInsets.only(top: 8),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceAround,
                        //           children: [
                        //             Text(
                        //               e.product!.name!,
                        //               style: trueBlackInterTextStyle.copyWith(
                        //                 fontSize: 16,
                        //                 fontWeight: medium,
                        //               ),
                        //             ),
                        //             Text(
                        //               e.item_taken.toString(),
                        //               style: trueBlackInterTextStyle.copyWith(
                        //                 fontSize: 16,
                        //                 fontWeight: medium,
                        //               ),
                        //             ),
                        //             Text(
                        //               e.product!.price!.toString(),
                        //               style: trueBlackInterTextStyle.copyWith(
                        //                 fontSize: 16,
                        //                 fontWeight: medium,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //     .toList(),
                        ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Foto Distributor",
                              style: trueBlackInterTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InstaImageViewer(
                              child: Image.network(
                                widget.visitingHistory.outlet_photo!,
                                height: 130,
                                width: 130,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Foto Produk",
                              style: trueBlackInterTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InstaImageViewer(
                              child: Image.network(
                                widget.visitingHistory.item_photo!,
                                height: 130,
                                width: 130,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Foto Lainnya",
                          style: trueBlackInterTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InstaImageViewer(
                          child: Image.network(
                            widget.visitingHistory.other_photo!,
                            height: 130,
                            width: 130,
                          ),
                        ),
                      ],
                    ),
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
                    widget.visitingHistory.outlet!.name,
                    style: trueBlackRobotTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 24,
                    ),
                  ),
                  Divider(),
                  Text(
                    widget.visitingHistory.clock_in.toString().substring(0, 5),
                    style: trueBlackRobotTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 20,
                    ),
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
                      'Visit & Penjualan Barang',
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

        return SafeArea(
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            // backgroundColor: orangeYellow,

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
                                  image: AssetImage('assets/bgvisits.png'),
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

Widget takephoto(String text, StateSetter updateState) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: trueBlackInterTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: whiteColor,
                side: BorderSide(
                  width: 1.0,
                  color: blueBrightColor,
                )),
            onPressed: () {
              updateState(() {
                // function;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 12),
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
    ),
  );
}
