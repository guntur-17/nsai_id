import 'package:flutter/material.dart';

import '../../theme.dart';
import '../../widget/loading_widget.dart';

class AbsentHistory extends StatefulWidget {
  const AbsentHistory({Key? key}) : super(key: key);

  @override
  State<AbsentHistory> createState() => _AbsentHistoryState();
}

class _AbsentHistoryState extends State<AbsentHistory> {
  bool isLoading = false;

  @override
  void initState() {
    // shopListHandler();
    super.initState();
    _handlefunction();

    // init();
  }

  Future _handlefunction() async {
    setState(() {
      isLoading = true;
    });
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget card() {
      return Container();
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: isLoading
            ? Loading()
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      // buildSearch(),
                      // isLoading ? const LoadingDefault() :
                      card(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
