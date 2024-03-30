class AppValidator {
  AppValidator._();

  static String? fieldEmpty(String? value) {
    if (isEmpty(value)) return "Field Empty";
    return null;
  }

  static bool isEmpty(String? value) {
    return (value ?? '').isEmpty;
  }

  /// required password:
  /// - should contain at least one upper case
  /// - should contain at least one lower case
  /// - should contain at least one digit
  /// - should contain at least one Special character
  /// - Must be at least 8 characters in length

  static String? password(String? value) {
    if (isEmpty(value)) return "Password Empty";

    // final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    // if (!passwordRegExp.hasMatch(value!)) {
    //   return "Password Incorrect";
    // }
    return null;
  }

  static String? email(String? value) {
    if (isEmpty(value)) return "Email Empty";

    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(value!)) {
      return "Email Incorrect";
    }
    return null;
  }
}
