import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  Timestamp? timestamp;
  bool? deleted;
  final String? storeId;
  late final String? userId;
  late final String? storeName;
  late final String? storeSubTitle;
  late final String? storeDescription;
  late final String? storeAddress;
  late final String? storeTell;
  late final String? storeHours;
  late final String? storeClosed;
  late final String? storeTraffic;
  late final String? storeParking;
  late final String? storeTMap;
  late final String? storeThumbnail;
  late final String? storeImageUrl;
  late final String? storeVideoUrl;
  late final String? storeThreeDUrl;
  late final List<String>? storeImgList;
  late final List<String>? storeTagList;
  final double? latitude;
  final double? longitude;
  final int? favorite;

  Store(
      {this.storeId,
      this.userId,
      this.storeName,
      this.storeSubTitle,
      this.storeDescription,
      this.storeAddress,
      this.storeTell,
      this.storeHours,
      this.storeClosed,
      this.storeTraffic,
      this.storeParking,
      this.storeTMap,
      this.storeVideoUrl,
      this.storeThreeDUrl,
      this.storeThumbnail,
      this.storeImageUrl,
      this.storeImgList,
      this.storeTagList,
      this.latitude,
      this.longitude,
        this.favorite
      });

  factory Store.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    late Map<String, dynamic>? data = snapshot.data();
    return Store(
      storeId: snapshot.id,
      userId: data?['user_id'],
      storeName: data?['store_name'],
      storeSubTitle: data?['store_sub_title'],
      storeDescription: data?['store_description'],
      storeAddress: data?['store_address'],
      storeTell: data?['store_tell'],
      storeHours: data?['store_hours'],
      storeClosed: data?['store_closed'],
      storeTraffic: data?['store_traffic'],
      storeParking: data?['store_parking'],
      storeTMap: data?['store_t_map'],
      storeThumbnail: data?['store_thumbnail'],
      storeImageUrl: data?['store_image_url'],
      storeVideoUrl: data?['store_video_url'],
      storeThreeDUrl: data?['store_three_d_url'],
      storeImgList: data?['store_img_list'] is Iterable
          ? List.from(data?['store_img_list'])
          : null,
      storeTagList: data?['store_tag_list'] is Iterable
          ? List.from(data?['store_tag_list'])
          : null,
      latitude: data?['latitude'],
      longitude: data?['longitude'],
      favorite: data?['favorite'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": Timestamp.now(),
      "deleted": false,
      if (userId != null) "user_id": userId,
      if (storeName != null) "store_name": storeName,
      if (storeSubTitle != null) "store_sub_title": storeSubTitle,
      if (storeDescription != null) "store_description": storeDescription,
      if (storeAddress != null) "store_address": storeAddress,
      if (storeTell != null) "store_tell": storeTell,
      if (storeHours != null) "store_hours": storeHours,
      if (storeClosed != null) "store_closed": storeClosed,
      if (storeTraffic != null) "store_traffic": storeTraffic,
      if (storeParking != null) "store_parking": storeParking,
      if (storeTMap != null) "store_t_map": storeTMap,
      if (storeThumbnail != null) "store_thumbnail": storeThumbnail,
      if (storeImageUrl != null) "store_image_url": storeImageUrl,
      if (storeVideoUrl != null) "store_video_url": storeVideoUrl,
      if (storeThreeDUrl != null) "store_three_d_url": storeThreeDUrl,
      if (storeImgList != null) "store_img_list": storeImgList,
      if (storeTagList != null) "store_tag_list": storeTagList,
      if (latitude != null) "latitude" : latitude,
      if (longitude != null) "longitude" : longitude,
    };
  }
}
