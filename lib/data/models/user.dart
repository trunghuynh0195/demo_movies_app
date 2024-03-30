import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();
  const factory User({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? phone,
    String? birthday,
    String? gender,
    @JsonKey(name: 'created_at') int? createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
