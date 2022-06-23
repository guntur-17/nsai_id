import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:nsai_id/models/document_model.dart';
import 'package:nsai_id/theme.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DocumentCard extends StatelessWidget {
  final DocumentModel document;
  const DocumentCard({
    Key? key,
    required this.document,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        openFile(
          url: 'https://core.ac.uk/download/pdf/11718807.pdf',
          context: context,
        );
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
                    Row(
                      children: [
                        Icon(Icons.picture_as_pdf, color: redColor),
                        SizedBox(
                          width: 4,
                        ),
                        Text(document.name!),
                      ],
                    ),
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

  Future openFile({required String url, String? fileName, context}) async {
    final name = fileName ?? url.split('/').last;
    final file = await downloadFile(url, name, context);
    if (file == null) return;

    print('Path:${file.path}');

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name, context) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      Loader.show(
        context,
        isSafeAreaOverlay: false,
        // isBottomBarOverlay: false,
        // overlayFromBottom: 80,
        overlayColor: Colors.black26,
        progressIndicator: CircularProgressIndicator(
          color: blueBrightColor,
        ),
        themeData: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: whiteColor),
        ),
      );
      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      Loader.hide();

      return file;
    } catch (e) {
      return null;
    }
  }
}
