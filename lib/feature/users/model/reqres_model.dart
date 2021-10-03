import 'package:json_annotation/json_annotation.dart';
part 'reqres_model.g.dart';

@JsonSerializable()
class ReqresModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<User?>? data;
  ReqresModel(
      {this.page, this.perPage, this.total, this.totalPages, this.data});
  factory ReqresModel.fromJson(Map<String, dynamic> json) =>
      _$ReqresModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReqresModelToJson(this);
}

@JsonSerializable()
class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  User({this.id, this.email, this.firstName, this.lastName, this.avatar});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
