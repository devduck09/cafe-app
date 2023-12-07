import 'dart:convert';
import 'package:CUDI/models/order.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/utils/toss/components.dart';
import 'package:CUDI/widgets/etc/cudi_checkboxes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme.dart';
import '../../utils/enum.dart';
import '../etc/cudi_buttons.dart';
import '../etc/cudi_util_widgets.dart';
import '../etc/cudi_widgets.dart';
import 'full_with_button_sheet.dart';
import 'order_term_full_bottom_sheet.dart';

import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

import 'package:http/http.dart' as http;

class OrderTermsBottomSheet extends StatefulWidget {
  final int orderAmount;

  const OrderTermsBottomSheet({Key? key, required this.orderAmount})
      : super(key: key);

  @override
  State<OrderTermsBottomSheet> createState() => _OrderTermsBottomSheetState();
}

class _OrderTermsBottomSheetState extends State<OrderTermsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 284.h + 72.h + 83.h + 5 + 15, // 시트 + 총결제금액 + 버튼
        child: Column(
          children: [
            Container(
              height: 284.h + 5,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  color: white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    customDivider(),
                    checkAll(),
                    const Divider(height: 1.0, color: grayEA),
                    checkList()
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

  bool isCheckAll = true;
  List<bool> isChecks = [
    true,
    true,
    true,
  ];
  List<String> agreementTexts = [
    '주문 목록에 대한 동의',
    '현금영수증 발급 정보 수집에 대한 동의',
    '개인정보 수집 및 이용에 대한 동의',
  ];
  List<String> terms = [
    'Lorem ipsum dolor sit amet consectetur. Dolor ut nisl risus turpis. Fusce quis dictum eget semper semper. Nec erat massa consequat ullamcorper nec. Augue diam interdum a at scelerisque mollis morbi. Ac id habitant hendrerit orci lectus ornare sit id. Volutpat tellus pharetra tempus dolor. Diam gravida turpis amet aliquam gravida egestas porta a varius. Elit amet eu lobortis pulvinar duis. Arcu condimentum consectetur duis euismod amet volutpat amet ut tortor. Nulla eget tellus nulla in tellus. Cras aliquet et in pretium cursus euismod interdum. Volutpat tincidunt mattis sagittis tristique interdum ac purus sollicitudin. Varius proin duis blandit at hac. Facilisi est ut erat pharetra et a. Eu leo iaculis porta massa sagittis fermentum. Ipsum porta mauris sem pharetra nec. Non consectetur odio habitant semper amet amet imperdiet neque erat. Dictum id at at sapien. Sit vitae sit tincidunt egestas. Amet arcu quis odio amet nulla. Varius in tempus dignissim ullamcorper. Lorem lectus in amet ut mauris. Turpis massa est magnis at eu commodo at a. Senectus gravida placerat scelerisque blandit elit congue sit morbi eget. Turpis leo lectus dictumst nunc metus. Convallis ut morbi in facilisi suspendisse. Pellentesque metus vitae aenean odio integer ut nisl. ',
  ];

  Widget checkAll() {
    return SizedBox(
      height: 68.h,
      child: Row(
        children: [
          cudiAllCheckBox(value: isCheckAll, onChange: (_) {
            setState(() {
              isCheckAll = !isCheckAll;
              isChecks =
                  List<bool>.generate(isChecks.length, (index) => isCheckAll);
            });
          }),
          Text(' 전체 동의하기', style: s16w500.copyWith(color: black))
        ],
      ),
    );
  }

  Widget checkList() {
    return SizedBox(
      height: 180.h,
      child: Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: Container(
          child: Column(
            children: [
              for (String agreementText in agreementTexts)
                checkRow(agreementText),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkRow(String agreementText) {
    TextStyle style =
        TextStyle(fontSize: 12.sp, decoration: TextDecoration.underline);
    int index = agreementTexts.indexOf(agreementText);
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          cudiTransparentCheckBox(isChecks[index], (bool? value) {
            setState(() {
              isChecks[index] = value ?? false;
              isCheckAll = isChecks.every((value) => value);
            });
          }),
          InkWell(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                shape: Border.all(),
                builder: (BuildContext context) {
                  return OrderTermFullBottomSheet(
                    title: agreementText,
                    term: terms[0],
                  );
                },
              );
            },
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: '[필수] ', style: style.copyWith(color: error)),
                  TextSpan(
                      text: agreementText,
                      style: style.copyWith(color: gray58)),
                  TextSpan(
                      text: '(자세히)',
                      style: style.copyWith(
                          color: gray58, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomButton() {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 12.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('총 결제 금액',
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.w700)),
                priceText(
                    price: widget.orderAmount,
                    style: TextStyle(
                        fontSize: 24.sp, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 20.h),
            child: whiteButton('결제하기', null, () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => const TosspaymentsSampleHome(title: 'ex title')));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PaymentWidgetExamplePage()));
              // showSheet(context, const PaymentWidgetExamplePage());
            }),
          ),
        ],
      ),
    );
  }
}

class PaymentWidgetExamplePage extends StatefulWidget {
  const PaymentWidgetExamplePage({super.key});

  @override
  State<PaymentWidgetExamplePage> createState() {
    return _PaymentWidgetExamplePageState();
  }
}

class _PaymentWidgetExamplePageState extends State<PaymentWidgetExamplePage> {
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;
  late OrderData od;

  @override
  void initState() {
    super.initState();
    od = UserProvider
        .of(context)
        .currentOD;
    _paymentWidget = PaymentWidget(
        clientKey: dotenv.env['API_TOKEN'] ?? '',
        customerKey: od.userEmailId.toString(),
        paymentWidgetOptions:
        PaymentWidgetOptions(brandPayOption: BrandPayOption("http://")));
    _paymentWidget
        .renderPaymentMethods(
        options: RenderPaymentMethodsOptions(variantKey: "BRANDPAY"),
        selector: 'methods',
        amount: Amount(
            value: num.parse('${od.orderAmount}'),
            currency: Currency.KRW,
            country: "KR"))
        .then((control) {
      _paymentMethodWidgetControl = control;
    });
    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // 기기 하단 디스플레이 컬러
      statusBarColor: Colors.transparent, // 상태 바
      statusBarIconBrightness: Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // 시스템 UI가 화면 가장자리로 이동하여 화면의 실제 내용이 상태 바와 네비게이션 바의 아래까지 확장됨
    // 이 코드를 사용하면 앱이 화면의 가장자리까지 확장되어 시스템 바가 투명하게 표시되는 효과를 얻을 수 있습니다.
    // 이는 전체 화면을 활용하고 사용자에게 더 immersive한 경험을 제공하는 데 도움이 됩니다.
    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
            child: Column(children: [
              Expanded(
                  child: ListView(children: [
                    // FilledButton(onPressed: (){
                    //   // debugPrint('${od.toFirestore().entries.}');
                    //   debugPrint('${od.toFirestore().entries.map((entry) => '${entry.key}: ${entry.value}').join(', ')}');
                    //   // debugPrint(jsonEncode(od.toFirestore()));
                    // }, child: Text('wer')),
                    // Text('${od.toFirestore().entries}'),
                    PaymentMethodWidget(
                      paymentWidget: _paymentWidget,
                      selector: 'methods',
                    ),
                    AgreementWidget(
                        paymentWidget: _paymentWidget, selector: 'agreement'),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: BlueButton(
                          onPressed: () async {
                            Widget button() {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(
                                    24.w, 20.h, 24.w, 0),
                                child: whiteButton('확인', null, () {}),
                              );
                            }
                            final paymentResult = await _paymentWidget.requestPayment(
                                paymentInfo: PaymentInfo(
                                    orderId: od.orderId.toString(),
                                    orderName: od.orderName.toString(),
                                    customerName: "쿠디 고객"));
                            if (paymentResult.success != null) {
                              // 결제 성공 처리
                              // 결제 승인 API 호출
                              int code = await paymentApprovalAPI(paymentResult.success);
                              if(code == 200) {
                                showSheet(context,
                                    FullWithButtonSheet(title: '결제완료',
                                        body: body(
                                            isSmail: paymentResult.success != null && code == 200,
                                            od: od,
                                            paymentResult: paymentResult),
                                        button: button()));
                              } else {
                                showSheet(context,
                                    FullWithButtonSheet(title: '결제실패',
                                        body: body(
                                            isSmail: code == 200,
                                            od: od,
                                            paymentResult: paymentResult),
                                        button: button()));
                              }
                            } else if (paymentResult.fail != null) {
                              // 결제 실패 처리
                              showSheet(context,
                                  FullWithButtonSheet(title: '결제실패',
                                      body: body(
                                          isSmail: paymentResult.success != null,
                                          od: od,
                                          paymentResult: paymentResult),
                                      button: button()));
                            }
                          },
                          text: '결제하기'),
                    ),
                  ]))
            ])));
  }

  Future<int> paymentApprovalAPI(success) async {
    // 요청 헤더 및 바디 데이터 설정
    Map<String, String> headers = {
      'Authorization':
      'Basic dGVzdF9za19tYTYwUlpibHJxUmdCem9qTWI3ejh3ellXQm4xOg==',
      'Content-Type': 'application/json',
    };
    Map<String, dynamic> body = {
      'amount': success.amount,
      'orderId': success.orderId,
      'paymentKey': success.paymentKey,
    };

    String url = 'https://api.tosspayments.com/v1/payments/confirm';

    // HTTP POST 요청 보내기
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    // 응답 확인
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode;
  }
}

Widget body({required bool isSmail, paymentResult, required OrderData od}) {
  List titleList = [
    '방문시간',
    '총 메뉴 수',
    '주문내역',
    '주문금액',
    '결제금액',
    '결제수단',
    '승인일시'
  ];
  List dataList = [
    od.visitingTime,
    od.menuQuantity,
    od.orderName,
    paymentResult.success?.amount,
    od.orderAmount,
    (od.payment == Payment.cupay ? 'CUPAY' : '카드결제'),
    '${od.timestamp?.toDate().year}년 ${od.timestamp?.toDate().month}월 ${od.timestamp?.toDate().day}일'
  ];
  List<String> noticeTextList = [
  '∙ 주문내역과 결제내용 확인 후 재시도 해보시길 바랍니다.',
  '∙ 지속적으로 결제 실패할 경우 고객센터로 문의 부탁드립니다.'
  ];
  return Column(
    children: [
      SizedBox(height: 24.h),
      circleBeany(isSmail: isSmail, size: 96),
      SizedBox(height: 16.h),
      Column(
        children: [
          Text(isSmail ? '결제 완료되었습니다!' : '주문 결제가 취소되었습니다.',
              style: s20w600.copyWith(color: black)),
          if(isSmail) Column(
            children: [
              SizedBox(height: 8.h),
              Text('예약번호: ${paymentResult.success?.orderId}',
                  style: h17.copyWith(color: gray58)),
              SizedBox(height: 8.h),
              Text(
                  '${od.visitingTime?.hour}시 ${od.visitingTime?.minute}분까지 꼭 방문해주세요!',
                  style: s12.copyWith(color: gray58)),
            ],
          ),
          SizedBox(height: 24.h),
          Divider(height: 1.h, color: grayEA),
          isSmail ? SizedBox(
            height: 300,
            child: ListView.builder(
              padding: pd24all,
              itemExtent: 38.h,
              itemCount: titleList.length,
              itemBuilder: (context, index) {
                return Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(titleList[index],
                          style: w500.copyWith(
                              color: gray58)),
                      Text('${dataList[index]}',
                          style: w500.copyWith(
                              color: black)),
                    ]);
              },
            ),
          ) : Padding(
            padding: pd24all,
            child: noticeContainer(noticeTextList),
          ),
        ],
      ),
    ],
  );
}