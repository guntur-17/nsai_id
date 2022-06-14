import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';
import 'package:nsai_id/pages/attendance_page.dart';
import 'package:nsai_id/pages/transaction_page.dart';
import 'package:nsai_id/theme.dart';
import 'package:relative_scale/relative_scale.dart';

class ShopCard extends StatelessWidget {
  final Map<String, dynamic> shop;
  final route;
  const ShopCard(this.shop, this.route, {Key? key}) : super(key: key);

  // @override
  // State<ShopCard> createState() => _ShopCardState();
// }

// class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   print(widget.shop);
    // }
    print(shop);
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => route,
              ),
            );
          },
          child: Container(
            height: sy(70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.shopping_bag_outlined),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  shop['shop'].name.toString(),
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
