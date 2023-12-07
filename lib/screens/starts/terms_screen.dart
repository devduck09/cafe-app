import 'package:CUDI/config/theme.dart';
import 'package:CUDI/screens/starts/phone_certification_screen.dart';
import 'package:CUDI/screens/starts/term_screen.dart';
import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:CUDI/widgets/etc/cudi_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/etc/cudi_logos.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: pd24h16v,
              child: cudiAppBar(context, appBarTitle: '회원가입'),
            ),
            Padding(
              padding: pd24h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  termText(),
                  termAgrees(),
                  termButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkAll = false;
  List<String> agreementTitles = [
    '서비스 이용약관에 동의',
    '만 14세 이상입니다',
    '개인정보 수집 및 이용동의',
    '마케팅 알림 수신동의',
    '위치기반 서비스 이용약관 동의',
  ];
  List<String> terms = [
    'Lorem ipsum dolor sit amet consectetur. Dolor ut nisl risus turpis. Fusce quis dictum eget semper semper. Nec erat massa consequat ullamcorper nec. Augue diam interdum a at scelerisque mollis morbi. Ac id habitant hendrerit orci lectus ornare sit id. Volutpat tellus pharetra tempus dolor. Diam gravida turpis amet aliquam gravida egestas porta a varius. Elit amet eu lobortis pulvinar duis. Arcu condimentum consectetur duis euismod amet volutpat amet ut tortor. Nulla eget tellus nulla in tellus. Cras aliquet et in pretium cursus euismod interdum. Volutpat tincidunt mattis sagittis tristique interdum ac purus sollicitudin. Varius proin duis blandit at hac. Facilisi est ut erat pharetra et a. Eu leo iaculis porta massa sagittis fermentum. Ipsum porta mauris sem pharetra nec. Non consectetur odio habitant semper amet amet imperdiet neque erat. Dictum id at at sapien. Sit vitae sit tincidunt egestas. Amet arcu quis odio amet nulla. Varius in tempus dignissim ullamcorper. Lorem lectus in amet ut mauris. Turpis massa est magnis at eu commodo at a. Senectus gravida placerat scelerisque blandit elit congue sit morbi eget. Turpis leo lectus dictumst nunc metus. Convallis ut morbi in facilisi suspendisse. Pellentesque metus vitae aenean odio integer ut nisl. ',
  ];

  List<bool> checks = [
    false,
    false,
    false,
    false,
    false,
    false
  ]; // 각 체크박스의 초기 상태

  Widget termLogo() {
    return Padding(
      padding: EdgeInsets.fromLTRB(80.w, 0, 80.w, 20.h),
      child: textLineWhiteStart(),
    );
  }

  Widget termText() {
    return Padding(
      padding: EdgeInsets.only(top: 32.0.h, bottom: 16.0.h),
      child: Text(
        '환영합니다!\n약관내용에 동의해주세요',
        style: TextStyle(
            fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.42),
      ),
    );
  }

  Widget termAgrees() {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          (MediaQuery.of(context).padding.bottom + MediaQuery.of(context).padding.top + 88.0 + 83.0 + 128.0.h),
      // 바텀 패딩,탑패딩, 앱바, 하단 버튼, 환영텍스트
      child: Column(
        children: [
          Container(
            height: 68.h,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: 1.0, color: gray3D))),
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: Checkbox(
                    value: checkAll,
                    onChanged: (bool? value) {
                      setState(() {
                        checkAll = !checkAll;
                        // 전체 동의 체크박스 상태가 변경되면 다른 체크박스도 일괄적으로 변경
                        checks = List<bool>.generate(
                            checks.length, (index) => checkAll);
                      });
                    },
                    checkColor: Colors.white,
                    side: const BorderSide(color: gray58, width: 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text('전체 동의하기', style: s16w500.copyWith(height: 1.0)),
              ],
            ),
          ),
          Column(
            children: generateListTiles(),
          )
        ],
      ),
    );
  }

  List<Widget> generateListTiles() {
    List<Widget> listTiles = [];
    for (int i = 0; i < agreementTitles.length; i++) {
      listTiles.add(
        Container(
          height: 44.h,
          padding: EdgeInsets.only(top: 24.h),
          child: Row(
            children: [
              SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: checks[i] == false
                      ? GestureDetector(
                      onTap: () {
                        setState(() {
                          checks[i] = true;
                          if (checks.every((value) => value)) {
                            setState(() {
                              // 모든 체크박스가 true 인 경우 check_all도 true로 설정
                              checkAll = true;
                            });
                          }
                        });
                      },
                      child: SvgPicture.asset(
                        'assets/icon/ico-line-check-20px.svg',
                      ))
                      : GestureDetector(
                      onTap: () {
                        setState(() {
                          checks[i] = false;
                          if (checks.every((value) => value)) {
                            setState(() {
                              // 모든 체크박스가 true 인 경우 check_all도 true로 설정
                              checkAll = true;
                            });
                          }
                        });
                      },
                      child: SvgPicture.asset(
                          'assets/icon/ico-line-check-on-20px.svg',
                          width: 20.w))),
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TermScreen(title: agreementTitles[i], term: terms[0], bgColor: black))),
                child: Row(
                  children: [
                    Text(i == 3 || i == 4 ? '[선택]' : '[필수]',
                        style: TextStyle(
                          fontSize: 12.0,
                          height: 1.0,
                          color: i == 3 || i == 4 ? white : error,
                          decoration: TextDecoration.underline,
                          decorationColor: i == 3 || i == 4 ? white : error,)),
                    Text(agreementTitles[i],
                        style: const TextStyle(
                            fontSize: 12.0,
                            height: 1.0,
                            decoration: TextDecoration.underline)),
                    const Text('(자세히)',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            height: 1.0,
                            decoration: TextDecoration.underline)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return listTiles;
  }

  Widget termButton() {
    // 모든 체크박스가 true 인지 확인
    // bool allChecked = checks.every((value) => value);
    // 체크박스 중 첫 번째와 두 번째 체크박스가 true 인지 확인
    bool firstTwoChecked =
        checks.length >= 3 && checks[0] && checks[1] && checks[2];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // child: ElevatedButton(
      //   child: Text('다음'),
      //   onPressed: firstTwoChecked ? () {
      //     // 조건의 체크박스가 true 일 때만 버튼이 활성화되며
      //     // 버튼을 클릭할 때 원하는 작업을 수행할 수 있습니다.
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneCertifiactionScreen()));
      //   } : null, // 조건의 체크박스가 true가 아니면 버튼을 비활성화합니다.
      // ),
      child: cudiBackgroundButton(
        '다음',
        firstTwoChecked
            ? () {
          // 조건의 체크박스가 true 일 때만 버튼이 활성화되며
          //     // 버튼을 클릭할 때 원하는 작업을 수행할 수 있습니다.
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhoneCertificationScreen(
                      checks: checks.sublist(3, 6))));
        }
            : null, // 조건의 체크박스가 true가 아니면 버튼을 비활성화합니다.
      ),
    );
  }
}

// checks[3~5]의 값을 저장해야 한다