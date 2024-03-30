extension ExceptionEX on Exception {
  String get message => toString().replaceFirst('Exception: ', '');
}
