import 'package:json_annotation/json_annotation.dart';
import '../../../core/base/model/base_model.dart';
part 'reqres_model.g.dart';

@JsonSerializable()
class ReqresModel extends IBaseModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<User?>? data;
  ReqresModel(
      {this.page, this.perPage, this.total, this.totalPages, this.data});
  @override
  Map<String, dynamic> toJson() => _$ReqresModelToJson(this);

  @override
  fromJson(Map<String, dynamic> json) {
    return _$ReqresModelFromJson(json);
  }
}

@JsonSerializable()
class User extends IBaseModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  User({this.id, this.email, this.firstName, this.lastName, this.avatar});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
