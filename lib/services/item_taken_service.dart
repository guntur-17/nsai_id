import 'package:nsai_id/models/item_taken_model.dart';
import 'package:nsai_id/models/product_model.dart';

final allItemTaken = <itemTakenModel>[
  itemTakenModel(
      id: 1,
      absent_id: 'A0009',
      product_id: 'P0007',
      item_taken: 12000,
      total_item_sold: 1,
      sales_result: 12000,
      createdAt: DateTime.parse('2022-06-22T08:41:09.000000Z')),
  itemTakenModel(
      id: 2,
      absent_id: 'A0009',
      product_id: 'P0001',
      item_taken: 10000,
      total_item_sold: 3,
      sales_result: 30000,
      createdAt: DateTime.parse('2022-06-21T08:41:09.000000Z')),
  itemTakenModel(
      id: 3,
      absent_id: 'A0009',
      product_id: 'P0010',
      item_taken: 5000,
      total_item_sold: 2,
      sales_result: 10000,
      createdAt: DateTime.parse('2022-06-20T08:41:09.000000Z')),
  itemTakenModel(
      id: 4,
      absent_id: 'A0009',
      product_id: 'P0017',
      item_taken: 2000,
      total_item_sold: 6,
      sales_result: 12000,
      createdAt: DateTime.parse('2022-06-23T08:41:09.000000Z')),
];
