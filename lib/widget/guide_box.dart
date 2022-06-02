import 'package:flutter/material.dart';

import '../theme.dart';

class GuidedBox extends StatelessWidget {
  final String? title;
  final String? content;
  const GuidedBox(this.title, this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
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
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width * 0.85,
        child: Container(
          margin: EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Text('$title',
                      style: trueBlackRobotoTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold)),
                ],
              ),
              Divider(
                height: 12,
              ),
              Column(
                children: [
                  Text(
                    '$content',
                    style: greyRobotoTextStyle.copyWith(fontSize: 12),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
