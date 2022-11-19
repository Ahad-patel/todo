import 'package:json_annotation/json_annotation.dart';

part 'notes_model.g.dart';

@JsonSerializable()
class Notes {
  int? id;
  String? title;
  String? subtitle;
  String? status;
  int? time;

  Notes({this.id,this.title,this.subtitle,this.status,this.time});

  factory Notes.fromJson(Map<String, dynamic> json) => _$NotesFromJson(json);

  Map<String, dynamic> toJson() => _$NotesToJson(this);


}