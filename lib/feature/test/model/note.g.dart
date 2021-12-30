// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note(
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'time': instance.time?.toIso8601String(),
      'title': instance.title,
    };
