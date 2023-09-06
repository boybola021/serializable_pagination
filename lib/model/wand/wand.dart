
import 'package:json_annotation/json_annotation.dart';
 part 'wand.g.dart';
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
@JsonSerializable()
class Wand{
 String wood;
  String core;
 //final num? length;

 Wand({
     required this.wood,
     required this.core,
    // required this.length
 });


 factory Wand.fromJson(Map<String,dynamic> json) => _$WandFromJson(json);
 Map<String,dynamic> toJson() =>   _$WandToJson(this);
}

