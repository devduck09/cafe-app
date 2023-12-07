import 'package:firebase_storage/firebase_storage.dart';

Future<String?> getImageUrlFromFirebaseStorage(String imagePath) async {
  try {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child(imagePath);

    final String downloadURL = await storageReference.getDownloadURL();

    return downloadURL;
  } catch (e) {
    print('이미지 가져오기 오류: $e');
    return null;
  }
}
