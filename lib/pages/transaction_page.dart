import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsai_id/pages/home_page.dart';
import 'package:nsai_id/pages/transaction_report_page.dart';

import '../theme.dart';

class TransactionPage extends StatefulWidget {
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late String dropdownvalue;
  late String dropdownvalueSell;

  // List of items in our dropdown menu
  var items = [
    'Distributor 1',
    'Distributor 2',
    'Distributor 3',
    'Distributor 4',
    'Distributor 5',
  ];

  DateTime selectedDate = DateTime.now();
  TextEditingController _textEditingController = TextEditingController();

  DateTime selectedDateSell = DateTime.now();
  TextEditingController _textEditingControllerSell = TextEditingController();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate != null ? selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }

    if (picked != null) {
      selectedDate = picked;
      _textEditingController
        ..text = DateFormat.yMMMd().format(selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectDateSell(BuildContext context) async {
    final DateTime? pickedSell = await showDatePicker(
        context: context,
        initialDate:
            selectedDateSell != null ? selectedDateSell : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));
    if (pickedSell != null && pickedSell != selectedDateSell) {
      setState(() {
        selectedDateSell = pickedSell;
      });
    }

    if (pickedSell != null) {
      selectedDateSell = pickedSell;
      _textEditingControllerSell
        ..text = DateFormat.yMMMd().format(selectedDateSell)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingControllerSell.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text('Pengambilan',
                                style: trueBlackInterTextStyle.copyWith(
                                    fontSize: 16)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 2, 0, 0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  hintText: 'Tanggal',
                                  hintStyle: TextStyle(
                                      fontSize: 16.0, color: trueBlack),
                                  suffixIcon: Icon(
                                    Icons.expand_more,
                                    color: blackColor,
                                  ),
                                ),
                                focusNode: AlwaysDisabledFocusNode(),
                                controller: _textEditingController,
                                onTap: () {
                                  _selectDate(context);
                                },
                              ),
                            ),
                            Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.47,
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 2, 0, 0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  hintText: 'All',
                                  hintStyle: TextStyle(
                                      fontSize: 16.0, color: trueBlack),
                                ),
                                // Initial Value
                                // value: dropdownvalue,
                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text('Penjualan',
                                style: trueBlackInterTextStyle.copyWith(
                                    fontSize: 16)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                hintText: 'Tanggal',
                                hintStyle:
                                    TextStyle(fontSize: 16.0, color: trueBlack),
                                suffixIcon: Icon(
                                  Icons.expand_more,
                                  color: blackColor,
                                ),
                              ),
                              focusNode: AlwaysDisabledFocusNode(),
                              controller: _textEditingControllerSell,
                              onTap: () {
                                _selectDateSell(context);
                              },
                            ),
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.47,
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 2, 0, 0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                hintText: 'All',
                                hintStyle:
                                    TextStyle(fontSize: 16.0, color: trueBlack),
                              ),
                              // Initial Value
                              // value: dropdownvalue,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: items.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalueSell = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => ReportPage())));
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Color(0xFF0354A6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                'Submit',
                                style:
                                    whiteInterTextStyle.copyWith(fontSize: 16),
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
              'Transaksi',
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
