import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nsai_id/models/distributor_model.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/outlet_model.dart';
import 'package:nsai_id/pages/absent/attendance_page.dart';
import 'package:nsai_id/pages/transaction_page.dart';
import 'package:nsai_id/theme.dart';
import 'package:relative_scale/relative_scale.dart';

class DistributorCard extends StatelessWidget {
  final DistributorModel shop;
  final double latUser;
  final double longUser;
  final route;
  const DistributorCard(
      {Key? key,
      required this.shop,
      this.route,
      required this.latUser,
      required this.longUser})
      : super(key: key);

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
            double? latshop = double.tryParse(shop.lat);
            double? longshop = double.tryParse(shop.long);
            var radius = Geolocator.distanceBetween(
                latUser, longUser, latshop!, longshop!);
            print(radius);
            if (radius <= 300) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => route,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: greenColor,
                  content: const Text(
                    'Jauh cok',
                    textAlign: TextAlign.center,
                  ),
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
                  shop.name,
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
