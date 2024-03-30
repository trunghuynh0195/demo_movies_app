import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:demo_movies_app/data/models/user.dart' as user_model;
import 'package:demo_movies_app/data/services/firebase_services/firebase_services.dart';
import 'package:demo_movies_app/views/auth/register/view_model/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterViewModel extends StateNotifier<RegisterState> {
  RegisterViewModel() : super(const RegisterState());

  // raw data
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  /// sign up
  Future<void> signUp() async {
    try {
      var user = await createUserWithEmailAndPassword();
      await addUserInfo(user.user?.uid ?? '');
    } catch (_) {
      rethrow;
    }
  }

  ///
  Future<UserCredential> createUserWithEmailAndPassword() async {
    try {
      return await FirebaseServices.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (_) {
      rethrow;
    }
  }

  ///
  Future<void> addUserInfo(String userId) async {
    try {
      var userUpdated = user_model.User(
        id: userId,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        gender: genderController.text,
        birthday: birthdayController.text,
      );
      await FirebaseServices.addUserInfo(userUpdated);
    } catch (_) {
      rethrow;
    }
  }

  ///
  void handleConfirmPassword() {
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    if (password != confirmPassword) throw Exception(AppStrings.passwordConfirmDoesNotMatch);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    genderController.dispose();
    birthdayController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}

final registerViewModel = StateNotifierProvider<RegisterViewModel, RegisterState>((ref) => RegisterViewModel());
