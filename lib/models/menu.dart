import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  final String? menuId;
  final String? storeId;
  final String? menuName;
  final String? menuDesc;
  final int? menuPrice;
  final String? menuAllergy;
  // final String? menuImgUrl;
  final String? menuCategory;
  final List<String>? menuImgList;
  final int? dripSweet;
  final int? dripBitter;
  final int? dripSour;
  final int? dripBody;

  Menu(
      {this.menuId,
      this.storeId,
      this.menuName,
      this.menuDesc,
      this.menuPrice,
      this.menuAllergy,
      // this.menuImgUrl,
      this.menuCategory,
        this.menuImgList,
        this.dripSweet,
        this.dripBitter,
        this.dripSour,
        this.dripBody,
      });

  factory Menu.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Menu(
      menuId: snapshot.id,
      storeId: data?['store_id'],
      menuName: data?['menu_name'],
      menuPrice: data?['menu_price'],
      menuDesc: data?['menu_desc'],
      menuAllergy: data?['menu_allergy'],
      // menuImgUrl: data?['menu_img_url'],
      menuCategory: data?['menu_category'],
      menuImgList: data?['menu_img_list'] is Iterable ? List.from(data?['menu_img_list']) : null,
      dripSweet: data?['drip_sweet'],
      dripBitter: data?['drip_bitter'],
      dripSour: data?['drip_sour'],
      dripBody: data?['drip_body']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": Timestamp.now(),
      if (storeId != null) "store_id": storeId,
      if (menuName != null) "menu_name": menuName,
      if (menuPrice != null) "menu_price": menuPrice,
      if (menuDesc != null) "menu_desc": menuDesc,
      if (menuAllergy != null) "menu_allergy": menuAllergy,
      // if (menuImgUrl != null) "menu_img_url": menuImgUrl,
      if (menuCategory != null) "menu_category": menuCategory,
      if (menuImgList != null) "menu_img_list": menuImgList,
      if(dripSweet != null) 'drip_sweet': dripSweet,
      if(dripBitter != null) 'drip_bitter': dripBitter,
      if(dripSour != null) 'drip_sour': dripSour,
      if(dripBody != null) 'drip_body': dripBody,
    };
  }
}


class MenuData {
  final List<Menu>? menuList;
  final Set<String>? categories;

  MenuData({this.menuList, this.categories});
}