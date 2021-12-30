import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'note.g.dart';

@JsonSerializable()
class Note {
  final DateTime? time;
  final String? title;
  final bool? isFinished;

  Note({
    this.time,
    this.title,
    this.isFinished,
  });

  Map<String, dynamic> toJson() => {
        'time': time,
        'title': title,
      };
  fromJson(Map<String, dynamic> json) {
    return Note(
        time: DateTime.fromMillisecondsSinceEpoch(
            (json['time'] as Timestamp).millisecondsSinceEpoch),
        title: json['title']);
  }
}
