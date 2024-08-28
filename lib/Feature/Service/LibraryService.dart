import 'dart:convert';

import 'package:campuslink/Model/LibraryData.dart';
import 'package:http/http.dart' as http;
import 'package:campuslink/Util/util.dart';
class LibraryService{
  Future<List<LibraryModel>> searchLibraryByName(String name) async {
  final response = await http.get(Uri.parse('$uri/library/search?book_title=$name'));
  print(response.body);
  if (response.statusCode == 200) {
    List<dynamic> jsonList = json.decode(response.body);
    List<LibraryModel> students = jsonList.map((json) => LibraryModel.fromMap(json)).toList();
 return students;
  } else if (response.statusCode == 404) {
    return []; 
  } else {
    throw Exception('Failed to fetch data');
  }
}
}