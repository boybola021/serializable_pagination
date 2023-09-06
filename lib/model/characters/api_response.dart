
import 'package:json_annotation/json_annotation.dart';
import 'package:serializable_pagination/model/wand/wand.dart';
part 'api_response.g.dart';

final json =   {
  "id": "9e3f7ce4-b9a7-4244-b709-dae5c1f1d4a8",
  "name": "Harry Potter",
  "alternate_names": [
    "The Boy Who Lived",
    "The Chosen One"
  ],
  "species": "human",
  "gender": "male",
  "house": "Gryffindor",
  "dateOfBirth": "31-07-1980",
  "yearOfBirth": 1980,
  "wizard": true,
  "ancestry": "half-blood",
  "eyeColour": "green",
  "hairColour": "black",
  "wand": {
    "wood": "holly",
    "core": "phoenix feather",
    "length": 11
  },
  "patronus": "stag",
  "hogwartsStudent": true,
  "hogwartsStaff": false,
  "actor": "Daniel Radcliffe",
  "alternate_actors": [],
  "alive": true,
  "image": "https://ik.imagekit.io/hpapi/harry.jpg"
};

@JsonSerializable(explicitToJson: true,)

class ApiResponse{
 final String id;
 final String name;
 final List<String>? alternateNames;
 final String species;
 final String gender;
 final String house;
 final String? dateOfBirth;
 final int? yearOfBirth;
 final bool wizard;
 final String ancestry;
 final String eyeColour;
 final String hairColour;
 final Wand wand;
 final String patronus;
 final bool hogwartsStudent;
 final bool hogwartsStaff;
 final String actor;
 final List<String>? alternateActors;
 final bool alive;
 final String image;

 ApiResponse({
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
     required this.image});

   factory ApiResponse.fromJson(Map<String,dynamic>json) => _$ApiResponseFromJson(json);
   Map<String,dynamic> toJson() => _$ApiResponseToJson(this);
}
