import 'dart:convert';

import 'package:http/http.dart';
import 'package:serializable_pagination/model/spells/spells.dart';
import 'package:serializable_pagination/model/staff/staff.dart';
import 'package:serializable_pagination/model/students/students.dart';

import '../model/characters/api_response.dart';
import '../model/house/house.dart';

sealed class Network {
  static const String baseUrl = "hp-api.onrender.com";
  static const String apiCharacters = "/api/characters";
  static const String apiCharacterId = "/api/character/";
  static const String apiStudents = "/api/characters/students";
  static const String apiStaff = "/api/characters/staff";
  static const String apiHouse = "/api/characters/house/gryffindor";
  static const String apiSpells = "/api/spells";
  static String baseUrlTodos = "jsonplaceholder.typicode.com";
  static String todos = "/todos";

  static const Map<String, String> header = {
    "Content-Type": "application/json",
  };

  static Future<String?> getMethod(
      {required String api, String baseUrl = baseUrl, Object? id,Map<String,String> header = header}) async {
    Uri url = Uri.https(baseUrl, "$api${id ?? ""}");
    try {
      final response = await get(url, headers: header);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
  static List<ApiResponse>parseApiResponse(String data){
    final json = jsonDecode(data) as List;
    return json.map((e) => ApiResponse.fromJson(e as Map<String,dynamic>)).toList();
  }

  static List<House>parseHouseList(String data){
    final json = jsonDecode(data) as List;
    return json.map((e) => House.fromJson(e as Map<String,dynamic>)).toList();
  }
  static List<Spell>parseSpellsList(String data){
    final json = jsonDecode(data) as List;
    return json.map((e) => Spell.fromJson(e as Map<String,dynamic>)).toList();
  }
  static List<Staff>parseStaffList(String data){
    final json = jsonDecode(data) as List;
    return json.map((e) => Staff.fromJson(e as Map<String,dynamic>)).toList();
  }
  static List<Students>parseStudentsList(String data){
    final json = jsonDecode(data) as List;
    return json.map((e) => Students.fromJson(e as Map<String,dynamic>)).toList();
  }

}

