import 'package:CUDI/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/enum.dart';
import '../../utils/provider.dart';
import '../../widgets/etc/cudi_widgets.dart';
import '../../widgets/main_stores.dart';
import '../../widgets/sheets/three_d_detail_bottom_sheet_opend.dart';
import '../../widgets/sheets/three_d_local_bottom_sheet_opend.dart';

class ThreeDScreen extends StatefulWidget {
  final String? userEmailId;

  const ThreeDScreen({super.key, this.userEmailId});

  @override
  State<ThreeDScreen> createState() => _ThreeDScreenState();
}

class _ThreeDScreenState extends State<ThreeDScreen> {
  Set<Enum> filters = {}; // TagFilter를 가진 세트 변수
  Set<String> koreanLabels = {}; // 한글라벨을 가진 세트 변수
  String selectedTagLabel = '상세정보';
  String selectedLocationLabel = '지역';
  List<String> threeDHorizonListItem = [];
  List<Widget> threeDHorizonListItem2 = [
    const ThreeDLocalBottomSheetOpened(),
    const ThreeDDetailBottomSheetOpened()
  ];
  List<Color> threeDHorizonListItem3 = [];
  List<Color> threeDHorizonListItem4 = [];
  @override
  Widget build(BuildContext context) {
    filters = Provider.of<SelectedTagProvider>(context)
        .filters; // 셋타입의 변수(괄호는 {}이나, 리스트 형식 (중복을 허용하지 않는 고유값이 필요할 때 쓴다))
    koreanLabels = Provider.of<SelectedTagProvider>(context).koreanLabels;
    if (filters.whereType<TagFilter>().length > 1) {
      selectedTagLabel = '${filters.whereType<TagFilter>().map((e) => koreanLabels.elementAt(filters.toList().indexOf(e))).toList().first} 외 ${filters.whereType<TagFilter>().length-1}개';
    } else if (filters.whereType<TagFilter>().length == 1) {
      selectedTagLabel = filters.whereType<TagFilter>().map((e) => koreanLabels.elementAt(filters.toList().indexOf(e))).toList().first;
    } else {
      selectedTagLabel = '상세정보';
    }
    if (filters.whereType<TagFilterLocalLocations>().isNotEmpty){
      selectedLocationLabel = filters.whereType<TagFilterLocalLocations>().map((e) => koreanLabels.elementAt(filters.toList().indexOf(e))).toList().first;
    } else {
      selectedLocationLabel = '지역';
    }
    threeDHorizonListItem = [selectedLocationLabel, selectedTagLabel];
    threeDHorizonListItem3 = [
      filters.whereType<TagFilterLocalLocations>().isNotEmpty ? primary : black,
      filters.whereType<TagFilter>().isNotEmpty ? primary : black,
    ];
    threeDHorizonListItem4 = [
      filters.whereType<TagFilterLocalLocations>().isNotEmpty ? Colors.transparent : gray80,
      filters.whereType<TagFilter>().isNotEmpty ? Colors.transparent : gray80,
    ];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context, title: '3D 카페 투어', isGoHome: true),
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      threeDHorizonList(),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        height: 1900.0,
                        child: MainStores(
                            userEmailId: widget.userEmailId,
                            whatScreen: "three_d"),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget threeDHorizonList() {
    return SizedBox(
      height: 40.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: threeDHorizonListItem.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: black,
                      builder: (context) {
                        return threeDHorizonListItem2[index];
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: threeDHorizonListItem3[index],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 12.0),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: threeDHorizonListItem4[index], width: 1.0)),
                  ),
                  child: Text(
                    threeDHorizonListItem[index],
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: white,
                        height: 1.0),
                  )),
            );
          }),
    );
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    filters.clear();
  }
}
