import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsai_id/models/history_attendance_model.dart';
import 'package:nsai_id/models/item_taken_model.dart';
import 'package:nsai_id/services/item_taken_service.dart';
import 'package:provider/provider.dart';

import '../providers/attendance_provider.dart';
import '../theme.dart';

extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime date) {
    // ignore hour,minute,second..
    final dateFormat = DateFormat("yyyy-MM-dd");
    final date1 = dateFormat.format(this);
    final date2 = dateFormat.format(date);
    return date1 == date2;
  }
}

class ReportPage extends StatefulWidget {
  final DateTime selectedDate;
  final String distributor;
  const ReportPage(
      {Key? key, required this.selectedDate, required this.distributor})
      : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<ItemTakenModel> _itemTaken = [];
  List<ItemTakenModel> _itemTakens = [];

  @override
  initState() {
    List<ItemTakenModel> itemTaken = allItemTaken;
    _itemTaken = itemTaken
        .where((element) => widget.selectedDate.isSameDay(element.createdAt!))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();
    AttendanceProvider attendanceProvider =
        Provider.of<AttendanceProvider>(context, listen: false);
    // List distributor = distributorProvider.distributors.toList();

    List<AttendanceHistoryModel> list = attendanceProvider.attendancesHistory
        .where((element) => element.distributor_id == widget.distributor)
        .toList();
    for (var _item in list) {
      _itemTakens.addAll(_item.item!);
    }

    Widget body() {
      return Expanded(
        child: Stack(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Image(
                    image: AssetImage('assets/chart.png'),
                    height: 130,
                    width: 130,
                  ),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, right: 20, left: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text('Periode X s/d Y',
                                style: trueBlackInterTextStyle.copyWith(
                                    fontSize: 12)),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: AdaptiveScrollbar(
                          underColor: Colors.blueGrey.withOpacity(0.3),
                          sliderDefaultColor: Colors.grey.withOpacity(0.7),
                          sliderActiveColor: Colors.grey,
                          controller: _verticalScrollController,
                          child: AdaptiveScrollbar(
                            position: ScrollbarPosition.bottom,
                            underColor: Colors.blueGrey.withOpacity(0.3),
                            sliderDefaultColor: Colors.grey.withOpacity(0.7),
                            controller: _horizontalScrollController,
                            sliderActiveColor: Colors.grey,
                            child: SingleChildScrollView(
                              controller: _verticalScrollController,
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                controller: _horizontalScrollController,
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                    border: TableBorder.all(
                                      width: 1.0,
                                      color: grey,
                                    ),
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => Color(0xff005FBE)),
                                    // dataRowColor:
                                    //     MaterialStateProperty.resolveWith<Color?>(
                                    //         (Set<MaterialState> states) {
                                    //   if (states.contains(MaterialState.selected)) {
                                    //     return Theme.of(context)
                                    //         .colorScheme
                                    //         .primary
                                    //         .withOpacity(0.08);
                                    //   }
                                    //   return null; // Use the default value.
                                    // }),
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                          "Nama \nBarang",
                                          style: whiteInterTextStyle.copyWith(
                                              fontWeight: medium, fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      DataColumn(
                                          label: Text(
                                        "Satuan \nBarang",
                                        style: whiteInterTextStyle.copyWith(
                                            fontWeight: medium, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Harga \nSatuan",
                                        style: whiteInterTextStyle.copyWith(
                                            fontWeight: medium, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Barang \nTerjual",
                                        style: whiteInterTextStyle.copyWith(
                                            fontWeight: medium, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      )),
                                      DataColumn(
                                          label: Text(
                                        "Hasil \nPenjualan",
                                        style: whiteInterTextStyle.copyWith(
                                            fontWeight: medium, fontSize: 16),
                                        textAlign: TextAlign.center,
                                      )),
                                    ],
                                    rows: _itemTakens.map((e) {
                                      var index = _itemTakens.indexOf(e);
                                      return DataRow(
                                        color: MaterialStateProperty
                                            .resolveWith<Color?>(
                                                (Set<MaterialState> states) {
                                          if (index.isEven) {
                                            return Color(0xffF4F4F5);
                                          }
                                          return null; // Use the default value.
                                        }),
                                        cells: <DataCell>[
                                          DataCell(Text(e.product!
                                              .name!)), //Extracting from Map element the value
                                          DataCell(Text(e.product!.unit!)),
                                          DataCell(Text(
                                              e.product!.price!.toString())),
                                          DataCell(Text(
                                              e.total_item_sold.toString())),
                                          DataCell(
                                              Text(e.sales_result.toString())),
                                        ],
                                      );
                                    }).toList()
                                    // List<DataRow>.generate(
                                    //   10,
                                    //   (index) => DataRow(
                                    //     color: MaterialStateProperty.resolveWith<
                                    //         Color?>((Set<MaterialState> states) {
                                    //       if (index.isEven) {
                                    //         return Color(0xffF4F4F5);
                                    //       }
                                    //       return null; // Use the default value.
                                    //     }),
                                    //     cells: [
                                    //       DataCell(
                                    //         Text(
                                    //           'CV. Berkah',
                                    //         ),
                                    //       ),
                                    //       DataCell(
                                    //         Text(
                                    //           'Permen',
                                    //         ),
                                    //       ),
                                    //       DataCell(
                                    //         Text(
                                    //           'Karton',
                                    //         ),
                                    //       ),
                                    //       DataCell(
                                    //         Text(
                                    //           '100',
                                    //         ),
                                    //       ),
                                    //       DataCell(
                                    //         Text(
                                    //           'Rp 10.000',
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            titleSpacing: 0,
            toolbarHeight: 120,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: whiteColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            centerTitle: false,
            backgroundColor: Colors.transparent,
            bottomOpacity: 0.0,
            elevation: 0.0,
            title: Text(
              'Report Pengambilan Produk',
              style: whiteRobotoTextStyle.copyWith(
                  fontSize: 20, fontWeight: semiBold),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bgpurple.png'),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                // header(),
                body(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
