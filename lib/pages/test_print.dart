import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nsai_id/models/product_model.dart';
import 'package:nsai_id/pages/guide_page.dart';
import 'package:nsai_id/pages/home_page.dart';
import 'package:nsai_id/pages/save_file_mobile.dart';
import 'package:nsai_id/services/product_service.dart';
import 'package:nsai_id/theme.dart';
import 'package:nsai_id/widget/faq_menu.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../widget/pdf-generator.dart';

class TestPrint extends StatefulWidget {
  const TestPrint({Key? key}) : super(key: key);

  @override
  State<TestPrint> createState() => _TestPrintState();
}

class _TestPrintState extends State<TestPrint> {
  late List<Product> _product;
  // List<Doctor> _foundDoctor = [];

  initState() {
    // at the beginning, all users are shown
    _product = allProduct;
    // _foundDoctor = allDoctor;
    super.initState();
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
                    image: AssetImage('assets/faq.png'),
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
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.lightBlue,
                          onSurface: Colors.grey,
                        ),
                        onPressed: () => generateInvoice(_product),
                        child: const Text('Generate PDF'),
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
              'FAQ',
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
                    image: AssetImage('assets/bgyellow.png'),
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
