import 'package:demo_movies_app/data/services/firebase_services/firebase_services.dart';
import 'package:demo_movies_app/data/storage/pref.dart';
import 'package:demo_movies_app/views/auth/login/view_model/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel() : super(const LoginState());

  // set function
  void setEmail(String? value) {
    if (!mounted) return;
    state = state.copyWith(email: value);
  }

  void setPassword(String? value) {
    if (!mounted) return;
    state = state.copyWith(password: value);
  }

  /// login
  Future<User?> login() async {
    try {
      var userCredential = await FirebaseServices.signInWithEmailPassword(
        email: state.email ?? '',
        password: state.password ?? '',
      );
      var user = userCredential.user;
      var userInfo = await FirebaseServices.getUserInfo(user?.uid ?? '');
      Storage.user = userInfo;
      return user;
    } catch (_) {
      rethrow;
    }
  }
}

final loginViewModel = StateNotifierProvider<LoginViewModel, LoginState>((ref) => LoginViewModel());
