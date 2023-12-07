import 'package:CUDI/config/theme.dart';
import 'package:CUDI/widgets/etc/cudi_util_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../models/store.dart';
import '../../utils/firebase_firestore.dart';
import '../../utils/provider.dart';
import '../../widgets/etc/cudi_widgets.dart';
import '../../widgets/haert_icon.dart';

class FavoriteScreen extends StatefulWidget {
  final String? userEmailId;

  const FavoriteScreen({Key? key, this.userEmailId}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  double deviceRatio = 3.0;
  @override
  Widget build(BuildContext context) {
    deviceRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context, title: '찜한 카페', isGoHome: true),
            SliverList(
              delegate: SliverChildListDelegate([
                favoriteStores.length == 0
                    ?  noContent(context, 'assets/images/img-emptystate-heartlist.png', 131.0, 136.0, '아직 찜한 카페가 없어요!', '자주 찾는 카페를 찜 해보세요', '카페 둘러보기')
                    : Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: gridView(),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridView(){
    return GridView.count(
      crossAxisCount: 2, // 가로 개수
      crossAxisSpacing: 20.0,
      childAspectRatio: deviceRatio >= 2.5 ? 0.5 : 0.4, // 비율 (세로 간격 조절됨)
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(favoriteStores.length, (index) {
        final store = favoriteStores[index];
        bool isFavorite =
        favoriteStoresMap.containsKey(store.storeId);
        textFavoriteDescActions = List.generate(
            favoriteStores.length,
                (index) => () {
              FireStore.updateFavorite(
                  widget.userEmailId,
                  store.storeId,
                  textFavoriteDescControllers[index].text,
                  Timestamp.fromDate(DateTime.now()));
              snackBar(context, '저장되었습니다', margin: 0);
              focusNodes[index].unfocus();
            });
        return gridItem(store, isFavorite, index);
      }),
    );
  }

  Widget gridItem(Store store, bool isFavorite, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        stack(store, isFavorite),
        SizedBox(height: 16.0.h),
        favoriteStoreName(store),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textField(store, index),
            submitButton(index),
          ],
        ),
      ],
    );
  }

  Widget stack(Store store, bool isFavorite) {
    UserProvider userProvider = context.read<UserProvider>();
    return InkWell(
      onTap: () => userProvider.goViewCafeScreen(context, store),
      child: Stack(
        children: [
          Image.network(store.storeImageUrl.toString(),
              fit: BoxFit.cover, height: 214.0),
          Positioned(
            right: 8.0,
            bottom: 48.0,
            child: HeartIcon(storeId: store.storeId, isPlain: false, isColumn: true,),
          ),
          Positioned(
            bottom: 8.0,
            right: 8.0,
            child: SizedBox(
              width: 32.0,
              height: 32.0,
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, "/web_view",
                    arguments: {
                      "threeDUrl": store.storeThreeDUrl.toString()
                    }),
                icon: Image.asset('assets/icon/view_3d.png'),
                constraints: const BoxConstraints(), // 아이콘 패딩 제거
                padding: const EdgeInsets.all(0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget favoriteStoreName(Store store) {
    return Text(store.storeName.toString(),
        style:
        TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis));
  }

  Widget textField(Store store, int index) {
    return Flexible(
      child: SizedBox(
        width: 122.5,
        child: TextField(
          controller: textFavoriteDescControllers[index],
          focusNode: focusNodes[index],
          // onTapOutside: (_) => print('tos: ${_}'),
          // onSubmitted: (_) => print('osm: ${_}'),
          // onEditingComplete: () => print('oec: '),
          style: TextStyle(color: grayB5, fontSize: 14.0.sp),
          cursorColor: grayB5,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            isDense: true,
            constraints:
            BoxConstraints(maxHeight: 24.0.h, minHeight: 24.0.h),
            hintText: favoriteStoresMap[store.storeId]["description"] == ''
                ? ' 별명을 입력해주세요'
                : favoriteStoresMap[store.storeId]["description"],
            hintStyle: const TextStyle(color: grayB5),
            // suffixIconConstraints: BoxConstraints(maxHeight: 24.0.h),
            contentPadding: EdgeInsets.zero,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none, // 밑줄 색상 설정
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: grayB5), // 밑줄 색상 설정
            ),
          ),
        ),
      ),
    );
  }

  Widget submitButton (int index) {
    return GestureDetector(
        onTap: textFavoriteDescActions[index],
        child: SvgPicture.asset('assets/icon/Icon-Line-45.svg'));
  }



  // 파이어베이스 데이터
  late List<Store> favoriteStores = [];
  late Map<String, dynamic> favoriteStoresMap = {};
  // 인풋 컨트롤러들 생성
  List<TextEditingController> textFavoriteDescControllers = [];
  List<Function()> textFavoriteDescActions = [];
  // FocusNode 생성
  List<FocusNode> focusNodes = [];


  // 파이어베이스 데이터
  void _initializeData() async {
    if (mounted) {
      List<Store> data = await FireStore.getFavoriteStores(widget.userEmailId);
      Map<String, dynamic> data2 =
      await FireStore.getFavoriteMap(widget.userEmailId);
      setState(() {
        favoriteStores = data;
        favoriteStoresMap = data2;
        textFavoriteDescControllers = List.generate(
            favoriteStores.length, (index) => TextEditingController());
        focusNodes = List.generate(favoriteStores.length, (index) => FocusNode());

      });
    }
  }

  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  @override
  void dispose() {
    // 컨트롤러들 dispose
    for (var controller in textFavoriteDescControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
