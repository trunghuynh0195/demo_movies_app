import 'package:demo_movies_app/core/extensions/extensions.dart';
import 'package:demo_movies_app/core/utils/enums/app_button_type.dart';
import 'package:demo_movies_app/core/utils/enums/login_with_type.dart';
import 'package:demo_movies_app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class LoginWithButtons extends StatelessWidget {
  const LoginWithButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLoginWithButton(
          context: context,
          type: LoginWithType.google,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        _buildLoginWithButton(
          context: context,
          type: LoginWithType.apple,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        _buildLoginWithButton(
          context: context,
          type: LoginWithType.facebook,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildLoginWithButton({
    required BuildContext context,
    void Function()? onPressed,
    required LoginWithType type,
  }) {
    return AppButton(
      onPressed: onPressed,
      type: AppButtonType.outline,
      outlineColor: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(type.icon, height: 20),
          const SizedBox(width: 8),
          Text(
            'Continue with ${type.getName}',
            style: context.textTheme.labelMedium,
          )
        ],
      ),
    );
  }
}
