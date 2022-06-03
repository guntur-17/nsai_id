import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

import '../theme.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();

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
                height: MediaQuery.of(context).size.height * 0.8,
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
                                      "Jenis \nBarang",
                                      style: whiteInterTextStyle.copyWith(
                                          fontWeight: medium, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Satuan \nBarang",
                                      style: whiteInterTextStyle.copyWith(
                                          fontWeight: medium, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Jumlah \nBarang",
                                      style: whiteInterTextStyle.copyWith(
                                          fontWeight: medium, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    )),
                                    DataColumn(
                                        label: Text(
                                      "Satuan Harga",
                                      style: whiteInterTextStyle.copyWith(
                                          fontWeight: medium, fontSize: 16),
                                      textAlign: TextAlign.center,
                                    )),
                                  ],
                                  rows: List<DataRow>.generate(
                                    10,
                                    (index) => DataRow(
                                      color: MaterialStateProperty.resolveWith<
                                          Color?>((Set<MaterialState> states) {
                                        if (index.isEven) {
                                          return Color(0xffF4F4F5);
                                        }
                                        return null; // Use the default value.
                                      }),
                                      cells: [
                                        DataCell(
                                          Text(
                                            'CV. Berkah',
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Permen',
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Karton',
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            '100',
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            'Rp 10.000',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
          preferredSize: const Size.fromHeight(80.0),
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
