
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme.dart';
import '../../../widgets/cart_icons.dart';
import '../../../widgets/etc/cudi_buttons.dart';
import '../../../widgets/etc/cudi_checkboxes.dart';
import '../../../widgets/etc/cudi_inputs.dart';
import '../../../widgets/etc/cudi_widgets.dart';
import '../../../widgets/image_picker.dart';
import 'my_widgets.dart';

class EmailInquiryScreen extends StatefulWidget {
  final String title;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;

  const EmailInquiryScreen(
      {super.key,
      required this.title,
      this.cartIcon,
      this.padding,
      this.buttonTitle,
      this.buttonClick});

  @override
  State<EmailInquiryScreen> createState() => _EmailInquiryScreenState();
}

class _EmailInquiryScreenState extends State<EmailInquiryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: widget.title, iconButton: widget.cartIcon),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      88.h -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            widget.padding == null ? pd24h : EdgeInsets.zero,
                        child: Column(
                          children: [
                            SizedBox(height: 668.h - 83.h, child: listViewWidget()),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: pd2420247,
                        child: whiteButton(
                            '${widget.buttonTitle}', null, widget.buttonClick),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  List<String> titleList = ['문의유형', '문의내용', '사진첨부(최대 3장)', '답변 받으실 정보', ""];

  Container bottomBorderContainer(int index) {
    List<Widget> widgetList = [inquiryTypeWidget(), inquiryDetailsWidget(), attachPicturesWidget(), informationToReceiveResponse(), lastWidget()];
    return Container(
      decoration: index == widgetList.length-1 ? null: bottomBorder,
      child: Padding(padding: pd24all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleList[index] == "" ? const SizedBox.shrink() : titleWidget(title: titleList[index]),
              titleList[index] == "" ? const SizedBox.shrink() : sbh24,
              widgetList[index]
            ],
          )),
    );
  }

  ListView listViewWidget() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: titleList.length, itemBuilder: (context, index) {
      return bottomBorderContainer(index);
    });
  }

  Widget inquiryTypeWidget(){
    return filledDropDownMenu(context);
  }

  String inputHint = '제목을 입력해 주세요.';
  String inputDesc = '내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세요.(200자 이내)내용을 입력해 주세';
  Widget inquiryDetailsWidget(){
    return Column(
      children: [
        filledTextField(controller: TextEditingController(), hintText: inputHint),
        sbh24,
        filledTextField(controller: TextEditingController(), hintText: inputDesc, maxLines: 7),
      ],
    );
  }

  Widget attachPicturesWidget() {
    return Row(
      children: [
        AddImage(),
        selectdImagesWidget(context),
      ],
    );
  }

  String inputHint2 = '성함을 입력해 주세요.';
  String inputHint3 = '이메일을 입력해 주세요.';
  Widget informationToReceiveResponse() {
    return Column(
      children: [
        filledTextField(controller: TextEditingController(), hintText: inputHint2),
        sbh24,
        filledTextField(controller: TextEditingController(), hintText: inputHint3),
      ],
    );
  }

  String noticeText = '∙ 답변은 평균 7일 정도 소요됩니다. \n∙ 문의하신 답변이 완료되면 이메일로 알려드립니다.';
  Widget lastWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(noticeText, style: h19.copyWith(fontSize: 12.sp, color: gray79)),
        ),
        sbh24,
        checkboxWithTextWidget('[필수]개인정보 수집 및 이용동의(자세히)'),
      ],
    );
  }

  Widget checkboxWithTextWidget(String text) {
    return Row(
        children: [
          cudiAllCheckBox(value: true, onChange: (bool){}),
          SizedBox(width: 8.w),
          RichText(
            text: TextSpan(
              style: s12,
              children: <TextSpan>[
                TextSpan(
                  text: '[필수]',
                  style: TextStyle(
                    color: Colors.red, // 빨간색으로 설정
                  ),
                ),
                TextSpan(
                  text: '개인정보 수집 및 이용동의',
                ),
                TextSpan(
                  text: '(자세히)',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline, // 밑줄 추가
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
