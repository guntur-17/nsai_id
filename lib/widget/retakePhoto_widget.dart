import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:nsai_id/theme.dart';

class RetakePhoto extends StatelessWidget {
  final image;
  final VoidCallback? function;
  final setState;
  RetakePhoto({this.image, this.function, this.setState, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Foto",
            style: trueBlackInterTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: InstaImageViewer(
              child: Image.file(
                image!,
                fit: BoxFit.cover,
                height: 230,
                width: 230,
              ),
            ),
          ),
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
            width: MediaQuery.of(context).size.width * 0.5,
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
                  'Retake a photo',
                  style: whiteInterTextStyle.copyWith(
                      fontSize: 16, fontWeight: medium, color: blueBrightColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
