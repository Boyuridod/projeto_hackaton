import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<String> analyzeImage(File image) async {
  final rawData = image.readAsBytesSync();

  // convertendo para base 64
  final encodedData = base64.encode(rawData);

  final response = await http.post(
    Uri.parse('http://172.16.31.98:5555/upload'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(
      <String, String>{'image': encodedData},
    ),
  );

  print('Response:${response.body}');
  return response.body;
}
