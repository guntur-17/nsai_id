import 'package:flutter/material.dart';
import 'package:nsai_id/theme.dart';

class ProfileCard extends StatelessWidget {
  final String? title;
  final String? content;
  final icon;
  const ProfileCard({this.title, this.content, this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 12.0, left: 12.0, bottom: 4.0, top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon),
                      SizedBox(width: 4),
                      Text(
                        '$title',
                        style: trueBlackRobotoTextStyle.copyWith(
                            fontSize: 14, fontWeight: bold),
                      ),
                    ],
                  ),
                  Text('$content'),
                ],
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
