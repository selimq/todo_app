// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reqres_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqresModel _$ReqresModelFromJson(Map<String, dynamic> json) => ReqresModel(
    page: json['page'] as int?,
    perPage: json['perPage'] as int?,
    total: json['total'] as int?,
    totalPages: json['totalPages'] as int?,
    data: (json['data'] as List<dynamic>?)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        .toList());

Map<String, dynamic> _$ReqresModelToJson(ReqresModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'perPage': instance.perPage,
      'total': instance.total,
      'totalPages': instance.totalPages,
      'data': instance.data,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
    };
