import 'package:CUDI/config/route_name.dart';
import 'package:CUDI/models/coupon.dart';
import 'package:CUDI/models/favorite.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/etc/cudi_util_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/menu.dart';
import '../models/payments.dart';
import '../models/store.dart';
import '../models/user.dart';
import '../models/order.dart';
import 'dart:math' as math;

import 'notification_service.dart';

class FireStore {
  // 데이터 베이스
  static FirebaseFirestore db = FirebaseFirestore.instance;

  /// Store
  // 스토어 등록
  static void addStore(Store store) async {
    await FirebaseFirestore.instance
        .collection("store")
        .withConverter(
            fromFirestore: Store.fromFirestore,
            toFirestore: (Store docs, options) => store.toFirestore())
        .add(store);
    print("스토어 저장됨");
  }

  // 스토어 가져오기
  static Future<List<Store>> getTagStore(Set<String> tagFilterSet) async {
    final storesRef = FirebaseFirestore.instance.collection("store");

    if (tagFilterSet.isEmpty) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await storesRef.get();
      List<Store> storeList = querySnapshot.docs
          .map((doc) => Store.fromFirestore(doc, null))
          .toList();
      print('Tag Empty => all stores');
      return storeList;
    } else {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await storesRef
          .where("store_tag_list", arrayContainsAny: tagFilterSet.toList())
          .get();
      List<Store> storeList = querySnapshot.docs
          .map((doc) => Store.fromFirestore(doc, null))
          .toList();
      print('Tag Not Empty => tag stores');
      return storeList;
    }
  }

  // static Future<List<Store>> getStores() async {
  //   db.collection("store").get().then(
  //         (querySnapshot) {
  //       print("Get stores successfully completed");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         print('${docSnapshot.id} => ${docSnapshot.data()}');
  //       }
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  //
  //   return [];
  // }



  // 가까운 스토어 20개 가져오기
  static Future<List<Store>> getNearbyStores(
      double userLatitude, double userLongitude) async {
    final storesRef = FirebaseFirestore.instance.collection("store");

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await storesRef.get();

    List<Store> storeList = querySnapshot.docs
        .map((doc) => Store.fromFirestore(doc, null))
        .toList();

    // 위치 기반 정렬 추가
    storeList.sort((a, b) {
      double distanceToA = calculateDistance(
          userLatitude, userLongitude, a.latitude ?? 0, a.longitude ?? 0);
      double distanceToB = calculateDistance(
          userLatitude, userLongitude, b.latitude ?? 0, b.longitude ?? 0);
      return distanceToA.compareTo(distanceToB);
    });

    // 상위 20개 가게만 반환
    return storeList.take(20).toList();
  }

  // 두 지점 간의 거리 계산
  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // 지구 반지름 (단위: 킬로미터)

    // 각도를 라디안으로 변환
    double lat1Rad = _degreesToRadians(lat1);
    double lon1Rad = _degreesToRadians(lon1);
    double lat2Rad = _degreesToRadians(lat2);
    double lon2Rad = _degreesToRadians(lon2);

    // 위도와 경도의 차이 계산
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Haversine 공식 적용
    double a = (math.sin(dLat / 2) * math.sin(dLat / 2)) +
        math.cos(lat1Rad) *
            math.cos(lat2Rad) *
            (math.sin(dLon / 2) * math.sin(dLon / 2));
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  // 각도를 라디안으로 변환하는 보조 함수
  static double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  // static void updateStoreData(
  //     String storeId, double latitude, double longitude) {
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   final storeRef = db.collection("store").doc(storeId);
  //
  //   Store store = Store();
  //   Map<String, dynamic> updatedData = store.toFirestore();
  //   // updatedData["latitude"] = latitude;
  //   // updatedData["longitude"] = longitude;
  //
  //   storeRef.update(updatedData).then((value) {
  //     print("Document successfully updated!");
  //   }, onError: (e) {
  //     print("Error updating document: $e");
  //   });
  // }

  // 찜 업데이트
  static Future<void> updateStoreFavorite(String storeId,
      {bool isPlus = true}) async {
    var storeRef = db.collection('store').doc(storeId);

    if (isPlus) {
      storeRef.update(
        {"favorite": FieldValue.increment(1)},
      );
      print('스토어 찜 +1');
    } else {
      storeRef.update(
        {"favorite": FieldValue.increment(-1)},
      );
      print('스토어 찜 -1');
    }
  }

  /// User
  // 유저 등록
  static void addUser(User user) async {
    await FirebaseFirestore.instance
        .collection("user")
        .withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, options) => user.toFirestore())
        .doc(user.userEmailId)
        .set(user);
    print("유저 저장됨");
  }

  static Future<User> getUserDoc(String userEmailId) async {
    final ref = db.collection("user").doc(userEmailId).withConverter(
      fromFirestore: User.fromFirestore,
      toFirestore: (User user, _) => user.toFirestore(),
    );
    try {
      final docSnap = await ref.get();
      final user = docSnap.data(); // Convert to User object
      if (user != null) {
        return user;
      } else {
        print("No such document.");
        return User();
      }
    } catch (e) {
      print("Error getting user document: $e");
      return User(); // or throw an exception based on your error handling strategy
    }
  }


  // static User getUserToOrder(String userEmailId){
  //   final ref = db.collection('user').doc(userEmailId);
  //   final query = ref.get();
  //   return;
  // }

  static void userUpdate(BuildContext context, String userEmailId, {String? nickName, String? birth, String? gender, String? phoneNumber}) {
    final ref = db.collection("user").doc(userEmailId);

    Map<String, dynamic> updatedData = User().toFirestore();

    // 사용자가 입력한 값이 null이 아닌 경우에만 해당 필드를 업데이트
    if (nickName != null) {
      updatedData["user_nickname"] = nickName;
    }
    if (birth != null) {
      updatedData["user_birth"] = birth;
    }
    if (gender != null) {
      updatedData["user_gender"] = gender;
    }
    if (phoneNumber != null) {
      updatedData["user_phone_number"] = phoneNumber;
    }

    ref.update(updatedData).then((value) {
      print("Document successfully updated!");
      snackBar(context, "회원정보가 업데이트되었습니다.");
    }, onError: (e) {
      print("Error updating document: $e");
    });
  }


  /// Favorite
  // 좋아요 추가 (설명 편집 아닐 땐 설명에 '')
  static Future<void> updateFavorite(String? userEmailId, String? storeId,
      String? favoriteDesc, Timestamp timestamp) async {
    final favoriteRef = db.collection("user").doc(userEmailId);
    // final collectionRef = db.collection("user");
    // final docOneUserRef = collectionRef.doc(userEmailId);
    // final fieldFavoriteRdf = docOneUserRef.

    // Get the existing favorite store map
    DocumentSnapshot<Map<String, dynamic>> userDoc = await favoriteRef.get();
    Map<String, dynamic>? existingFavoriteMap =
        userDoc.data()?['favorite_store_map'];

    // Initialize the existingFavoriteMap if it's null
    if (existingFavoriteMap == null) {
      existingFavoriteMap = {};
    }

// Check if the storeId key exists in the map
    if (!existingFavoriteMap.containsKey(storeId)) {
      existingFavoriteMap[storeId!] = {}; // Initialize the map for the storeId
    }

// Create a Map to store the favorite description and timestamp
    Map<String, dynamic> favoriteEntry = {
      'description': favoriteDesc,
      'timestamp': timestamp,
    };

// Add the favorite description and timestamp to the map for the storeId
    existingFavoriteMap[storeId!] = favoriteEntry;

// Update the document with the merged map
    favoriteRef.update({
      "favorite_store_map": existingFavoriteMap,
    }).then(
      (value) => print("유저 찜 등록"),
      onError: (e) => print("Error updating document $e"),
    );
  }

  static Future<void> removeFavorite(String? userId, String? storeId) async {
    final favoriteRef = db.collection("user").doc(userId);
    favoriteRef.update({
      "favorite_store_map.$storeId": FieldValue.delete(),
    });
    print('유저 찜 삭제');
  }

  static Future<Map<String, dynamic>> getFavoriteMap(
      String? userEmailId) async {
    try {
      // 한 유저의 문서
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('user')
          .doc(userEmailId)
          .get();
      if (userDoc.exists) {
        // user 문서가 존재하는 경우 'favorite_store_map' 필드를 가져옴
        Map<String, dynamic> favoriteStoreMap =
            Map<String, dynamic>.from(userDoc.data()!['favorite_store_map']);
        return favoriteStoreMap;
      } else {
        // 사용자 문서가 없을 경우 빈 맵 반환
        return {};
      }
    } catch (e) {
      print("getFavoriteMap 오류 발생: $e");
      return {};
    }
  }

  static Future<List<Store>> getFavoriteStores(String? userEmailId) async {
    try {
      Map<String, dynamic> favoriteStoreMap = await getFavoriteMap(userEmailId);
      List<Store> storeList = [];

      QuerySnapshot<Map<String, dynamic>> storeQuerySnapshot =
          await FirebaseFirestore.instance
              .collection('store')
              .where(FieldPath.documentId,
                  whereIn: favoriteStoreMap.keys.toList())
              .get();

      for (int i = storeQuerySnapshot.docs.length - 1; i >= 0; i--) {
        QueryDocumentSnapshot<Map<String, dynamic>> storeDoc =
            storeQuerySnapshot.docs[i];
        // Store 객체로 변환하여 리스트에 추가
        Store store = Store.fromFirestore(storeDoc, null);
        storeList.add(store);
      }

      return storeList;
    } catch (e) {
      print("getFavoriteStores 오류 발생: $e");
      return [];
    }
  }

  static Future<void> addFavorite(Favorite fav) async {
    final docRef = db
        .collection("favorite")
        .withConverter(
      fromFirestore: Favorite.fromFirestore,
      toFirestore: (Favorite favorite, options) => favorite.toFirestore(),
    );
    await docRef.add(fav).then((documentSnapshot) =>
        print("Added Favorite doc with ID: ${documentSnapshot.id}"));
  }

  static Future<void> deleteFavorite(String userEmailId, String storeId) async {
    try {
      // Get the document reference using the where clause
      print(userEmailId);
      print(storeId);
      QuerySnapshot querySnapshot = await db
          .collection("favorite")
          .where("user_email_id", isEqualTo: userEmailId)
          .where("store_id", isEqualTo: storeId)
          .get();
      // print(querySnapshot.docs);

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Delete each matching document
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          await db.collection("favorite").doc(document.id).delete();
          print('${document.id}');
          print("Favorite doc deleted");
        }
      } else {
        print("No matching favorite found");
      }
    } catch (e) {
      print("Error deleting favorite: $e");
    }

    // db.collection("favorite").doc(favoriteId).delete().then(
    //       (doc) => print("Favorite doc deleted"),
    //   onError: (e) => print("Error updating document $e"),
    // );
  }

  // 즐겨찾기 토글 메서드
  static Future<void> toggleFavorite(bool isFavorite, String userEmailId, String storeId) async {
    if (!isFavorite) {
      Favorite fav = Favorite(
        userEmailId: userEmailId,
        storeId: storeId,
        timestamp: Timestamp.now(),
      );
      await addFavorite(fav);
      await updateFavorite(
        userEmailId,
        storeId,
        '',
        Timestamp.fromDate(DateTime.now()),
      );
      await updateStoreFavorite(storeId, isPlus: true);
      NotificationService().showNotification(
        '로컬 푸시 알림 🔔',
        '❤️ 찜한 카페에 추가되었습니다.',
      );
    } else {
      await deleteFavorite(userEmailId, storeId);
      await removeFavorite(userEmailId, storeId);
      await updateStoreFavorite(storeId, isPlus: false);
      NotificationService().showNotification(
        '로컬 푸시 알림 🔔',
        '찜한 카페에서 제거되었습니다.',
      );
    }
  }

  // 스토어의 favorite 개수 얻기
  static Future<int> getFavQuanWithStore(String storeId) async {
    QuerySnapshot querySnapshot = await db.collection('favorite').where("store_id", isEqualTo: storeId).get();
    print('fav quantity: ${querySnapshot.docs}');
    return querySnapshot.size;
  }

  /// Menu
  // 메뉴 저장
  static void addMenu(Menu menu, String? storeId) async {
    await FirebaseFirestore.instance
        .collection("store")
        .doc(storeId)
        .collection("menu")
        .withConverter(
            fromFirestore: Menu.fromFirestore,
            toFirestore: (Menu docs, options) => menu.toFirestore())
        .add(menu);
    print("메뉴 저장됨");
  }

  // 스토어의 총 메뉴 수
  static Future<void> countMenuDocs(String? storeId) async {
    final QuerySnapshot menuDocs = await FirebaseFirestore.instance
        .collection('store')
        .doc(storeId)
        .collection('menu')
        .get();

    final int documentCount = menuDocs.size;
    print('총 문서 개수: $documentCount');
  }

  // 카테고리로 메뉴 가져오기
  static Future<Map<String, List<Menu>>> getMenusGroupedByCategory(
      String? storeId) async {
    final menuRef = FirebaseFirestore.instance
        .collection("store")
        .doc(storeId)
        .collection("menu");

    final querySnapshot = await menuRef.get();
    Map<String, List<Menu>> menusByCategory = {}; // 리턴할 변수

    for (var docSnapshot in querySnapshot.docs) {
      var menu = Menu.fromFirestore(docSnapshot, null); // Menu 객체로 컨버팅
      var category = docSnapshot.data()[
          'menu_category']; // Firestore의 문서(snapshot)에서 'menu_category' 필드의 값을 가져오는 것

      if (category != null) {
        if (!menusByCategory.containsKey(category)) {
          menusByCategory[category] = []; // 해당 카테고리가 없다면 빈 리스트로 초기화
        }
        menusByCategory[category]!.add(menu); // 해당 카테고리 리스트에 메뉴 추가
      }
    }

    // print('카테고리 별 메뉴 리스트 작업 수행함');
    // print('Menus Grouped by Category: ${menusByCategory}');

    return menusByCategory;
  }

  // 메뉴 카테고리 한글로 넣기
  //// 카테고리가 커피인 문서
  static Future<void> printMenuCategoryLanguage(String? storeId) async {
    db
        .collection("store")
        .doc(storeId)
        .collection('menu')
        .where("menu_category", isEqualTo: 'coffee')
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        print(querySnapshot.size);
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  //// 카테고리가 커피인 문서 업데이트
  // 전체 문서를 덮어쓰지 않고 문서의 일부 필드를 업데이트 하려면 update() 메서드 사용
  static Future<void> updateMenuCategoryLanguage(String? storeId) async {
    // 카테고리가 커피인 문서
    db
        .collection("store")
        .doc(storeId)
        .collection('menu')
        .where("menu_category", isEqualTo: 'signature')
        .get()
        .then(
      (querySnapshot) {
        // print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          // print('${docSnapshot.id} => ${docSnapshot.data()}');
          // 카테고리가 커피인 문서 업데이트
          final washingtonRef = db
              .collection('store')
              .doc(storeId)
              .collection("menu")
              .doc(docSnapshot.id);
          washingtonRef.update({"menu_category": "시그니처"}).then(
              (value) => print("DocumentSnapshot successfully updated!"),
              onError: (e) => print("Error updating document $e"));
        }
        // print(querySnapshot.size);
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  // 카테고리 Set 만들기
  static Future<Set<String>> getMenuCategories(String? storeId) async {
    Set<String> categories = {};

    await db.collection("store").doc(storeId).collection("menu").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          var category = docSnapshot.data()['menu_category'];
          if (category != null) {
            categories.add(category);
          }
        }
      },
      onError: (e) => print("Error fetching categories: $e"),
    );

    return categories;
  }

  static Future<Map<String, dynamic>> getMenu(String storeId) async {
    final ref = db.collection('menu');
    final query = ref.where('store_id', isEqualTo: storeId);

    final Map<String, dynamic> menu = {};

    try {
      final querySnapshot = await query.get();
      print("Successfully completed");

      for (var docSnapshot in querySnapshot.docs) {
        final data = docSnapshot.data();
        data.forEach((key, value) {
          // 'menu' Map에 각 데이터를 추가합니다.
          menu[key] = value;
        });
      }
    } catch (e) {
      print("Error completing: $e");
      // 에러 처리
    }

    return menu;
  }

  /// Cart
  static Future<String> addCart(BuildContext context, Cart cart) async {
    // current의 store_id와 같지 않은 cart 문서들 모두 삭제한 뒤 추가
    String userEmailId = UserProvider.of(context).userEmailId;
    String currentStoreId = UserProvider.of(context).currentStore.storeId.toString();
    final ref = db.collection('user').doc(userEmailId).collection("cart");
    final query = ref.where('store_id', isNotEqualTo: currentStoreId);
    QuerySnapshot querySnapshot = await query.get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    DocumentReference<Cart> docRef = await FirebaseFirestore.instance
        .collection("user")
        .doc(userEmailId)
        .collection("cart")
        .withConverter(
            fromFirestore: Cart.fromFirestore,
            toFirestore: (Cart docs, options) => cart.toFirestore())
        .add(cart);
    print("장바구니 저장됨");

    return docRef.id;
  }

  static void deleteCartDoc(String orderId, String userEmailId) {
    db
        .collection('user')
        .doc(userEmailId)
        .collection("cart")
        .doc(orderId)
        .delete()
        .then(
          (doc) => print("Document deleted"),
          onError: (e) => print("Error updating document $e"),
        );
  }

  // 수량 업데이트
  static void updateOrderQuantity(String orderId, String userEmailId,
      {bool isPlus = true}) {
    var orderDataRef =
        db.collection('user').doc(userEmailId).collection('cart').doc(orderId);

    if (isPlus) {
      orderDataRef.update(
        {"quantity": FieldValue.increment(1)},
      );
      print('수량 추가됨');
    } else {
      orderDataRef.update(
        {"quantity": FieldValue.increment(-1)},
      );
      print('수량 감소됨');
    }
  }

  // 회원의 카트 리스트 가져오기
  static Future<List<Cart>> getCart(
      String userEmailId) async {
    final ref = db.collection('user').doc(userEmailId).collection('cart');
    // final query = ref
    //     // .where('user_email_id', isEqualTo: userEmailId)
    //     .where('store_id', isEqualTo: storeId);

    try {
      var querySnapshot = await ref.get();
      print("getCart: Successfully completed");
      List<Cart> cartList = [];
      for (var docSnapshot in querySnapshot.docs) {
        Cart cart = Cart.fromFirestore(docSnapshot, null);
        cartList.add(cart);
      }
      return cartList;
    } catch (e) {
      print("getCart: Error completing: $e");
      return []; // 에러 발생 시 빈 리스트 반환하거나 예외처리에 맞게 반환
    }
  }

  /// 결제
  static void addPaymentsBasicInfo(
      String userEmailId, Payments payments) async {
    await FirebaseFirestore.instance
        .collection("user")
        .doc(userEmailId)
        .collection('payments')
        .withConverter(
            fromFirestore: Payments.fromFirestore,
            toFirestore: (Payments payments, options) => payments.toFirestore())
        .doc(userEmailId)
        .set(payments);
    print("basicInfo 저장됨");
  }

  /// 주문
  static void addOrder(OrderData od) async {
    await db.collection('order').
    withConverter(fromFirestore: OrderData.fromFirestore, toFirestore: (OrderData od, option) => od.toFirestore())
        .add(od).then((value) => debugPrint('파이어베이스에 주문 저장됨 $value'));
  }

  /// 쿠폰
  static void addCoupon(Coupon coupon) async {
    await FirebaseFirestore.instance
        .collection("coupon")
        .withConverter(
            fromFirestore: Coupon.fromFirestore,
            toFirestore: (Coupon coupon, options) => coupon.toFirestore())
        .add(coupon);
    print("쿠폰 저장됨");
  }

  static Future<List<Coupon>> getCoupons() async {
    List<Coupon> coupons = [];
    db.collection("coupon").get().then(
      (querySnapshot) {
        print("get coupons");
        for (var docSnapshot in querySnapshot.docs) {
          // print('${docSnapshot.id} => ${docSnapshot.data()}');
          Coupon coupon = Coupon.fromFirestore(docSnapshot, null);
          coupons.add(coupon);
          // print(coupon);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return coupons;
  }

  // static void updateStoreData(String s, double d, double e) {}
}
