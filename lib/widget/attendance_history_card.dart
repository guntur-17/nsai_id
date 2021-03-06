import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nsai_id/models/distributor_model.dart';
import 'package:nsai_id/models/history_attendance_model.dart';
import 'package:nsai_id/models/product_model.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';
import 'package:nsai_id/pages/absent/attendance_page.dart';
import 'package:nsai_id/pages/transaction_page.dart';
import 'package:nsai_id/providers/Product_provider.dart';
import 'package:nsai_id/providers/outlet_provider.dart';
import 'package:nsai_id/theme.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceHistoryCard extends StatelessWidget {
  final AttendanceHistoryModel? historyDistributor;

  // final VoidCallback? function;
  final route;
  final route2;
  const AttendanceHistoryCard({
    Key? key,
    this.historyDistributor,
    this.route,
    this.route2,
  }) : super(key: key);

  // @override
  // State<ShopCard> createState() => _ShopCardState();
// }

// class _ShopCardState extends State<ShopCard> {

  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   print(widget.shop);
    // }
    // producthandler(distributor_id) async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();

    //   var token = prefs.getString('token');
    //   await Provider.of<ProductProvider>(context, listen: false)
    //       .getProduct(token, distributor_id);
    // }
    producthandler(distributor_id) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = prefs.getString('token');
      await Provider.of<ProductProvider>(context, listen: false)
          .getProduct(token, distributor_id);
    }

    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return InkWell(
          onTap: () async {
            if (historyDistributor!.item!.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => route,
                ),
              );
            } else {
              await producthandler(historyDistributor!.distributor_id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => route2,
                ),
              );
            }
          },
          child: Container(
            height: sy(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.shopping_bag_outlined),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  historyDistributor!.distributor!.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: trueBlackTextStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(historyDistributor!.id!),
              ],
            ),
          ),
        );
      },
    );
    ;
  }
}
