
import 'package:json_annotation/json_annotation.dart';

import '../wand/wand.dart';
part 'house.g.dart';

@JsonSerializable(explicitToJson: true)
class House {
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

  House({
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

  factory House.fromJson(Map<String,dynamic> json) => _$HouseFromJson(json);
  Map<String,dynamic> toJson() => _$HouseToJson(this);
}