// Widget distributor() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 6),
//     child: Column(
//       children: [
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             "Distributor",
//             style: trueBlackInterTextStyle.copyWith(
//               fontSize: 16,
//               fontWeight: medium,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 6,
//         ),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             isExpanded: true,
//             hint: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Select Item',
//                     style: trueBlackInterTextStyle.copyWith(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       // color: Colors.yellow,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             items: items
//                 .map((item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: trueBlackInterTextStyle.copyWith(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ))
//                 .toList(),
//             value: selectedDistributor,
//             onChanged: (value) {
//               setState(() {
//                 selectedDistributor = value as String;
//               });
//             },
//             icon: const Icon(
//               Icons.keyboard_arrow_down_rounded,
//             ),
//             iconSize: 14,
//             // iconEnabledColor: Colors.yellow,
//             // iconDisabledColor: Colors.grey,
//             buttonHeight: 50,
//             buttonWidth: MediaQuery.of(context).size.width * 0.9,
//             buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//             buttonDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(
//                 color: Colors.black26,
//               ),
//               // color: Colors.redAccent,
//             ),
//             // buttonElevation: 2,
//             itemHeight: 40,
//             itemPadding: const EdgeInsets.only(left: 14, right: 14),
//             dropdownMaxHeight: 200,
//             dropdownWidth: MediaQuery.of(context).size.width * 0.9,
//             dropdownPadding: null,
//             dropdownDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               // color: Colors.redAccent,
//             ),
//             dropdownElevation: 8,
//             scrollbarRadius: const Radius.circular(40),
//             scrollbarThickness: 6,
//             scrollbarAlwaysShow: false,
//             offset: const Offset(0, 0),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget satuan() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 6),
//     child: Column(
//       children: [
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Text(
//             "Satuan",
//             style: trueBlackInterTextStyle.copyWith(
//               fontSize: 16,
//               fontWeight: medium,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 6,
//         ),
//         DropdownButtonHideUnderline(
//           child: DropdownButton2(
//             isExpanded: true,
//             hint: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Pilih satuan',
//                     style: trueBlackInterTextStyle.copyWith(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       // color: Colors.yellow,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             items: satuans
//                 .map((satuan) => DropdownMenuItem<String>(
//                       value: satuan,
//                       child: Text(
//                         satuan,
//                         style: trueBlackInterTextStyle.copyWith(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ))
//                 .toList(),
//             value: selectedSatuan,
//             onChanged: (value) {
//               setState(() {
//                 selectedSatuan = value as String;
//               });
//             },
//             icon: const Icon(
//               Icons.keyboard_arrow_down_rounded,
//             ),
//             iconSize: 14,
//             // iconEnabledColor: Colors.yellow,
//             // iconDisabledColor: Colors.grey,
//             buttonHeight: 50,
//             buttonWidth: MediaQuery.of(context).size.width * 0.9,
//             buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//             buttonDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(
//                 color: Colors.black26,
//               ),
//               // color: Colors.redAccent,
//             ),
//             // buttonElevation: 2,
//             itemHeight: 40,
//             itemPadding: const EdgeInsets.only(left: 14, right: 14),
//             dropdownMaxHeight: 200,
//             dropdownWidth: MediaQuery.of(context).size.width * 0.9,
//             dropdownPadding: null,
//             dropdownDecoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(14),
//               // color: Colors.redAccent,
//             ),
//             dropdownElevation: 8,
//             scrollbarRadius: const Radius.circular(40),
//             scrollbarThickness: 6,
//             scrollbarAlwaysShow: false,
//             offset: const Offset(0, 0),
//           ),
//         ),
//       ],
//     ),
//   );
// }

