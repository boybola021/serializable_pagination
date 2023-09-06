// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spells.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Spell _$SpellFromJson(Map<String, dynamic> json) => Spell(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$SpellToJson(Spell instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
