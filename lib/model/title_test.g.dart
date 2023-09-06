// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'title_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TitleModel _$TitleModelFromJson(Map<String, dynamic> json) => TitleModel(
      title: const DecryptString().fromJson(json['title'] as String),
    );

Map<String, dynamic> _$TitleModelToJson(TitleModel instance) =>
    <String, dynamic>{
      'title': const DecryptString().toJson(instance.title),
    };
