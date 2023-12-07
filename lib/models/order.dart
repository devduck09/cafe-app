import 'package:cloud_firestore/cloud_firestore.dart';

// 주문
// Order 클래스 이름이 다른 패키지 클래스 이름과 중복되어 OrderData로 변경
class OrderData {
  Timestamp? timestamp;
  bool? deleted;
  final String? orderId;
  final String? storeId;
  final String? userEmailId;
  final String? orderName;
  final DateTime? visitingTime;
  final String? coupon;
  final String? payment;
  final String? receipt;
  final int? orderAmount;
  final int? menuQuantity;
  final int? discountAmount;
  final String? discountDesc;

  OrderData(
      { this.orderId,
        this.storeId,
        this.userEmailId,
        this.orderName,
        this.visitingTime,
        this.coupon,
        this.payment,
        this.receipt,
        this.orderAmount,
        this.menuQuantity,
        this.discountAmount,
        this.discountDesc,
        this.timestamp,
      });

  factory OrderData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return OrderData(
      timestamp: data?['timestamp'],
      orderId: data?['order_id'],
      storeId: data?['store_id'],
      userEmailId: data?['user_id'],
      orderName: data?['order_name'],
      visitingTime: data?['visiting_time'],
      coupon: data?['coupon'],
      payment: data?['payment'],
      receipt: data?['receipt'],
      orderAmount: data?['order_amount'],
      menuQuantity: data?['menu_quantity'],
      discountAmount: data?['discount_amount'],
      discountDesc: data?['discount_desc'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": Timestamp.now(),
      "deleted": false,
      if (orderId != null) "order_id": orderId,
      if (storeId != null) "store_id": storeId,
      if (userEmailId != null) "user_email_id": userEmailId,
      if (orderName != null) "order_name": orderName,
      if (visitingTime != null) "visiting_time": visitingTime,
      if (coupon != null) "coupon": coupon,
      if (payment != null) "payment": payment,
      if (receipt != null) "receipt": receipt,
      if (orderAmount != null) "order_amount": orderAmount,
      if (menuQuantity != null) "menu_quantity": menuQuantity,
      if (discountAmount != null) "discount_amount": discountAmount,
      if (discountDesc != null) "discount_desc": discountDesc,
    };
  }
}
