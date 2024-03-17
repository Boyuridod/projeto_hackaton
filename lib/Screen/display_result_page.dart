import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:projeto_hackaton/models/label.dart';

dynamic jsonResult;

Map<String, double> result = {};

void setJsonResult(dynamic json) {
  jsonResult = json;
  var result = {
    'Vírus do enrolamento': jsonResult['Curl'] as double,
    'Ferrugem Bacteriana': jsonResult['Ferrugem Bacteriana'] as double,
    'Fossarium Vult': jsonResult['FF'] as double,
    'Saudável': jsonResult['Saudavel'] as double,
  };
}

class DisplayResultPage extends StatefulWidget {
  const DisplayResultPage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final io.File image;

  @override
  State<DisplayResultPage> createState() => _DisplayResultPageState();
}

class _DisplayResultPageState extends State<DisplayResultPage> {
  Widget buildLabel({
    required String name,
    required double percent,
    FontWeight? fweight,
  }) {
    return Text(
      "Nome: $name\nProbabilidade de acerto:($percent %)\n",
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: fweight,
      ),
    );
  }

  MapEntry<String, double> mostProbable() {
    MapEntry<String, double> mostP = result.entries.first;

    for (var d in result.entries) {
      if (d.value >= mostP.value) {
        mostP = d;
      }
    }
    return mostP;
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
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        buildLabel(
                          name: 'Vírus do enrolamento',
                          percent: jsonResult['Curl'],
                          fweight: FontWeight.bold,
                        ),
                        buildLabel(
                          name: 'Ferrugem Bacteriana',
                          percent: jsonResult['Ferrugem Bacteriana'],
                        ),
                        buildLabel(
                          name: 'Fossarium Vult',
                          percent: jsonResult['FF'],
                        ),
                      ],
                    ),
                  ),
                  Image.file(
                    widget.image,
                    width: MediaQuery.sizeOf(context).width * 0.5,
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nome da planta identificada ...',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "nome científico da planta",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "PRAGA IDENTIFICADA:",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ferrugem Bacteriana',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "hakopsora gossypii",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "linha 1                                                   linha 2\nlinha 3\n",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
