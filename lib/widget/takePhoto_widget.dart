import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nsai_id/theme.dart';

// typedef AsyncCallback = Future<void> Function();

class TakePhoto extends StatelessWidget {
  final text;
  final VoidCallback? function;

  TakePhoto({this.text, this.function, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: trueBlackInterTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: whiteColor,
                  side: BorderSide(
                    width: 1.0,
                    color: blueBrightColor,
                  )),
              onPressed: function,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 1, vertical: 12),
                // width: MediaQuery.of(context).size.width,
                // height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: primaryBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: blueBrightColor,
                    ),
                    Text(
                      'Ambil Gambar',
                      style: whiteInterTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                          color: blueBrightColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
