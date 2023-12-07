import 'package:cloud_firestore/cloud_firestore.dart';

class Coupon {
  Timestamp? timestamp;
  bool? deleted;
  final String? couponId;
  final String? couponName;
  final int? discountRate;
  final int? discountPrice;
  final DateTime? startDate;
  final DateTime? finishDate;
  final String? state;

  Coupon(
      {this.couponId,
      this.couponName,
      this.discountRate,
      this.discountPrice,
      this.startDate,
        this.finishDate,
      this.state,
      this.timestamp,
      this.deleted});

  factory Coupon.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Coupon(
      timestamp: data?['timestamp'],
      deleted: data?['deleted'],
      couponId: snapshot.id,
      couponName: data?['coupon_name'],
      discountRate: data?['discount_rate'],
      discountPrice: data?['discount_price'],
      startDate: (data?['start_date'] as Timestamp?)?.toDate(),
      finishDate: (data?['finish_date'] as Timestamp?)?.toDate(),
      state: data?['state'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": Timestamp.now(),
      "deleted": false,
      if (couponName != null) "coupon_name": couponName,
      if (discountRate != null) "discount_rate": discountRate,
      if (discountPrice != null) "discount_price": discountPrice,
      if (startDate != null) "start_date": startDate,
      if (finishDate != null) "finish_date": finishDate,
      if (state != null) "state": state,
    };
  }
}
