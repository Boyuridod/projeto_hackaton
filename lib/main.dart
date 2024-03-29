import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hackaton/Screen/home_page.dart';
import 'package:http/http.dart' as http;

var cameras = <CameraDescription>[];

abstract class DefaultColors {
  static const green = Color.fromRGBO(71, 160, 2, 100);
  static const greenText = Color.fromRGBO(162, 237, 43, 100);
  static const grey = Color.fromRGBO(217, 217, 217, 100);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  print(await http.get(Uri.parse('http://172.16.31.98:5555/upload')));

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const HomePage(),
    ),
  );
}

/*
Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}
 */
