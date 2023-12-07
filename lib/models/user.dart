import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  Timestamp? timestamp;
  bool? deleted;
  final List<bool>? userChecks;
  final String? userPhoneNumber;
  final String? userId;
  final String? userEmail;
  final String? userEmailId;
  final String? userPassword;
  final String? userBirth;
  final String? userGender;
  final String? userNickname;
  final Map<String, dynamic>? favoriteStoreMap;
  // final int? accumulatedPoints; // 적립금
  // final String? cashReceiptNumber; // 현금영수증번호
  // final List<String>? couponList; // 쿠폰 리스트

  User({
    this.userChecks,
    this.userPhoneNumber,
    this.userId,
    this.userEmail,
    this.userEmailId,
    this.userPassword,
    this.userBirth,
    this.userGender,
    this.userNickname,
    this.favoriteStoreMap,
    // this.accumulatedPoints, this.cashReceiptNumber, this.couponList,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      userChecks: data?['user_checks'] is Iterable ? List.from(data?['user_checks']) : null,
      userPhoneNumber: data?['user_phone_number'],
      userId: data?['user_id'],
      userEmail: data?['user_email'],
      userEmailId: data?['user_email_id'],
      userPassword: data?['user_password'],
      userBirth: data?['user_birth'],
      userGender: data?['user_gender'],
      userNickname: data?['user_nickname'],
      favoriteStoreMap: (data?['favorite_store_map'] as Map<String, dynamic>?)?.cast<String, dynamic>() ?? {},
      // accumulatedPoints: data?['accumulated_points'],
      // cashReceiptNumber: data?['cash_receipt_number'],
      // couponList: data?['coupon_list'] is Iterable ? List.from(data?['coupon_list']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": Timestamp.now(),
      "deleted": false,
      if (userChecks != null) "user_checks": userChecks,
      if (userPhoneNumber != null) "user_phone_number": userPhoneNumber,
      if (userId != null) "user_id": userId,
      if (userEmail != null) "user_email": userEmail,
      if (userEmailId != null) "user_email_id": userEmailId,
      if (userPassword != null) "user_password": userPassword,
      if (userBirth != null) "user_birth": userBirth,
      if (userGender != null) "user_gender": userGender,
      if (userNickname != null) "user_nickname": userNickname,
      if (favoriteStoreMap != null) "favorite_store_map": favoriteStoreMap,
    };
  }
}
