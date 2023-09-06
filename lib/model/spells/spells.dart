
import 'package:json_annotation/json_annotation.dart';
part 'spells.g.dart';
@JsonSerializable()
class Spell{
  String id;
  String name;
  String description;

  Spell({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Spell.fromJson(Map<String,dynamic>json) => _$SpellFromJson(json);
  Map<String,dynamic> toJson() => _$SpellToJson(this);
}