import 'dart:async';
import 'dart:io';

import 'package:CUDI/widgets/etc/cudi_inputs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../config/route_name.dart';
import '../models/cart.dart';
import '../models/favorite.dart';
import '../models/menu.dart';
import '../models/order.dart';
import '../models/store.dart';
import '../models/user.dart';
import '../widgets/etc/cudi_util_widgets.dart';
import 'enum.dart';
import 'firebase_firestore.dart';
import 'firebase_storage.dart';


class CudiProvider with ChangeNotifier {
  bool _isPlaying = false;
  bool _isView = false;
  Cart _cart = Cart();
  bool _isViewMore = false;

  bool get isPlaying => _isPlaying;

  bool get isView => _isView;

  Cart get cart => _cart;

  bool get isViewMore => _isViewMore;


  void setPlaying(bool isPlaying) {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void setView(bool isView) {
    _isView = !_isView;
    notifyListeners();
  }

  Future<void> setCart(Cart cart) async {
    _cart = cart;
    notifyListeners();
  }

  void setViewMore(bool isViewMore) {
    _isViewMore = !_isViewMore;
    notifyListeners();
  }

  /// 스토어
  List<Store> _stores = [];

  List<Store> get stores => _stores;

  set stores(List<Store> value) {
    _stores = value;
    notifyListeners();
  }

  static Future<void> getAndSetStores(BuildContext context, {int? index}) async {
    try {
      List<Store> stores = [];

      if (index == 0) {
        // 최근 추가된 순서
        var querySnapshot = await FirebaseFirestore.instance.collection("store").limit(10).get();
        stores = querySnapshot.docs
            .map((doc) => Store.fromFirestore(doc, null))
            .toList();
      } else if (index == 1) {
        // 찜이 많은 순서
        var querySnapshot = await FirebaseFirestore.instance.collection("favorite").orderBy("store_id", descending: true).limit(10).get();

        // Set to keep track of unique store IDs
        Set<String> addedStoreIds = Set<String>();

        // favorite 문서들을 Store로 변환하여 리스트에 추가
        for (var doc in querySnapshot.docs) {
          var storeId = doc["store_id"];

          // Check if storeId has already been added
          if (!addedStoreIds.contains(storeId)) {
            // store_id를 사용하여 store 컬렉션에서 해당 store 가져오기
            var storeSnapshot = await FirebaseFirestore.instance.collection("store").doc(storeId).get();

            if (storeSnapshot.exists) {
              // Store로 변환하여 리스트에 추가
              stores.add(Store.fromFirestore(storeSnapshot, null));

              // Add the storeId to the set to mark it as added
              addedStoreIds.add(storeId);
            }
          }
        }
      } else if (index == 2) {
        // 최근 방문한 순서
        // 구현해야 할 내용 추가
      }

      CudiProvider.of(context).stores = stores;
    } catch (e) {
      print("Error completing: $e");
    }
  }

  static CudiProvider of(BuildContext context) =>
      context.read<CudiProvider>();

  /// 찜
  List<Favorite> _favorites = [];

  List<Favorite> get favorites => _favorites;

  set favorites(List<Favorite> value) {
    _favorites = value;
    notifyListeners();
  }

  static Future<void> getFavorites(BuildContext context, String userEmailId) async {
    try {
      var qerySnapshot =
          await FirebaseFirestore.instance.collection('favorite').where("user_email_id", isEqualTo: userEmailId).get();
      List<Favorite> favorites = qerySnapshot.docs.map((doc) => Favorite.fromFirestore(doc, null)).toList();

      CudiProvider.of(context).favorites = favorites;
      print('getFavorites complete');
    } catch (e) {
      print("Error completing: $e");
    }
  }
}


class SelectedTagProvider extends ChangeNotifier {
  Set<Enum> filters = <Enum>{}; // 선택된 필터를 저장하는 집합
  Set<String> get koreanLabels =>
      filters.map((Enum e) => tagFilterLabels[e]!).toSet();
  Set<Enum>? previousFilters; // 이전 필터를 저장하는 변수

  void toggleFilter(dynamic filter, {location}) {
    if (filters.contains(filter)) {
      filters.remove(filter);
    } else {
      filters.add(filter);
    }
    notifyListeners();
  }
}

class OrderProvider extends ChangeNotifier {
  OrderData _order = OrderData();
  OrderData get order => _order;
  Future<void> setOrderData(OrderData orderData) async {
    _order = order;
    notifyListeners();
  }
}


///
class UserProvider extends ChangeNotifier {
  static UserProvider of(BuildContext context) =>
      context.read<UserProvider>();
  String _userEmailId = '유저이메일아이디 받아오기 전';
  String get userEmailId => _userEmailId;
  Store _currentStore = Store();
  Store get currentStore => _currentStore;
  Menu _currentMenu = Menu();
  Menu get currentMenu => _currentMenu;
  OrderData _currentOD = OrderData();
  OrderData get currentOD => _currentOD;
  User _currentUser = User();
  User get currentUser => _currentUser;
  bool _isCartExist = false;
  bool get isCartExist => _isCartExist;

  Future<void> setUserEmailId(String userEmailId) async {
    _userEmailId = userEmailId;
    debugPrint('프로바이더에 유저 userEmailId 저장됨: $_userEmailId');
    notifyListeners();
  }

  Future<void> setCurrentStore(Store currentStore) async {
    _currentStore = currentStore;
    debugPrint('프로바이더에 현재 스토어의 storeId, storeName 저장됨: ${currentStore.storeId}, ${currentStore.storeName}');
    notifyListeners();
  }

  Future<void> setCurrentMenu(Menu currentMenu) async {
    _currentMenu = currentMenu;
    debugPrint('프로바이더에 현재 메뉴 저장됨: $currentMenu');
    notifyListeners();
  }

  Future<void> setCurrentOD(OrderData currentOD) async {
    _currentOD = currentOD;
    debugPrint('프로바이더에 현재 주문 저장됨: $currentOD');
    // FireStore.addOrder(_currentOD);
    notifyListeners();
  }

  Future<void> setCurrentUser(User currentUser) async {
    _currentUser = currentUser;
    debugPrint('프로바이더에 현재 유저 저장됨: $currentUser');
    notifyListeners();
  }

  Future<void> goViewCafeScreen(BuildContext context, Store store) async {
    await Provider.of<UserProvider>(context, listen: false).setCurrentStore(store);
    Navigator.pushNamed(context, RouteName.viewCafe);
  }

  void goMenuScreen(BuildContext context, Menu menu) {
    Provider.of<UserProvider>(context, listen: false).setCurrentMenu(menu);
    Navigator.pushNamed(context, RouteName.menu);
  }

  static Future<String> addToCart(BuildContext context, Cart cart) async {
    String cartId = await FireStore.addCart(context, cart);
    snackBar(context, '장바구니에 상품을 담았습니다.',
        label: '보러가기 >', click: () => Navigator.pushNamed(context, RouteName.cart));
    return cartId;
  }

  Future<void> setIsCartExist() async {
    QuerySnapshot queryRef = await FirebaseFirestore.instance.collection('user').doc(_userEmailId).collection('cart').get();
    _isCartExist = queryRef.size > 0;
    debugPrint(_isCartExist.toString());
    notifyListeners();
  }

}

/// Util Provider
class UtilProvider extends ChangeNotifier {
  bool? _isEmailValid;
  bool? _isEBeforeValid;
  bool? _isCertValid;

  bool? get isEmailValid => _isEmailValid;
  bool? get isEBeforeValid => _isEBeforeValid;
  bool? get isCertValid => _isCertValid;

  bool _isSent = false;

  bool get isSent => _isSent;

  int _countdownSeconds = 180; // 3분 카운트다운 시간 (초)
  late Timer _countdownTimer;
  String _timeText = '';
  String _certButtonTitle = '인증 번호 전송';
  String _verificationId = '';
  String _phoneNumber = '';

  int get countdownSeconds => _countdownSeconds;
  Timer get countdownTimer => _countdownTimer;
  String get timeText => _timeText;
  String get certButtonTitle => _certButtonTitle;
  String get verificationId => _verificationId;
  String get phoneNumber => _phoneNumber;

  void validateEmail(String value) {
    bool isValid = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value);
    if (value.isNotEmpty) {
      _isEmailValid = isValid;
    } else {
      _isEmailValid = null;
    }
    notifyListeners();
  }

  void validateEBefore(String value) {
    bool isValid = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value);
    if (value.isNotEmpty) {
      _isEmailValid = isValid;
    } else {
      _isEmailValid = null;
    }
    notifyListeners();
  }

  void validateCert(String value) {
    bool isValid = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value);
    if (value.isNotEmpty) {
      _isCertValid = isValid;
    } else {
      _isCertValid = null;
    }
    notifyListeners();
  }

  void setIsSent() {
    _isSent = !_isSent;
    if(_isSent == true) {
      _certButtonTitle = "인증완료";
      startCountdown();
    } else {
      _certButtonTitle = "인증 번호 전송";
    }
    notifyListeners();
  }

  Future<void> sendVerificationNumber(BuildContext context, String phoneOrEmail) async {
    if (phoneOrEmail == "폰") {
      if(_isSent == false) {
        // 인증 번호 보내기
        // 폰번호 포매팅
        _phoneNumber = '+82${phoneController.text.replaceAll(' - ', '')}';
        // 파이어베이스 인증
        auth.FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: _phoneNumber,
            // 인증 문자 전송
            codeSent: (String verificationId, int? resendToken) async {
              cudiDialog(context, '인증번호가 전송되었습니다. codeSent', '닫기');
              print(
                  'codeSent 인증 문자 전송, verificationId: $verificationId, resendToken: $resendToken');
              _verificationId = verificationId;
              // 버튼 타이틀, 함수 바꾸기, 타이머 시작
              setIsSent();
            },
            // 인증 성공
            verificationCompleted: (phoneAuthCredential) async {
              cudiDialog(context, '인증번호가 수신되었습니다. verificationCompleted', '닫기');
              print(
                  'verificationCompleted 인증 문자 수신, PhoneAuthCredential: $phoneAuthCredential');
            },
            verificationFailed: (auth.FirebaseAuthException error) {
              print('verificationFailed 인증 문자 전송 실패, error: $error');
              if (error.code == 'too-many-requests') {
                cudiDialog(context, '비정상적인 활동으로 인해 이 장치의 모든 요청을 차단했습니다. 나중에 다시 시도하세요.', '닫기');
              } else {
                cudiDialog(context, '인증번호 전송에 실패하였습니다. 다시 시도해주세요. verificationFailed', '닫기');
              }
            },
            timeout: Duration(seconds: 100),
            codeAutoRetrievalTimeout: (String verificationId) {
              cudiDialog(context, '시간이 초과되어 인증에 실패하였습니다. codeAutoRetrievalTimeout', '닫기');
              print('codeAutoRetrievalTimeout 인증 문자 시간 초과, verificationId: $verificationId');
            });
      } else {
        // 입력된 SMS 코드로 사용자를 인증
        auth.PhoneAuthCredential credential = auth.PhoneAuthProvider.credential(
            verificationId: _verificationId, smsCode: certController.text);
        auth.FirebaseAuth.instance.signInWithCredential(credential).then((authResult) {
          if (authResult.user != null) {
            // 인증이 성공한 경우
            setIsSent();
            print('사용자 인증 성공: ${authResult.user!.uid}');
            FireStore.userUpdate(context, Provider.of<UserProvider>(context, listen: false).userEmailId, phoneNumber: _phoneNumber);
            cudiCupertinoDialog(context, "휴대폰 번호 변경완료", "성공적으로 휴대폰 번호가 변경되었습니다!\n내 정보 페이지로 가시겠습니까?");
          } else {
            // 인증이 실패한 경우
            print('사용자 인증 실패');
            cudiDialog(context, '인증에 실패하였습니다. 이 문구를 볼 경우 개발자에게 수신 요망', '닫기');
          }
        }).catchError((error) {
          print('인증 오류: $error');
          if (error.code == 'session-expired') {
            // 시간 초과된 인증 번호 오류
            cudiDialog(context, 'SMS 코드가 만료되었습니다. 다시 시도하려면 인증코드를 다시 요청하세요.', '닫기');
          } else {
            // 다른 오류 처리
            cudiDialog(context, '인증에 실패하였습니다. 번호와 코드를 확인 후 시도해주세요. 에러: $error', '닫기');
          }
        });
      }
    } else {
      try {
        var emailAuth = emailController.text;
        auth.User? user = auth.FirebaseAuth.instance.currentUser;

        // 사용자가 이미 로그인되어 있지 않은 경우 로그인
        if (user == null) {
          await auth.FirebaseAuth.instance.signInAnonymously();
          user = auth.FirebaseAuth.instance.currentUser;
        }

        await user?.updateEmail(emailController.text).then((value) {
          snackBar(context, "인증 메일이 전송되었습니다. 링크를 통해 인증을 완료하면 변경된 이메일로 로그인할 수 있습니다.");
        });

        // 사용자에게 이메일 전송
        await user!.sendEmailVerification().then((value) => snackBar(context, "이메일이 전송되었습니다."));

    print('Successfully sent email verification to $emailAuth');
    } catch (error) {
    print('Error sending email verification: $error');
    }
    }
  }

  void startCountdown() {
    _countdownSeconds = 180;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countdownSeconds--;
      if (countdownSeconds <= 0) {
        // 시간이 종료되면 타이머를 멈춥니다.
        timer.cancel();
      }
      // 시간을 분:초 형식으로 표시합니다.
      int minutes = countdownSeconds ~/ 60;
      int seconds = countdownSeconds % 60;
      _timeText = '$minutes:${seconds.toString().padLeft(2, '0')}';
      notifyListeners();
    });
  }

  bool? _isPasswordValid;
  bool? _isPWBeforeValid;
  bool? _isPWConfirmValid;
  String _message = "";

  bool? get isPasswordValid => _isPasswordValid;
  bool? get isPWBeforeValid => _isPWBeforeValid;
  bool? get isPWConfirmValid => _isPWConfirmValid;
  String get message => _message;

  void validatePassword(String value) {
    bool isValid = value.length >= 6;
    bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    if (value.isNotEmpty) {
      _isPasswordValid = isValid;
      if (hasUpperCase) {
        _message = "Caps Lock 확인해 주세요.";
      } else {
        _message = "";
      }
    } else {
      _isPasswordValid = null;
    }
    notifyListeners();
  }

  Future<void> validatePWBefore(String value, context) async {
    bool isValid = value.length >= 6;
    // bool isBeforePW = value == Provider.of<UserProvider>(context, listen: false).currentUser.userPassword;
    bool isBeforePW = await confirmPassword(context, value) != null;
    debugPrint(isBeforePW.toString());
    bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    if (value.isNotEmpty) {
      _isPWBeforeValid = isValid && isBeforePW;
      if(isBeforePW == false) {
         _message = "이전 비밀번호가 비밀번호가 일치하지 않습니다.";
        if (hasUpperCase) {
          _message = "Caps Lock 확인해 주세요.";
        } else {
          // _message = "";
        }
      } else {
        _message = "";
      }
    } else {
      _isPWBeforeValid = null;
    }
    notifyListeners();
  }
  Future<auth.UserCredential?> confirmPassword(BuildContext context, String value) async {
    try {
      final credential = await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Provider.of<UserProvider>(context, listen: false).currentUser.userEmail.toString(),
          password: value
      );
      debugPrint(credential.toString());
      return credential;
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('출력: No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        debugPrint('출력: Wrong password provided for that user.');
        return null;
      }
    }
  }

  void validatePWConfirm(String value) {
    bool isValid = value.length >= 6;
    bool isConfirm = value == passwordController.text;
    bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    if (value.isNotEmpty) {
      _isPWConfirmValid = isValid && isConfirm;
      if(isConfirm == false) {
        _message = "비밀번호가 일치하지 않습니다.";
        if (hasUpperCase) {
          _message = "Caps Lock 확인해 주세요.";
        } else {
          // _message = "";
        }
      } else {
        _message = "";
      }
    } else {
      _isPWConfirmValid = null;
    }
    notifyListeners();
  }

  bool? _isNicknameValid;

  bool? get isNicknameValid => _isNicknameValid;

  void validateNickname(String value) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('user').where('user_nickname', isEqualTo: value).get();
    bool isValid = querySnapshot.docs.isEmpty;
    if (value.isNotEmpty) {
      _isNicknameValid = isValid;
    } else {
      _isNicknameValid = null;
    }
    notifyListeners();
  }

  bool? _isBirthValid;

  bool? get isBirthValid => _isBirthValid;

  void validateBirth(String value) async {
    bool isValid = value.length >= 6;
    if (value.isNotEmpty) {
      _isBirthValid = isValid;
    } else {
      _isBirthValid = null;
    }
    notifyListeners();
  }

  bool? _isPhoneValid;

  bool? get isPhoneValid => _isPhoneValid;

  void validatePhone(String value) async {
    bool isValid = value.length >= 11;
    if (value.isNotEmpty) {
      _isPhoneValid = isValid;
    } else {
      _isPhoneValid = null;
    }
    notifyListeners();
  }

  String _gender = "남성";
  String get gender => _gender;
  void setGender(String value) {
    _gender = value;
    notifyListeners();
  }

  List<String> _dropdownItems = <String>['오류', 'Two', 'Three', 'Four'];
  String _selectedItem = '오류';

  List<String> get dropdownItems => _dropdownItems;
  String get selectedItem => _selectedItem;

  void setSelectedItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }

  // 이미지 피커 인스턴스 생성
  final ImagePicker _picker = ImagePicker(); // 인스턴스 생성
  XFile? _pickedImage; // 고른 파일
  final List<XFile?> _pickedImages = []; // 고른 파일 여러개

  XFile? get pickedImage => _pickedImage;
  List<XFile?> get pickedImages => _pickedImages;

  void setPickImage() {
    _pickedImage = null;
    notifyListeners();
  }

  // Firebase Storage에 이미지 업로드하는 함수
  Future<void> uploadImageToFirebaseStorage(context, XFile imageFile) async {
    UserProvider userProvider = context.read<UserProvider>();
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${userProvider.userEmailId}_${DateTime.now()}.jpg'); // 원하는 대로 경로를 수정할 수 있습니다

      final UploadTask uploadTask = storageReference.putFile(
          File(imageFile.path));

      await uploadTask.whenComplete(() {
        print('이미지가 Firebase Storage에 업로드되었습니다');
      });
    } catch (e) {
      print('이미지 업로드 오류: $e');
    }
  }

  // 카메라, 갤러리에서 이미지 1개 불러오기
  // 파라미터: ImageSource.galley , ImageSource.camera
  void getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    _pickedImage = image;
    notifyListeners();
  }

  // 이미지 여러개 불러오기
  void getMultiImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
        _pickedImages.addAll(images);
    }
    notifyListeners();
  }


  Future<void> imagePickerFunction(BuildContext context, XFile imageFile) async {
    UserProvider userProvider = context.read<UserProvider>();

    // 이미지 업로드
    await uploadImageToFirebaseStorage(context, imageFile);

    // 이미지 URL 가져오기
    String? imageUrl = await getImageUrlFromFirebaseStorage(
        'images/${userProvider.userEmailId}_${DateTime.now()}.jpg');
  }

  /// Switch
  bool _pushNotification = true;
  bool _promotionEventNotifications = false;
  bool _locationBasedInformationService = true;
  bool _CUPAYNotification = false;

  bool get pushNotification => _pushNotification;
  bool get promotionEventNotifications => _promotionEventNotifications;
  bool get locationBasedInformationService => _locationBasedInformationService;
  bool get CUPAYNotification => _CUPAYNotification;

  void setSwitch(String switchName) {
    switch (switchName) {
      case 'pushNotification':
        _pushNotification = !_pushNotification;
        break;
      case 'promotionEventNotifications':
        _promotionEventNotifications = !_promotionEventNotifications;
        break;
      case 'locationBasedInformationService':
        _locationBasedInformationService = !_locationBasedInformationService;
        break;
      case 'CUPAYNotification':
        _CUPAYNotification = !_CUPAYNotification;
        break;
      default:
        throw ArgumentError('Invalid switch name: $switchName');
    }
    notifyListeners();
  }
}