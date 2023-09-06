
import '../wand/wand.dart';
import 'package:json_annotation/json_annotation.dart';
part 'staff.g.dart';

@JsonSerializable(explicitToJson: true)
class Staff {
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

  Staff({
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

  factory Staff.fromJson(Map<String,dynamic> json) => _$StaffFromJson(json);
  Map<String,dynamic> toJson() =>  _$StaffToJson(this);
}