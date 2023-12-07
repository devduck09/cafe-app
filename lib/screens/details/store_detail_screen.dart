// import 'dart:async';
// import 'package:CUDI/widgets/chewie_list_item.dart';
// import 'package:CUDI/widgets/menu_list.dart';
// import 'package:CUDI/widgets/menu_title.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../models/store.dart';
// import '../../utils/firebase_firestore.dart';
// import '../../utils/notification_service.dart';
// import '../../widgets/video_player.dart';
//
// class StoreDetailScreen extends StatefulWidget {
//   final String storeId;
//
//   const StoreDetailScreen(this.storeId, {super.key});
//
//   @override
//   State<StoreDetailScreen> createState() => _StoreDetailScreenState();
// }
//
// class _StoreDetailScreenState extends State<StoreDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // url launcer
//     final Uri toLaunch = Uri.parse(store.storeTMap.toString());
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 // 스토어 사진
//                 Image.network(store.storeImageUrl.toString()),
//                 // 스토어 영상
//                 // VideoApp(videoUrl: videoUrl.toString()),
//                 ChewieListItem(videoUrl: videoUrl, looping: false,),
//                 // 스토어 대문
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
//                   child: Column(
//                     children: [
//                       Text(store.storeName.toString(),
//                           style: Theme.of(context).textTheme.headlineLarge),
//                       // 주소
//                       Text(store.storeAddress.toString()),
//                       // 칩스
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ActionChip(
//                             avatar: Icon(Icons.threed_rotation_rounded),
//                             label: const Text('3D 공간 보기'),
//                             onPressed: () {
//                               Navigator.pushReplacementNamed(context, "/web_view",
//                                   arguments: {
//                                     "threeDUrl": store.storeThreeDUrl.toString()
//                                   });
//                             },
//                           ),
//                           ActionChip(
//                             avatar: Icon(Icons.local_taxi_rounded),
//                             label: const Text('티맵 열기'),
//                             onPressed: () => setState(() {
//                               _launched = _launchInBrowser(toLaunch);
//                             }),
//                           ),
//                           ActionChip(
//                             avatar: Icon(isFavorite
//                                 ? Icons.favorite
//                                 : Icons.favorite_border),
//                             label: const Text('찜하기'),
//                             onPressed: () {
//                               setState(() {
//                                 isFavorite = !isFavorite;
//                               });
//                               if (isFavorite) {
//                                 NotificationService()
//                                     .showNotification('로컬 푸시 알림 🔔', '❤️ 찜한 카페에 추가되었습니다.');
//                               } else {
//                                 NotificationService()
//                                     .showNotification('로컬 푸시 알림 🔔', '찜한 카페에서 제거되었습니다.');
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 // // 스토어 메뉴
//                 MenuTitle(),
//                 MenuList(),
//                 MenuTitle(),
//                 MenuList(),
//               ],
//             ),
//             // 앱바가 이미지 위로 올라갈 수 있게 하기 위한 순서
//             AppBar(
//               actions: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.home_outlined),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.shopping_cart_outlined),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget StoreTop(store, toLaunch, tooltipkey) {
//   //   return
//   // }
//
//   // 브라우저 열기
//   Future<void> _launchInBrowser(Uri url) async {
//     if (!await launchUrl(
//       url,
//       mode: LaunchMode.externalApplication,
//     )) {
//       throw Exception('Could not launch $url');
//     }
//   }
//
//   // 데이터
//   late Store store;
//
//   // 데이터 전달 시간 차이로 전달되지 않는 것 변수로 설정
//   late String videoUrl = '';
//
//   // 액션칩
//   bool isFavorite = false;
//
//   // url launcher
//   Future<void>? _launched;
//
//   void _initializeData() async {
//     if (mounted) {
//       final fetchedStore =
//           await Firestore.getStoreDetail(widget.storeId.toString());
//       if (fetchedStore != null) {
//         setState(() {
//           store = fetchedStore; // 스토어 정보를 변수에 할당
//           videoUrl = store.storeVideoUrl.toString();
//           // print(store.storeVideoUrl.runtimeType);
//           // print(videoUrl.runtimeType);
//         });
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     _initializeData();
//     super.initState();
//   }
// }
