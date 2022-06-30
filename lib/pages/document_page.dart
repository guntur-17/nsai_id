import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsai_id/models/document_model.dart';
import 'package:nsai_id/providers/document_provider.dart';
import 'package:nsai_id/widget/document_card.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';

import '../providers/region_provider.dart';
import '../theme.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  List<DocumentModel> _filterDocument = [];
  List<DocumentModel> _filteredDocument = [];
  DateTime selectedDate = DateTime.now();
  TextEditingController _textEditingController = TextEditingController();

  DateTime selectedDateA = DateTime.now();
  TextEditingController _textEditingControllerA = TextEditingController();

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

  _selectDateA(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateA != null ? selectedDateA : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040));
    if (picked != null && picked != selectedDateA) {
      setState(() {
        selectedDateA = picked;
      });
    }

    if (picked != null) {
      selectedDateA = picked;
      _textEditingControllerA
        ..text = DateFormat.yMMMd().format(selectedDateA)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingControllerA.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  @override
  initState() {
    DocumentProvider documentProvider =
        Provider.of<DocumentProvider>(context, listen: false);
    List<DocumentModel> document = documentProvider.documents.toList();
    print(document);
    _filterDocument = document;
    _filteredDocument = _filterDocument;
    super.initState();
  }

  void _runFilter() {
    List<DocumentModel> results = [];
    if (selectedDate == DateTime.now() && selectedDateA == DateTime.now()) {
      print(selectedDate);
      print(selectedDateA);
      // if the search field is empty or only contains white-space, we'll display all users
      results = _filterDocument;
    } else {
      results = _filterDocument
          .where(
            (element) =>
                selectedDate.isBefore(element.createdAt!) &&
                selectedDateA.isAfter(element.createdAt!),
          )
          .toList();
    }

    // Refresh the UI
    setState(() {
      _filteredDocument = results;
      print(_filteredDocument);
    });
  }

  @override
  Widget build(BuildContext context) {
    // List document = documentProvider.documents.reversed.toList();
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
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
                        width: 4,
                      ),
                      Text(
                        'Dokumenku',
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
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width * 0.9,
                    // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 12.0),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Dokumen A',
                                style: trueBlackRobotoTextStyle.copyWith(
                                    fontSize: 16, fontWeight: semiBold),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text('Periode',
                                      style: trueBlackInterTextStyle.copyWith(
                                          fontSize: 16)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 2, 0, 0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(10, 2, 0, 0),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                      controller: _textEditingControllerA,
                                      onTap: () {
                                        _selectDateA(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  _runFilter();
                                },
                                child: Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0354A6),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Submit',
                                      style: whiteInterTextStyle.copyWith(
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        Widget cardFiltered() {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: SizedBox(
              child: _filteredDocument.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredDocument.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        // ValueKey(_foundDoctor[index].id);
                        final document = _filteredDocument[index];
                        return DocumentCard(
                          document: document,
                        );
                      }),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 14),
                    ),
            ),
          );
        }

        // Widget body() {
        //   return Expanded(
        //     flex: 6,
        //     child: Container(
        //       // height: MediaQuery.of(context).size.height,
        //       width: double.infinity,
        //       padding:
        //           const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        //       decoration: const BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(30.0),
        //           topRight: Radius.circular(30.0),
        //         ),
        //       ),
        //       child: Column(
        //         // mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: document
        //             .map((e) => DocumentCard(
        //                   document: e,
        //                 ))
        //             .toList(),
        //       ),
        //     ),
        //   );
        // }

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
                            image: AssetImage('assets/bggray.png'),
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
                        cardFiltered()
                        // body(),
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
