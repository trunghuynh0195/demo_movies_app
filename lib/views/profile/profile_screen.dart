import 'dart:typed_data';

import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/routes/app_screens.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:demo_movies_app/core/utils/base_circle_avatar.dart';
import 'package:demo_movies_app/core/utils/base_circular_progress_indicator.dart';
import 'package:demo_movies_app/core/utils/helpers/dialog_helper.dart';
import 'package:demo_movies_app/core/utils/helpers/popups_helper.dart';
import 'package:demo_movies_app/core/widgets/widgets.dart';
import 'package:demo_movies_app/data/providers/app_system/app_system.dart';
import 'package:demo_movies_app/data/storage/storage.dart';
import 'package:demo_movies_app/views/profile/view_model/profile_view_model.dart';
import 'package:demo_movies_app/views/profile/widgets/profile_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final ProfileViewModel _profileVM;

  @override
  void initState() {
    super.initState();
    _profileVM = ref.read(profileViewModel.notifier);
    _profileVM.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        surfaceTintColor: AppColors.backgroundDark,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildAvatar(),
                      const SizedBox(height: 50),
                      ProfileFieldWidget(
                        title: AppStrings.yourName,
                        controller: _profileVM.nameController,
                      ),
                      const SizedBox(height: 40),
                      ProfileFieldWidget(
                        title: AppStrings.email,
                        controller: _profileVM.emailController,
                      ),
                      const SizedBox(height: 40),
                      ProfileFieldWidget(
                        title: AppStrings.yourPhone,
                        controller: _profileVM.phoneController,
                      ),
                      const SizedBox(height: 40),
                      ProfileFieldWidget(
                        title: AppStrings.gender,
                        controller: _profileVM.genderController,
                      ),
                      const SizedBox(height: 40),
                      ProfileFieldWidget(
                        title: AppStrings.yourBirthday,
                        controller: _profileVM.birthdayController,
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AppButton(
                onPressed: _onUpdateUserInfo,
                label: AppStrings.update,
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Consumer(
          builder: (_, ref, child) {
            var image = ref.watch(profileViewModel.select((state) => state.imagePicker));

            if (image != null) {
              return SizedBox(
                height: 140,
                width: 140,
                child: FutureBuilder<Uint8List>(
                  future: image.readAsBytes(),
                  builder: (_, snapshot) {
                    var data = snapshot.data;

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const BaseCircularProgressIndicator();
                    }
                    return CircleAvatar(
                      backgroundImage: MemoryImage(data ?? Uint8List(0)),
                    );
                  },
                ),
              );
            }
            return BaseCircleAvatar(
              imageUrl: Storage.user?.avatar ?? '',
              name: Storage.user?.name ?? '',
              height: 140,
              width: 140,
            );
          },
        ),
        Positioned(
          right: 12,
          bottom: -2,
          child: GestureDetector(
            onTap: _profileVM.pickImage,
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                color: AppColors.onBackgroundDark,
              ),
              child: const FittedBox(child: Icon(Icons.camera_enhance)),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onUpdateUserInfo() async {
    var appSystem = ref.read(appSystemProvider.notifier);
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    try {
      appSystem.setLoading(true);
      await _profileVM.updateUserInfo();
      if (mounted) PopupsHelper.showSnackBar(context, AppStrings.successfullyUpdated);
    } on Exception catch (error) {
      if (mounted) PopupsHelper.showSnackBar(context, error.message);
    } finally {
      appSystem.setLoading(false);
    }
  }

  Future<void> _signOut() async {
    var appSystem = ref.read(appSystemProvider.notifier);
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    try {
      bool isLogout = await DialogHelper.showConfirmDialog(
        context,
        title: AppStrings.signOut,
        content: AppStrings.confirmSignOut,
      );
      if (isLogout && mounted) {
        appSystem.setLoading(true);
        await _profileVM.signOut();
        if (mounted) context.goNamed(AppScreens.login.getName);
      }
    } on Exception catch (error) {
      if (mounted) PopupsHelper.showSnackBar(context, error.message);
    } finally {
      appSystem.setLoading(false);
    }
  }
}
