import 'package:CUDI/screens/details/menu_screen.dart';
import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../models/store_category.dart';
import '../etc/cudi_buttons.dart';
import '../etc/cudi_widgets.dart';

class NotifBottomSheetOpened extends StatefulWidget {
   const NotifBottomSheetOpened({super.key});

  @override
  State<NotifBottomSheetOpened> createState() => _NotifBottomSheetOpenedState();
}

class _NotifBottomSheetOpenedState extends State<NotifBottomSheetOpened> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      height: MediaQuery.of(context).size.height - 150.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 35.0,
                    color: black,
                  )),
              const Text(
                '새로운 알림',
                style: TextStyle(
                    fontSize: 25.0, color: black, fontWeight: FontWeight.w800),
              )
            ]),
            const Divider(),
            mainNotifiHorizonList(),
            Flexible(
              child: const SizedBox(
                height: 420.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '앗! 새로운 알림이 없어요.',
                      style: TextStyle(
                          color: black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      '알림이 생기면 바로 알려드릴게요.',
                      style:
                      TextStyle(color: black, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> notifiCategories = ['All', 'CUPAY', '쿠폰', '광고'];
  List<bool> isnotifiCategorieSelected = [true, false, false, false];
  Widget mainNotifiHorizonList() {
    return SizedBox(
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: notifiCategories.length,
          itemBuilder: (context, index) {
            return cudiNotifiHorizonListButton(notifiCategories[index], () {
              setState(() {
                for (int i = 0; i < isnotifiCategorieSelected.length; i++) {
                  isnotifiCategorieSelected[i] = (i == index);
                }
              });
            }, isnotifiCategorieSelected[index]);
          }),
    );
  }
}