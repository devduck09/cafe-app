import 'package:CUDI/config/theme.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../models/store.dart';
import 'etc/cudi_widgets.dart';
import 'haert_icon.dart';

class StoreCard extends StatefulWidget {
  final Store store;

  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  State<StoreCard> createState() => _StoreCardState();
}

class _StoreCardState extends State<StoreCard> {
  late Store store;

  @override
  Widget build(BuildContext context) {
    store = widget.store;
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: stack(),
    );
  }

  Widget stack() {
    return Stack(
      children: [
        storeImage(),
        gradient(),
        storeName(),
        storeAddress(),
        materialButton(),
        heartIcon(),
        threeDIcon(),
      ],
    );
  }

  Widget storeImage() {
    return Image.network(
      store.storeImageUrl.toString(),
      fit: BoxFit.cover,
      width: 342.w,
      height: 456.h,
    );
  }

  Widget gradient() {
    return Container(
      width: 342.w,
      height: 456.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              -0.15,
              0.6,
              1.15
            ],
            colors: [
              Color.fromARGB(180, 0, 0, 0),
              Color.fromARGB(0, 255, 255, 255),
              Color.fromARGB(180, 0, 0, 0)
            ]),
      ),
    );
  }

  Widget storeName() {
    return Positioned(
      top: 24,
      left: 24,
      child: Text(
        '${store.storeName}',
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          height: 1.0,
        ),
      ),
    );
  }

  Widget storeAddress() {
    return Positioned(
        top: 44, left: 24, child: customStoreAddress(store.storeAddress));
  }

  Widget materialButton() {
    UserProvider userProvider = context.read<UserProvider>();
    return MaterialButton(
      splashColor: white.withOpacity(0.1),
      onPressed: () => userProvider.goViewCafeScreen(context, store),
      child: SizedBox(
        width: 342.w,
        height: 456.h,
      ),
    );
  }

  Widget heartIcon() {
    return Positioned(
      left: 24.0,
      bottom: 24.0,
      child: HeartIcon(storeId: store.storeId),
    );
  }

  Widget threeDIcon() {
    return Positioned(
      bottom: 24.0,
      right: 24.0,
      child: ThreeDIcon(storeThreeDUrl: store.storeThreeDUrl.toString()),
    );
  }
}

class ThreeDIcon extends StatelessWidget {
  final String? storeThreeDUrl;

  const ThreeDIcon({Key? key, required this.storeThreeDUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.0,
      height: 32.0,
      child: IconButton(
        onPressed: () => Navigator.pushNamed(context, "/web_view",
            arguments: {"threeDUrl": storeThreeDUrl}),
        icon: Image.asset('assets/icon/view_3d.png'),
        constraints: const BoxConstraints(), // 아이콘 패딩 제거
        padding: const EdgeInsets.all(0),
      ),
    );
  }
}