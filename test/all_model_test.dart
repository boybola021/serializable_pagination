
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:serializable_pagination/model/characters/api_response.dart';
import 'package:serializable_pagination/model/spells/spells.dart';
import 'package:serializable_pagination/model/staff/staff.dart';
import 'package:serializable_pagination/model/students/students.dart';
import 'package:serializable_pagination/model/wand/wand.dart';
import 'package:serializable_pagination/service/network.dart';
import 'package:test/test.dart';

void main(){
    group("All Test", (){

      test("Wand model test",()async{
        final respone = await Network.getMethod(api: Network.apiCharacters);
        final json = jsonDecode(respone!) as List;
        final res = json.map((e){
          final item = e as Map;
          final wand = item["wand"] as Map<String,Object?>;
          return Wand.fromJson(wand);
        }).toList();
        print(res);
      });

      test("Students model test",()async{
        final respone = await Network.getMethod(api: Network.apiStudents);
        final json = jsonDecode(respone!) as List;
        final students = json.map<Students>((e) => Students.fromJson(e as Map<String, dynamic>)).toList();
        debugPrint(students.toString());
      });

       test("Staff model test",()async{
        final respone = await Network.getMethod(api: Network.apiStaff);
        final json = jsonDecode(respone!) as List;
        final staff = json.map<Staff>((e) => Staff.fromJson(e as Map<String, dynamic>)).toList();
        debugPrint(staff.toString());
      });

       test("Spell model test",()async{
        final respone = await Network.getMethod(api: Network.apiSpells);
        final json = jsonDecode(respone!) as List;
        final spell = json.map<Spell>((e) => Spell.fromJson(e as Map<String, dynamic>)).toList();
        debugPrint(spell.toString());
      });

       test("Characters model test",()async{
        final respone = await Network.getMethod(api: Network.apiCharacters);
        final json = jsonDecode(respone!) as List;
        final apiResponse = json.map<ApiResponse>((e) => ApiResponse.fromJson(e as Map<String, dynamic>)).toList();
        debugPrint(apiResponse.toString());
      });
    });
}