import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:provider/provider.dart';
class UpdateFCMToken{
  Future<void> fcmUpdate({
    required BuildContext context,
    required String fcmtoken,
  })async{
    final student = Provider.of<StudentProvider>(context,listen: false).user;
    try{
      final Map<String, dynamic> data = {'fcmtoken': fcmtoken};
      http.Response res = await http.put(
        Uri.parse('$uri/kcg/student/fcm-token/${student.id}'),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (res.statusCode == 200) {
        //print('FCMTOKEN updated successfully:'+fcmtoken);
        // You can handle success here
      } else {
        //print('Failed to update Form');
        //print(res.body);
        // Handle error here
      }
    }catch(e){
      print(e);
    }
  }
}