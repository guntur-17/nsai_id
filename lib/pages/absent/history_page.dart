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

class HistoryPage extends StatefulWidget {
  final AttendanceHistoryModel attendanceHistory;

  HistoryPage({required this.attendanceHistory, Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  dynamic currentTime = DateFormat.Hms().format(DateTime.now());
  @override
  void initState() {
    super.initState();

    // _determinePosition();

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AttendanceHistoryModel history = widget.attendanceHistory;
    AttendanceProvider attedanceProvider =
        Provider.of<AttendanceProvider>(context);
    handleCheckout() async {
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
      if (await AttendanceProvider()
          .attendanceOut(id: history.id, token: token, time: currentTime)) {
        Loader.hide();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
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
        bool? isCheckin = true;
        bool? isLoading = false;
        List<ItemTakenModel>? product = history.item?.toList();
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
                                  "Harga \nSatuan",
                                  style: whiteInterTextStyle.copyWith(
                                      fontWeight: medium, fontSize: 14),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                              rows: product!.map((e) {
                                var index = product.indexOf(e);
                                return DataRow(
                                  color:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    if (index.isEven) {
                                      return Color(0xffF4F4F5);
                                    }
                                    return null; // Use the default value.
                                  }),
                                  cells: <DataCell>[
                                    DataCell(
                                        Center(child: Text(e.product!.name!))),
                                    DataCell(Center(
                                        child: Text(e.item_taken.toString()))),
                                    DataCell(Center(
                                        child: Text(
                                            e.product!.price!.toString()))),
                                  ],
                                );
                              }).toList()),
                        )
                      ],
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
                                history.distributor_photo!,
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
                                history.item_photo!,
                                height: 130,
                                width: 130,
                              ),
                            ),
                          ],
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
                    history.distributor!.name,
                    style: trueBlackRobotTextStyle.copyWith(
                      fontWeight: semiBold,
                      fontSize: 24,
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        history.clock_in!.substring(0, 5),
                        style: trueBlackRobotTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        " - ",
                        style: trueBlackRobotTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 20,
                        ),
                      ),
                      history.clock_out == "00:00:00"
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: primaryBlue),
                              onPressed: () async {
                                await handleCheckout();
                                // Navigator.of(context).push
                                // (MaterialPageRoute(
                                //     builder: (BuildContext context) => StockListPage()));
                              },
                              child: Container(
                                // width: 137,
                                // height: 36,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  // color: primaryBlue,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Check Out',
                                      style: whiteInterTextStyle.copyWith(
                                          fontSize: 16, fontWeight: medium),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Text(
                              history.clock_out!.substring(0, 5),
                              style: trueBlackRobotTextStyle.copyWith(
                                fontWeight: medium,
                                fontSize: 20,
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
