// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
//
// import 'firebase_firestore.dart';
// import 'notification_service.dart';
//
// class FavoriteStoresProvider with ChangeNotifier {
//   Map<String, dynamic> favoriteStores = {};
//
//   // 데이터를 가져오는 메서드
//   Future<void> fetchData(String userEmailId) async {
//     Map<String, dynamic> data2 = await FireStore.getFavoriteMap(userEmailId);
//     favoriteStores = data2;
//     notifyListeners();
//   }
// }
