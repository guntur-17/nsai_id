import 'package:flutter/material.dart';
import 'package:nsai_id/theme.dart';

class AbsentBlank extends StatelessWidget {
  const AbsentBlank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Color(0xff9ECA55), width: 4),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              'Harap selesaikan attendance kemarin dan kemarinnya yang belum terselesaikan',
              style: trueBlackRobotoTextStyle.copyWith(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
