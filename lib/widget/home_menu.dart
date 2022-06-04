import 'package:flutter/material.dart';

import '../theme.dart';

class HomeMenu extends StatelessWidget {
  final String? title;
  final String? imgpath;
  final route;
  final ontap;
  const HomeMenu({Key? key, this.title, this.imgpath, this.route, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => route)));
        ontap;
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Color(0xff101828).withOpacity(0.1),
              spreadRadius: -4,
              blurRadius: 16,
              offset: Offset(0, 12), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Image.asset('$imgpath', width: 36, height: 36),
              Text('$title',
                  style: trueBlackRobotoTextStyle.copyWith(fontSize: 12))
            ],
          ),
        ),
      ),
    );
  }
}
