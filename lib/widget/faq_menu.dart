import 'package:flutter/material.dart';
import 'package:nsai_id/pages/home_page.dart';

class FaqMenu extends StatelessWidget {
  final String? title;
  final route;
  const FaqMenu(this.title, this.route, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ));
      }),
      child: Container(
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
                    Text('$title'),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xff98A2B3),
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          ),
        ),
      ),
    );
  }
}
