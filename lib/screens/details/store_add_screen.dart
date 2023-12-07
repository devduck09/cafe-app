import 'dart:io';
import 'package:CUDI/utils/firebase_firestore.dart';
import 'package:CUDI/utils/authentication.dart';
import 'package:CUDI/widgets/etc/cudi_util_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/store.dart';
import '../../utils/firebase_storage.dart';
import '../../widgets/image_picker.dart';

class StoreAddScreen extends StatefulWidget {
  const StoreAddScreen({Key? key}) : super(key: key);

  @override
  State<StoreAddScreen> createState() => _StoreAddScreenState();
}
class _StoreAddScreenState extends State<StoreAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // AddImage(
                //   _pickedImage != null
                //       ? Image.file(File(_pickedImage!.path))
                //       : const Icon(Icons.add),
                //       () {
                //     getImage(ImageSource.gallery);
                //   },
                // ),
                Text(_pickedImage.toString()),
                Text(_pickedImage != null ? _pickedImage!.path.toString() : ""),
                storeNameInput(),
                storeDescriptionInput(),
                storeVideoUrlInput(),
                storeThreeDUrlInput(),
                storeAddressInput(),
                storeTMapInput(),
                const SizedBox(height: 20),
                storeSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  Authentication auth = Authentication();
  final TextEditingController textStoreImage = TextEditingController();
  final TextEditingController texStoreName = TextEditingController();
  final TextEditingController textStoreDescription = TextEditingController();
  final TextEditingController textStoreVideoUrl = TextEditingController();
  final TextEditingController textStoreThreeDUrl = TextEditingController();
  final TextEditingController textStoreAddress = TextEditingController();
  final TextEditingController textStoreTMap = TextEditingController();
  late String _userId;
  late String _userEmail;
  late Store store;

  // 이미지 피커 인스턴스 생성
  final ImagePicker _picker = ImagePicker(); // 인스턴스 생성
  XFile? _pickedImage; // 고른 파일

  Future<void> _initUserData() async {
    final user = await auth.getUser();
    setState(() {
      _userId = user!.uid.toString();
      _userEmail = user.email.toString();
    });
  }

  Future<void> submit(XFile imageFile) async {
    // 이미지 업로드
    await uploadImageToFirebaseStorage(imageFile);

    // 이미지 URL 가져오기
    String? imageUrl = await getImageUrlFromFirebaseStorage(
        'images/${_userId}_${texStoreName.text}_store_image.jpg');

    // 데이터 저장
    store.userId = _userId;
    store.storeImageUrl = imageUrl;
    _formKey.currentState!.save();
    FireStore.addStore(store);
    cudiDialog(context, '$_userEmail님의 카페가 등록되었습니다.', '닫기');
    // }
  }

  // 카메라, 갤러리에서 이미지 1개 불러오기
  // 파라미터: ImageSource.galley , ImageSource.camera
  void getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      _pickedImage = image;
    });
  }

  // Firebase Storage에 이미지 업로드하는 함수
  Future<void> uploadImageToFirebaseStorage(XFile imageFile) async {
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${_userId}_${texStoreName
          .text}_store_image.jpg'); // 원하는 대로 경로를 수정할 수 있습니다

      final UploadTask uploadTask = storageReference.putFile(
          File(imageFile.path));

      await uploadTask.whenComplete(() {
        print('이미지가 Firebase Storage에 업로드되었습니다');
      });
    } catch (e) {
      print('이미지 업로드 오류: $e');
    }
  }

  @override
  void initState() {
    _initUserData();
    super.initState();
  }

  @override
  void dispose() {
    textStoreImage.dispose();
    texStoreName.dispose();
    textStoreDescription.dispose();
    textStoreAddress.dispose();
    super.dispose();
  }

  Widget storeNameInput() {
    return TextFormField(
      controller: texStoreName,
      decoration: const InputDecoration(hintText: '스토어 이름'),
      onSaved: (value) => store.storeName = value!,
    );
  }

  Widget storeDescriptionInput() {
    return TextFormField(
      controller: textStoreDescription,
      decoration: const InputDecoration(hintText: '스토어 설명'),
      onSaved: (value) => store.storeDescription = value!,
    );
  }

  Widget storeVideoUrlInput() {
    return TextFormField(
      controller: textStoreVideoUrl,
      decoration: const InputDecoration(hintText: '스토어 비디오 url'),
      onSaved: (value) => store.storeVideoUrl = value,
    );
  }

  Widget storeThreeDUrlInput() {
    return TextFormField(
      controller: textStoreThreeDUrl,
      decoration: const InputDecoration(hintText: '스토어 3D url'),
      onSaved: (value) => store.storeThreeDUrl = value,
    );
  }

  Widget storeAddressInput() {
    return TextFormField(
      controller: textStoreAddress,
      decoration: const InputDecoration(hintText: '스토어 주소'),
      onSaved: (value) => store.storeAddress = value!,
    );
  }

  Widget storeTMapInput() {
    return TextFormField(
      controller: textStoreTMap,
      decoration: const InputDecoration(hintText: '스토어 Tmap'),
      onSaved: (value) => store.storeTMap = value,
    );
  }

  Widget storeSubmitButton() {
    return ElevatedButton(onPressed: () {
      submit(_pickedImage!);
    }, child: const Text('저장하기'));
  }
}