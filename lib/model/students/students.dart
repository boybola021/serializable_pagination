import 'package:serializable_pagination/model/wand/wand.dart';
import 'package:json_annotation/json_annotation.dart';
part 'students.g.dart';

@JsonSerializable(explicitToJson: true)
class Students {
  String id;
  String name;
  List<String>? alternateNames;
  String species;
  String gender;
  String house;
  String? dateOfBirth;
  int? yearOfBirth;
  bool wizard;
  String ancestry;
  String eyeColour;
  String hairColour;
  Wand wand;
  String patronus;
  bool hogwartsStudent;
  bool hogwartsStaff;
  String actor;
  List<String>? alternateActors;
  bool alive;
  String image;

  Students({
    required this.id,
    required this.name,
    required this.alternateNames,
    required this.species,
    required this.gender,
    required this.house,
    required this.dateOfBirth,
    required this.yearOfBirth,
    required this.wizard,
    required this.ancestry,
    required this.eyeColour,
    required this.hairColour,
    required this.wand,
    required this.patronus,
    required this.hogwartsStudent,
    required this.hogwartsStaff,
    required this.actor,
    required this.alternateActors,
    required this.alive,
    required this.image,
  });
  factory Students.fromJson(Map<String,dynamic> json) => _$StudentsFromJson(json);
  Map<String,dynamic> toJson() => _$StudentsToJson(this);
}