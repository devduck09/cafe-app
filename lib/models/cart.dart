import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  final String? userEmailId;
  final String? storeId;
  final String? storeName;
  final String? menuId;
  final String? cartId;
  final String? menuImgUrl;
  final String? menuName;
  late final int? menuSumPrice;
  late final String? cup;
  final int? quantity;
  final int? addedShot;
  final int? addedSyrup;
  final bool? addedWhipping;
  late final bool? isChecked;
  late final String? selectedValue;
  late final String? selectedValue2;

  Cart({
    this.userEmailId,
    this.storeId,
    this.storeName,
    this.menuId,
    this.cartId,
    this.menuImgUrl,
    this.menuName,
    this.menuSumPrice,
    this.cup,
    this.quantity,
    this.addedShot,
    this.addedSyrup,
    this.addedWhipping,
    this.isChecked,
    this.selectedValue,
    this.selectedValue2,
  });

  factory Cart.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Cart(
        userEmailId: data?['user_id'],
        storeId: data?['store_id'],
        storeName: data?['store_name'],
        menuId: data?['menu_id'],
        cartId: snapshot.id,
        menuImgUrl: data?['menu_img_url'],
        menuName: data?['menu_name'],
        menuSumPrice: data?['menu_sum_price'],
        cup: data?['cup'],
        quantity: data?['quantity'],
        addedShot: data?['added_shot'],
        addedSyrup: data?['added_syrup'],
        addedWhipping: data?['added_whipping'],
        isChecked: data?['is_checked'],
        selectedValue: data?['selected_value'],
        selectedValue2: data?['selected_value2']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": Timestamp.now(),
      "deleted": false,
      if (userEmailId != null) "user_email_id": userEmailId,
      if (storeId != null) "store_id": storeId,
      if (storeName != null) "store_name" : storeName,
      if (menuId != null) "menu_id": menuId,
      if (menuImgUrl != null) "menu_img_url": menuImgUrl,
      if (menuName != null) "menu_name": menuName,
      if (menuSumPrice != null) "menu_sum_price": menuSumPrice,
      if (cup != null) "cup": cup,
      if (quantity != null) "quantity": quantity,
      if (addedShot != null) "added_shot": addedShot,
      if (addedSyrup != null) "added_syrup": addedSyrup,
      if (addedWhipping != null) "added_whipping": addedWhipping,
      if (isChecked != null) "is_checked": isChecked,
      if (selectedValue != null) "selected_value": selectedValue,
      if (selectedValue2 != null) "selected_value2": selectedValue2,
    };
  }
}