import 'dart:async'; // FirebaseAuth의 모든 메서드는 비동기이다.
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Authentication {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  // 로그인 메서드
  Future<String> login(String email, String password) async {
    // 로그인 메서드 내에서 signInWithEmailAndPassword 호출
    auth.UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    // User 객체 만들기
    auth.User? user = userCredential.user;
    return user!.uid;
  }

  // 회원가입 메서드
  Future<String> signUp(String email, String password) async {
    // 회원가입 메서드 내에서 createUserWithEmailAndPassword 호출
    auth.UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    // User 객체 만들기
    auth.User? user = userCredential.user;
    return user!.uid;
  }

  // 로그아웃 메서드
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  // 현재 사용자를 얻어오는 메서드 (로그인 했는지 여부 등에 사용)
  Future<auth.User?> getUser() async {
    auth.User? user = _firebaseAuth.currentUser;
    return user;
  }
}