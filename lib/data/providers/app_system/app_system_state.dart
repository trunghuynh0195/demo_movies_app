import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_system_state.freezed.dart';

@freezed
class AppSystemState with _$AppSystemState {
  const factory AppSystemState({
    @Default(false) bool isLoading,
  }) = _AppSystemState;
}
