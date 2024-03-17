import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hackaton/Screen/home_page.dart';

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

  Image? lastPictureTaken;

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
            lastPictureTaken ?? CameraPreview(_controller),
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
                          lastPictureTaken = Image.file(File(imageXFile.path));
                        });
                      },
                      size: MediaQuery.of(context).size.height * 0.07,
                      descricao: 'Tirar foto',
                    ),
                    const Spacer(),
                    buildMenuButton(
                      icon: Icons.search,
                      size: MediaQuery.of(context).size.height * 0.05,
                      descricao: 'Identificar',
                    ),
                    /*
                     
                    wrappedIconButton(
                      icon: Icons.accessible_sharp,
                      size: MediaQuery.of(context).size.height * 0.05,
                    ),
                    const Spacer(),
                    wrappedIconButton(
                      icon: Icons.camera_alt,
                      onPressed: () async {
                        final imageXFile = await _controller.takePicture();

                        setState(() {
                          lastPictureTaken = Image.file(File(imageXFile.path));
                        });
                      },
                      size: MediaQuery.of(context).size.height * 0.07,
                    ),
                    const Spacer(),
                    wrappedIconButton(
                      icon: Icons.arrow_back_ios_rounded,
                      size: MediaQuery.of(context).size.height * 0.05,
                    ),
                     */
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      /*
      floatingActionButton: FloatingActionButton(
        
        backgroundColor: DefaultColors.green,
        onPressed: () async {
          try {
            await _initializeControllerFuture;
    
            final image = await _controller.takePicture();
    
            if (!context.mounted) return;
    
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
      */
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
