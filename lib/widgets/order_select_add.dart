// import 'package:flutter/material.dart';
// import '../config/theme.dart';
// import '../models/store_category.dart';
//
// class OrderSelectAdd extends StatefulWidget {
//   final Menu storeMenuOne;
//   final String what;
//   final int addPrice;
//   final VoidCallback plus;
//   final VoidCallback minus;
//   int count;
//
//   OrderSelectAdd({super.key, required this.what, required this.addPrice, required this.storeMenuOne, required this.plus, required this.minus, required this.count});
//
//   @override
//   State<OrderSelectAdd> createState() => _OrderSelectAddState();
// }
//
// class _OrderSelectAddState extends State<OrderSelectAdd> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 65.0,
//       padding:  const EdgeInsets.only(top: 24.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(widget.what,
//                   style: const TextStyle(color: black, fontWeight: FontWeight.w500)),
//               Text('${widget.addPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
//                   style: const TextStyle(color: gray58, fontSize: 12.0, height: 1.6)),
//             ],
//           ),
//           Container(
//             height: 36.0,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8.0),
//                 border: Border.all(color: grayEA)),
//             child: Row(
//               children: [
//                 TextButton(
//                     onPressed: widget.minus,
//                     child: const Text(
//                       '-',
//                       style: TextStyle(color: gray58),
//                     )),
//                 Text(
//                   widget.count.toString(),
//                   style: TextStyle(color: gray58),
//                 ),
//                 TextButton(
//                     onPressed: widget.plus,
//                     child: const Text(
//                       '+',
//                       style: TextStyle(color: gray58),
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }