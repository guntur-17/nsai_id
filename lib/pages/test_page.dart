import 'package:flutter/material.dart';

import '../theme.dart';

class StockListPage extends StatefulWidget {
  StockListPage({Key? key}) : super(key: key);

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [],
          ),
        ),
      );
    }

    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.0),
            child: Column(
              children: [
                AppBar(
                  toolbarHeight: 120,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: trueBlack,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  iconTheme: IconThemeData(color: Colors.black),
                  centerTitle: true,
                  backgroundColor: blueBlurColor,
                  bottomOpacity: 0.0,
                  elevation: 0.0,
                  title: new Text(
                    'Shop Detail',
                    style: trueBlackTextStyle.copyWith(
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "data",
                ),
              ],
            ),
          ),
          backgroundColor: blueBlurColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              body(),
            ],
          ),
        ),
      ),
    );
  }
}
