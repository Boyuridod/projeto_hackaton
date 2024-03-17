import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future<dynamic> analyzeImage(File image) async {
  final rawData = image.readAsBytesSync();

  // convertendo para base 64
  final encodedData = base64.encode(rawData);

  final uploadResponse = await http.post(
    Uri.parse('http://172.16.31.98:5555/upload'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(
      <String, String>{'image': encodedData},
    ),
  );

  final response = await http.get(
    Uri.parse('http://172.16.31.98:5555/ai_vision'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );

  dynamic json = jsonDecode(response.body);
  print('Response:$json');

  return json;
}
