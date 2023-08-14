import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'importer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => _list[index].goto!,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: _list[index].primaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.black45,
                                      spreadRadius: 0.5,
                                      offset: Offset(3, 4),
                                    ),
                                  ]),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 90,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: _list[index].secondaryColor,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 4,
                                        color: Colors.black12,
                                        spreadRadius: 0.3,
                                        offset: Offset(5, 3))
                                  ]),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      _list[index].name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black26,
                                              blurRadius: 2,
                                              offset: Offset(1, 2),
                                            )
                                          ]),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: _generateStar(_list[index].numOfStar!),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "앱에서 사용한 모든 아이콘은 ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      children: [
                        TextSpan(
                          text: 'www.flaticon.com',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            _launchUrl();
                          },
                        ),
                        TextSpan(
                          text: '에서\nFreepik이 만든 아이콘을 이용하였습니다.'
                        )
                      ]
                    ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            )
          ],
        ));
  }

  List<Widget> _generateStar(int num) {
    List<Widget> _icons = [];

    for (int i = 0; i < num; i++) {
      _icons.insert(
        i,
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
      );
    }

    return _icons;
  }

  Future<void> _launchUrl() async {

    final Uri _url = Uri.parse('https://www.flaticon.com');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

class Details {
  late String name;
  late Color primaryColor;
  late Color secondaryColor;
  Widget? goto;
  int? numOfStar;

  Details({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    this.goto,
    this.numOfStar,
  });
}

List<Details> _list = [
  Details(
    name: 'EASY',
    primaryColor: Colors.blueAccent,
    secondaryColor: Colors.blueAccent[100]!,
    numOfStar: 1,
    goto: FlipCardGame(level: Level.Easy),
  ),
  Details(
    name: 'MEDIUM',
    primaryColor: Colors.yellowAccent,
    secondaryColor: Colors.limeAccent.shade200,
    numOfStar: 2,
    goto: FlipCardGame(level: Level.Medium),
  ),
  Details(
    name: 'HARD',
    primaryColor: Colors.redAccent,
    secondaryColor: Colors.redAccent.shade100,
    numOfStar: 3,
    goto: FlipCardGame(level: Level.Hard),
  ),
];
