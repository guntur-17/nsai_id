import 'package:flutter/material.dart';
import 'package:nsai_id/models/shopDistance_model.dart';
import 'package:nsai_id/models/shop_model.dart';
import 'package:nsai_id/theme.dart';
import 'package:relative_scale/relative_scale.dart';

class ShopCard extends StatefulWidget {
  final ShopDistanceModel shop;
  const ShopCard({required this.shop, Key? key}) : super(key: key);

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
        return InkWell(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         CameraPages(shop!.id, shop.name, widget.addressUser),
            //   ),
            // );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            width: MediaQuery.of(context).size.width - 60,
            height: sy(40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.shopping_bag_outlined),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            widget.shop.shop.name,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: trueBlackTextStyle.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
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
