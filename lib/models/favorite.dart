import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  Timestamp? timestamp;
  final String? favoriteId;
  late final String? userEmailId;
  late final String? storeId;
  late final String? favoriteDesc;

  Favorite({
    this.timestamp,
    this.favoriteId,
    this.userEmailId,
    this.storeId,
    this.favoriteDesc,
  });

  factory Favorite.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Favorite(
      favoriteId: snapshot.id,
      userEmailId: data?['user_email_id'],
      storeId: data?['store_id'],
      favoriteDesc: data?['favorite_desc'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": Timestamp.now(),
      if (userEmailId != null) "user_email_id": userEmailId,
      if (storeId != null) "store_id": storeId,
      if (favoriteDesc != null) "favorite_desc": favoriteDesc,
    };
  }
}