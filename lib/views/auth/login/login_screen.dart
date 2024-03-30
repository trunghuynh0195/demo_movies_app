import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/routes/routes.dart';
import 'package:demo_movies_app/core/theme/app_colors.dart';
import 'package:demo_movies_app/core/theme/dimension.dart';
import 'package:demo_movies_app/core/utils/app_image_paths.dart';
import 'package:demo_movies_app/core/utils/app_strings.dart';
import 'package:demo_movies_app/core/utils/helpers/popups_helper.dart';
import 'package:demo_movies_app/core/utils/utils.dart';
import 'package:demo_movies_app/core/widgets/widgets.dart';
import 'package:demo_movies_app/data/providers/providers.dart';
import 'package:demo_movies_app/views/auth/login/view_model/login_view_model.dart';
import 'package:demo_movies_app/views/auth/login/widgets/login_field_widget.dart';
import 'package:demo_movies_app/views/auth/login/widgets/login_with_buttons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final LoginViewModel _loginVM;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loginVM = ref.read(loginViewModel.notifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimension.padding),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        AppImagePaths.appIcon,
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(AppStrings.movies, style: context.textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 36),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LoginFieldWidget(
                        title: AppStrings.email,
                        hintText: 'example@example.com',
                        onChanged: _loginVM.setEmail,
                        validator: AppValidator.email,
                      ),
                      const SizedBox(height: 16),
                      LoginFieldWidget(
                        title: AppStrings.password,
                        hintText: AppStrings.password,
                        isPasswordField: true,
                        onChanged: _loginVM.setPassword,
                        validator: AppValidator.password,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                AppButton(
                  onPressed: () => _login(),
                  label: AppStrings.btnContinue,
                  backgroundColor: AppColors.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  AppStrings.forgotPassword,
                  style: context.textTheme.labelMedium?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 24),
                const Row(
                  children: [
                    Expanded(child: Divider(height: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(AppStrings.or),
                    ),
                    Expanded(child: Divider(height: 1)),
                  ],
                ),
                const SizedBox(height: 24),
                const LoginWithButtons(),
                const SizedBox(height: 36),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: AppStrings.dontHaveAccount,
                        style: context.textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: ' ${AppStrings.signUp}',
                        style: context.textTheme.labelLarge?.copyWith(color: AppColors.primary),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    var appSystem = ref.read(appSystemProvider.notifier);
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    try {
      bool isValidate = _formKey.currentState?.validate() ?? false;
      if (!isValidate) return;

      appSystem.setLoading(true);
      var user = await _loginVM.login();
      if (user != null && mounted) context.goNamed(AppScreens.dashboard.getName);
    } on Exception catch (error) {
      if (mounted) PopupsHelper.showSnackBar(context, error.message);
    } finally {
      appSystem.setLoading(false);
    }
  }
}
