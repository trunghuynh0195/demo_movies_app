import 'package:demo_movies_app/data/services/firebase_services/firebase_services.dart';
import 'package:demo_movies_app/data/storage/pref.dart';
import 'package:demo_movies_app/views/profile/view_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends StateNotifier<ProfileState> {
  ProfileViewModel() : super(const ProfileState());

  // raw data
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();

  void setImagePicker(XFile? value) {
    if (!mounted) return;
    state = state.copyWith(imagePicker: value);
  }

  void initData() {
    var user = Storage.user;
    nameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    phoneController.text = user?.phone ?? '';
    genderController.text = user?.gender ?? '';
    birthdayController.text = user?.birthday ?? '';
  }

  /// update user info
  Future<void> updateUserInfo() async {
    try {
      var user = Storage.user;
      if (user != null) {
        String url = await uploadImage();
        String avatar = url.isEmpty ? user.avatar ?? '' : url;

        var userUpdated = user.copyWith(
          name: nameController.text,
          avatar: avatar,
          email: emailController.text,
          phone: phoneController.text,
          gender: genderController.text,
          birthday: birthdayController.text,
        );

        await FirebaseServices.updateUserInfo(userUpdated);
        Storage.user = userUpdated;
        setImagePicker(null);
      }
    } catch (_) {
      rethrow;
    }
  }

  /// upload image
  Future<String> uploadImage() async {
    try {
      String path = state.imagePicker?.path ?? '';
      if (path.isEmpty) return '';
      String url = await FirebaseServices.uploadImage(path);
      return url;
    } catch (_) {
      rethrow;
    }
  }

  /// pick image
  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      await picker.retrieveLostData();
      XFile? imagePicker = await picker.pickImage(source: ImageSource.gallery);
      setImagePicker(imagePicker);
    } catch (_) {
      rethrow;
    }
  }

  /// sign out
  Future<void> signOut() async {
    try {
      await FirebaseServices.signOut();
      Storage.user = null;
      Storage.favoriteMovies = [];
    } catch (_) {
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    genderController.dispose();
    birthdayController.dispose();
  }
}

final profileViewModel = StateNotifierProvider.autoDispose<ProfileViewModel, ProfileState>((ref) => ProfileViewModel());
