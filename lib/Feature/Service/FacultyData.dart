import "dart:convert";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:campuslink/Model/faculty.dart";
import "package:campuslink/Util/Additional/error_handling.dart";
import "package:campuslink/Util/showsnackbar.dart";
import "package:campuslink/Util/util.dart";
class FacultyService{
    //Display AllForm
  Future<List<faculty>> DisplayAllFaculty(
  {
    required BuildContext context,
  }
  )async{
    List<faculty> form = [];
    try {
      
      http.Response res = await http.get(
        Uri.parse('$uri/kcg/faculty/getAllFacultyData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      //print("response2=${res.body}");
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            form.add(
              faculty.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar( context:context,text: e.toString());
    }
    return form;
  }

  fetchData() async {
  final response = await http.get(Uri.parse('$uri/kcg/faculty/getAllFacultyData'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data;
  } else { 
    //print('Failed to load data');
  }
}
}