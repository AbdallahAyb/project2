import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ToDo.dart';
import 'api_service.dart';

class todos{
 static Future<List<ToDo>> getAllTodos()async{
   final response=await APIService.sendRequest('GET',null,null);
   
   if(response==null)return [];
   final data=jsonDecode(response.body);
   List<ToDo> result=[];
   for(int i=0;i<data.length;i++){
    result.add(ToDo.fromJson(data[i]));
   }
   
   return result;
  }
 static Future<void> addToDo(ToDo todo)async{
    await APIService.sendRequest('POST',jsonEncode({'text':todo.text,'checked':todo.checked}),null);
  }
 static Future<void> deleteToDo(int id)async{
  await APIService.sendRequest('DELETE',null, id.toString());
  }
}