import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:demo_movies_app/core/utils/helpers/popups_helper.dart';
import 'package:demo_movies_app/core/utils/utils.dart';
import 'package:demo_movies_app/core/widgets/widgets.dart';
import 'package:demo_movies_app/data/providers/app_system/app_system.dart';
import 'package:demo_movies_app/views/auth/register/view_model/register_view_model.dart';
import 'package:demo_movies_app/views/auth/register/widgets/register_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final RegisterViewModel _registerVM;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _registerVM = ref.read(registerViewModel.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        surfaceTintColor: AppColors.backgroundDark,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      AppStrings.signUp,
                      textAlign: TextAlign.center,
                      style: context.textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: AppStrings.alreadyHaveAnAccount,
                            style: context.textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: ' ${AppStrings.login}',
                            style: context.textTheme.labelLarge?.copyWith(color: AppColors.primary),
                            recognizer: TapGestureRecognizer()..onTap = context.pop,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            RegisterFieldWidget(
                              hintText: AppStrings.name,
                              controller: _registerVM.nameController,
                              validator: AppValidator.fieldEmpty,
                            ),
                            const SizedBox(height: 16),
                            RegisterFieldWidget(
                              hintText: AppStrings.email,
                              controller: _registerVM.emailController,
                              validator: AppValidator.email,
                            ),
                            const SizedBox(height: 16),
                            RegisterFieldWidget(
                              hintText: AppStrings.phone,
                              controller: _registerVM.phoneController,
                              validator: AppValidator.fieldEmpty,
                            ),
                            const SizedBox(height: 16),
                            RegisterFieldWidget(
                              hintText: AppStrings.gender,
                              controller: _registerVM.genderController,
                              validator: AppValidator.fieldEmpty,
                            ),
                            const SizedBox(height: 16),
                            RegisterFieldWidget(
                              hintText: AppStrings.birthday,
                              controller: _registerVM.birthdayController,
                              validator: AppValidator.fieldEmpty,
                            ),
                            const SizedBox(height: 16),
                            RegisterFieldWidget(
                              hintText: AppStrings.password,
                              controller: _registerVM.passwordController,
                              validator: AppValidator.password,
                            ),
                            const SizedBox(height: 16),
                            RegisterFieldWidget(
                              hintText: AppStrings.confirmPassword,
                              controller: _registerVM.confirmPasswordController,
                              validator: AppValidator.password,
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: AppButton(
                onPressed: _onSignUp,
                borderRadius: 8,
                label: AppStrings.signUp,
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSignUp() async {
    var appSystem = ref.read(appSystemProvider.notifier);

    try {
      bool validate = _formKey.currentState?.validate() ?? false;
      if (!validate) return;
      _registerVM.handleConfirmPassword();

      appSystem.setLoading(true);
      await _registerVM.signUp();

      if (mounted) {
        PopupsHelper.showSnackBar(context, AppStrings.signUpSuccess);
        context.pop();
      }
    } on Exception catch (error) {
      if (mounted) PopupsHelper.showSnackBar(context, error.message);
    } finally {
      appSystem.setLoading(false);
    }
  }
}
