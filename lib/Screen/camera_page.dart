import 'dart:io' as io;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hackaton/Screen/home_page.dart';
import 'package:projeto_hackaton/backend/analyze_image_route.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  io.File? lastPictureTakenFile;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPageColumn() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: Column(
          children: [
            lastPictureTakenFile == null
                ? CameraPreview(_controller)
                : Image.file(lastPictureTakenFile!),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 28, 25, 28),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildMenuButton(
                      icon: Icons.perm_media,
                      descricao: 'Galeria',
                      size: MediaQuery.of(context).size.height * 0.05,
                    ),
                    const Spacer(),
                    buildMenuButton(
                      icon: Icons.camera_alt,
                      onPressed: () async {
                        final imageXFile = await _controller.takePicture();
                        setState(() {
                          lastPictureTakenFile = io.File(imageXFile.path);
                        });
                        print(imageXFile.path);
                      },
                      size: MediaQuery.of(context).size.height * 0.07,
                      descricao: 'Tirar foto',
                    ),
                    const Spacer(),
                    buildMenuButton(
                      icon: Icons.search,
                      size: MediaQuery.of(context).size.height * 0.05,
                      descricao: 'Identificar',
                      onPressed: () async {
                        //lastPictureTakenFile
                        if (lastPictureTakenFile != null) {
                          analyzeImage(lastPictureTakenFile!);
                        }
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib\\assets\\images\\FundoGradiente.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildPageColumn();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
