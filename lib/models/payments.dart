import 'package:cloud_firestore/cloud_firestore.dart';

class Payments {
  final int? accumulatedPoints; // 적립금
  final String? cashReceiptNumber; // 현금영수증번호
  final List<String>? couponList;

  Payments({
    this.accumulatedPoints,
    this.cashReceiptNumber,
    this.couponList,
  });

  factory Payments.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Payments(
      accumulatedPoints: data?['accumulated_points'],
      cashReceiptNumber: data?['cash_receipt_number'],
      couponList: data?['coupon_list'] is Iterable ? List.from(data?['coupon_list']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (accumulatedPoints != null) "accumulated_points": accumulatedPoints,
      if (cashReceiptNumber != null) "cash_receipt_number": cashReceiptNumber,
      if (couponList != null) "coupon_list": couponList,
    };
  }
}