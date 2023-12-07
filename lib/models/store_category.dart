import 'package:cloud_firestore/cloud_firestore.dart';

class StoreCategory {
  final String? storeId;
  final List<Map>? coffee;
  final List<Map>? dessert;
  final List<Map>? etc;
  final List<Map>? goods;
  final List<Map>? nonCoffee;
  final List<Map>? seasonMenu;
  final List<Map>? signature;

  //
  // final String? storeId;
  // late List<String>? menuImageList;
  // final String menuName;
  // String menuDescription = '';
  // final int menuPrice;
  // List<String> allergyList = [];
  // final bool isBest;
  // final bool onlyHot;
  // final bool onlyIced;
  // final bool shotAddAllow;
  // final int shotPrice;
  // final bool syrupAddAllow;
  // final int syrupPrice;

  StoreCategory(
      {this.storeId,
      this.coffee,
      this.dessert,
      this.etc,
      this.goods,
      this.nonCoffee,
      this.seasonMenu,
      this.signature
      //
      // required this.storeId,
      // required this.menuImageList,
      // required this.menuName,
      // required this.menuDescription,
      // required this.menuPrice,
      // required this.allergyList,
      // required this.isBest,
      // required this.onlyHot,
      // required this.onlyIced,
      // required this.shotAddAllow,
      // required this.shotPrice,
      // required this.syrupAddAllow,
      // required this.syrupPrice
      });

  factory StoreCategory.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return StoreCategory(
      storeId: data?['store_id'] ?? '',
      coffee: data?['coffee'] is Iterable ? List.from(data?['coffee']) : null,
      dessert: data?['dessert'] is Iterable ? List.from(data?['dessert']) : null,
      etc: data?['etc'] is Iterable ? List.from(data?['etc']) : null,
      goods: data?['goods'] is Iterable ? List.from(data?['goods']) : null,
      nonCoffee: data?['non_coffee'] is Iterable ? List.from(data?['non_coffee']) : null,
      seasonMenu:
          data?['season_menu'] is Iterable ? List.from(data?['season_menu']) : null,
      signature: data?['signature'] is Iterable ? List.from(data?['signature']) : null,
      //
      // storeId: data?['store_id'],
      // menuImageList: data?['menu_image_list'],
      // menuName: data?['manu_name'],
      // menuDescription: data?['menu_description'],
      // menuPrice: data?['menu_price'],
      // allergyList: data?['allergy_list'],
      // isBest: data?['is_best'],
      // onlyHot: data?['only_hot'],
      // onlyIced: data?['only_iced'],
      // shotAddAllow: data?['shot_add_allow'],
      // shotPrice: data?['shot_price'],
      // syrupAddAllow: data?['syrup_add_allow'],
      // syrupPrice: data?['syrup_price']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (storeId != null) "store_id": storeId,
      if (coffee != null) "coffee": coffee,
      if (dessert != null) "dessert": dessert,
      if (etc != null) "etc": etc,
      if (goods != null) "goods": goods,
      if (nonCoffee != null) "non_coffee": nonCoffee,
      if (seasonMenu != null) "season_menu": seasonMenu,
      if (signature != null) "signature": signature,
      //
      // "timestamp": Timestamp.now(),
      // "deleted": false,
      // "store_id": storeId,
      // "menu_image_list": menuImageList,
      // "manu_name": menuName,
      // "menu_description": menuDescription,
      // "menu_price": menuPrice,
      // "allergy_list": allergyList,
      // "is_best": isBest,
      // "only_hot": onlyHot,
      // "only_iced": onlyIced,
      // "shot_add_allow": shotAddAllow,
      // "shot_price": shotPrice,
      // "syrup_add_allow": syrupAddAllow,
      // "syrup_price": syrupPrice
    };
  }
}
