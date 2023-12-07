import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../config/theme.dart';
import '../utils/firebase_firestore.dart';
import '../utils/provider.dart';

class HeartIcon extends StatefulWidget {
  final String? storeId;
  bool? isPlain;
  bool? isColumn;
  HeartIcon({Key? key, required this.storeId, this.isPlain, this.isColumn}) : super(key: key);

  @override
  State<HeartIcon> createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  late bool isFavorite;
  late int storeFav = 0;

  // favorite 개수
  void _initializeData() async {
    late int data;
    if (mounted) {
      data = await FireStore.getFavQuanWithStore(widget.storeId.toString());
      setState(() {
        storeFav = data;
      });
    }
  }

  @override
  void initState() {
    if(widget.isPlain!=null)_initializeData();
    if(widget.isColumn!=null)_initializeData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    isFavorite = CudiProvider.of(context).favorites
        .any((favorite) => favorite.storeId == widget.storeId);
    String userEmailId = Provider.of<UserProvider>(context).userEmailId;
    return InkWell(
      onTap: () async {
        await FireStore.toggleFavorite(isFavorite, userEmailId, widget.storeId.toString());
        _initializeData();
        await CudiProvider.getFavorites(context, userEmailId);
      },
      child: (widget.isColumn!=null && widget.isColumn == true)
          ?  Column(
        children: [
          SizedBox(
            width: 32.w,
            height: 32.h,
            child: Image.asset(
              isFavorite
                  ? 'assets/icon/heart.png'
                  : 'assets/icon/heart_o.png',
            ),
          ),
          const SizedBox(height: 4.0,),
          Text(storeFav.toString(),
            style: w500.copyWith(color: Colors.white),
          ),
        ],
      )
          : Row(
        children: [
          SizedBox(
            width: (widget.isPlain != null && widget.isPlain == true) ? 24.w: 32.w,
            height: (widget.isPlain != null && widget.isPlain == true) ? 24.h : 32.h,
            child: widget.isPlain ?? false
                ? SvgPicture.asset(
              isFavorite
                  ? 'assets/icon/ico-line-heart-black-on.svg'
                  : 'assets/icon/ico-line-heart-black.svg',
            )
                : Image.asset(
              isFavorite
                  ? 'assets/icon/heart.png'
                  : 'assets/icon/heart_o.png',
            ),
          ),
          const SizedBox(width: 8.0,),
          Text(storeFav.toString(),
            style: w500.copyWith(color: widget.isPlain ?? false ? black: Colors.white),
          ),
        ],
      ),
    );
  }
}
