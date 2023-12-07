import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/utils/phase.dart';
import '../screens/tosspayments_widget/widget_home.dart';

class LocalConfig {
  static UIState get uiState {
    switch (PhaseConfig.phase) {
      case Phase.live:
        return _live;
      case Phase.staging:
        return _staging;
      case Phase.dev:
        return _dev;
    }
  }

  static final UIState _live = UIState(
    // clientKey: 'test_ck_6BYq7GWPVv54JZaMpgn3NE5vbo1d',
    clientKey: dotenv.env['API_TOKEN'] ?? '',
    customerKey: 'aaaa',
    currency: Currency.KRW,
    country: "KR",
    amount: 50000,
    redirectUrl: null,
  );

  static final UIState _staging = UIState(
    // clientKey: 'live_ck_JQbgMGZzorzj0ZnKbOjrl5E1em4d',
    clientKey: dotenv.env['API_TOKEN'] ?? '',
    customerKey: 'a1b2c3',
    currency: Currency.KRW,
    country: "KR",
    amount: 50000,
    variantKeyMethod: 'BRANDPAY',
    variantKeyAgreement: 'DEFAULT',
    redirectUrl: '',
  );

  static final UIState _dev = UIState(
    // clientKey: 'test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm',
    clientKey: dotenv.env['API_TOKEN'] ?? '',
    customerKey: 'CUSTOMER_KEY',
    currency: Currency.KRW,
    country: "KR",
    amount: 50000,
    redirectUrl: null,
  );
}
