import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_movies_app/core/utils/app_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo_movies_app/data/models/user.dart' as user_model;
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  static final FirebaseAuth _authInstance = FirebaseAuth.instance;
  static final FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorageInstance = FirebaseStorage.instance;

  /// firebase sign up with email and password
  static Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {
      rethrow;
    }
  }

  /// firebase sign in with email and password
  static Future<UserCredential> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {
      rethrow;
    }
  }

  /// firebase sign out
  static Future<void> signOut() async {
    try {
      await _authInstance.signOut();
    } catch (_) {
      rethrow;
    }
  }

  /// get user info
  static Future<user_model.User?> getUserInfo(String userId) async {
    try {
      var response = await _firebaseFirestoreInstance.collection(AppConstant.usersColectionPath).doc(userId).get();
      var data = response.data();
      return data == null ? null : user_model.User.fromJson(data);
    } catch (_) {
      rethrow;
    }
  }

  /// add user
  static Future<void> addUserInfo(user_model.User user) async {
    try {
      if ((user.id ?? '').isEmpty) throw Exception('user id is empty!');
      await _firebaseFirestoreInstance.collection(AppConstant.usersColectionPath).doc(user.id).set(user.toJson());
    } catch (_) {
      rethrow;
    }
  }

  /// update user
  static Future<void> updateUserInfo(user_model.User user) async {
    try {
      await _firebaseFirestoreInstance.collection(AppConstant.usersColectionPath).doc(user.id).update(user.toJson());
    } catch (_) {
      rethrow;
    }
  }

  /// upload image
  static Future<String> uploadImage(String path) async {
    try {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      var refImage = _firebaseStorageInstance.ref().child(AppConstant.imagesFirebaseStoragePath).child(uniqueFileName);
      await refImage.putFile(File(path));
      String url = await refImage.getDownloadURL();
      return url;
    } catch (_) {
      rethrow;
    }
  }
}
