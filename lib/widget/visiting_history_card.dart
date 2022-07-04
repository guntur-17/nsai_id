import 'package:flutter/material.dart';
import 'package:nsai_id/models/visiting_history_model.dart';
import 'package:nsai_id/models/visiting_model.dart';
import 'package:provider/provider.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/Product_provider.dart';
import '../theme.dart';

class VisitingCard extends StatelessWidget {
  final VisitingHistoryModel? historyVisit;

  // final VoidCallback? function;
  final route;
  final route2;
  const VisitingCard({
    Key? key,
    this.historyVisit,
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
    // producthandler(outletId) async {
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();

    //   var token = prefs.getString('token');
    //   await Provider.of<ProductProvider>(context, listen: false)
    //       .getProduct(token, outletId);
    // }

    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return InkWell(
          onTap: () async {
            if (historyVisit!.item!.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => route,
                ),
              );
            } else {
              // await producthandler(historyVisit!.outlet_id);
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
                  historyVisit!.outlet!.name,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: trueBlackTextStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      },
    );
    ;
  }
}
