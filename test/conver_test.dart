import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serializable_pagination/model/title_test.dart';
import 'package:serializable_pagination/service/network.dart';

void main(){

  test("Test Conver",()async{
    final respone = await Network.getMethod(api: Network.todos,baseUrl: Network.baseUrlTodos);
    final json = jsonDecode(respone!) as List;
    final List<TitleModel> list;
    list = json.map((e) => TitleModel.fromJson(e)).toList();
    for(int i = 0; i < list.length; i ++){
      debugPrint(list[i].title);
    }
  });
}