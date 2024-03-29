import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:projeto_hackaton/Screen/camera_page.dart';
import 'package:projeto_hackaton/main.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1660613757833-f2b6eccbb544?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1598512752271-33f913a5af13?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1658003920691-835a9d86c7da?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
];

Widget buildMenuButton({
  void Function()? onPressed,
  required IconData icon,
  required String descricao,
  double size = 25,
}) {
  return Column(
    children: [
      wrappedIconButton(
        onPressed: onPressed,
        icon: icon,
        size: size,
      ),
      const SizedBox(height: 10),
      Text(descricao, style: const TextStyle(color: Colors.white)),
    ],
  );
}

Widget wrappedIconButton({
  void Function()? onPressed,
  IconData? icon,
  double? size,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: DefaultColors.green,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(27)),
    ),
    onPressed: onPressed,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Icon(icon, size: size, color: Colors.white),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(242, 242, 242, 100),
                              Color.fromRGBO(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 25.0,
                          horizontal: 20.0,
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();

  int _current = 0;
  final _carouselController = CarouselController();

  Widget carrouselIndicator() {
    return Center(
      child: Container(
        width: imgList.length * 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: DefaultColors.grey,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(
                    2,
                    38,
                    2,
                    _current == entry.key ? 0.9 : 0.4,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Widget> header() {
    return [
      // TODO Titulo chamativo
      Center(
        child: Image.asset(
          'lib\\assets\\images\\Logo.png',
          width: MediaQuery.sizeOf(context).width * 149 / 390,
          height: MediaQuery.sizeOf(context).height * 57 / 844,
        ),
      ),

      const SizedBox(height: 30),
      RichText(
        text: const TextSpan(
          style: TextStyle(
            fontFamily: 'Poppins',
            height: 0.9,
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          text: '',
          children: <TextSpan>[
            TextSpan(
              text: "Olá,\n",
            ),
            TextSpan(
              text: 'Ana Clara',
              style: TextStyle(color: DefaultColors.greenText),
            ),
          ],
        ),
      ),
      const SizedBox(height: 25),
      const Text(
        'Como podemos ajudar?', // TODO melhor texto
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsetsDirectional.all(20),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib\\assets\\images\\FundoGradiente.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...header(),
              /* 
              ElevatedButton(
                  /*
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
                 */
                  style: const ButtonStyle(),
                  onPressed: () => debugPrint('Abre anuncio'),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1279,
                    width: MediaQuery.of(context).size.width * 0.8436,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => debugPrint('e'),
                          icon: const Icon(Icons.arrow_circle_left_sharp),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => debugPrint('e'),
                          icon: const Icon(Icons.arrow_circle_left_sharp),
                        ),
                      ],
                    ),
                  )),
              */
              Row(
                children: [
                  buildMenuButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CameraPage(camera: cameras.first),
                        ),
                      );
                    },
                    icon: Icons.camera_alt,
                    descricao: 'Camêra',
                    size: MediaQuery.of(context).size.height * 0.07,
                  ),
                  const SizedBox(width: 10),
                  buildMenuButton(
                    onPressed: () => debugPrint('Galeria'),
                    icon: Icons.perm_media,
                    descricao: 'Galeria',
                    size: MediaQuery.of(context).size.height * 0.07,
                  ),
                  const Spacer(),
                ],
              ),
              CarouselSlider(
                carouselController: _carouselController,
                items: imageSliders,
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height * 0.2,
                  aspectRatio: MediaQuery.of(context).size.aspectRatio,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
              carrouselIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
