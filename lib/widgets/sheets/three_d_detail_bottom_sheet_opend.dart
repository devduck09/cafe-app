import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../config/theme.dart';
import '../../utils/enum.dart';
import '../../utils/provider.dart';
import '../etc/cudi_buttons.dart';
import '../etc/cudi_widgets.dart';

class ThreeDDetailBottomSheetOpened extends StatefulWidget {
  const ThreeDDetailBottomSheetOpened({super.key});

  @override
  State<ThreeDDetailBottomSheetOpened> createState() =>
      _ThreeDDetailBottomSheetOpenedState();
}

class _ThreeDDetailBottomSheetOpenedState extends State<ThreeDDetailBottomSheetOpened> {
  @override
  Widget build(BuildContext context) {
    Set<Enum> filters = Provider.of<SelectedTagProvider>(context).filters; // 셋타입의 변수(괄호는 {}이나, 리스트 형식 (중복을 허용하지 않는 고유값이 필요할 때 쓴다))
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.bottom + 54.0.h + 88.0.h),
        child: Column(
          children: [
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewPadding.bottom + MediaQuery.of(context).viewInsets.bottom + 54.0.h + 72.h + 0.8),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    color: Colors.white),
                child: Column(
                  children: [
                    customDivider(),
                    customSheetAppBar('상세정보'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 5.0),
                        Wrap(
                          spacing: 5.0,
                          children: TagFilter.values.map((TagFilter tag) {
                            return FilterChip(
                              backgroundColor: white,
                              checkmarkColor: primary,
                              // selectedColor: primary,
                              label: Text(tagFilterLabels[tag].toString(), style: TextStyle(color: Colors.grey[800])),
                              elevation: 3.0,
                              pressElevation: 2.0,
                              color: MaterialStateProperty.resolveWith((states) {
                                // 예시: 선택된 상태에 따라 다른 색상 반환
                                if (states.contains(MaterialState.selected)) {
                                  // 선택된 상태일 때의 색상
                                  return white;
                                } else {
                                  // 선택되지 않은 상태일 때의 색상
                                  return white;
                                }
                              }),
                              selected: filters.contains(tag),
                              onSelected: (bool selected) {
                                var selectedTagProvider = Provider.of<SelectedTagProvider>(context, listen: false);
                                selectedTagProvider.toggleFilter(tag);
                              },
                            );
                          }).toList(),
                        )

                        // const SizedBox(height: 10.0),
                        // Text(
                        //   'Looking for: ${filters.map((TagFilter e) => tagFilterLabels[e]!).join(', ')}',
                        //   style: TextStyle(color: Colors.black), // 'black' 대신 Colors.black 사용
                        // ),
                        // Text(filters.toString(), style: TextStyle(color: Colors.blue),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            bottomButton(),
          ],
        ),
      ),
    );
  }

  Widget customSheetAppBar(String title) {
    return SizedBox(
      width: 390.0,
      height: 56.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: black),
            ),
          ),
          Text(title,
              style: TextStyle(
                  color: black,
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.1)),
          SizedBox(width: 40.w)
        ],
      ),
    );
  }

  Widget bottomButton(){
    return Padding(
      padding: EdgeInsets.fromLTRB(24.0, 16.0.h, 24.0, 0),
      child: Row(
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.refresh_rounded, size: 30.0,)),
          const SizedBox(width: 20.0),
          Flexible(child: whiteButton('적용하기', null, () {
            Navigator.pop(context);
          }))
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
