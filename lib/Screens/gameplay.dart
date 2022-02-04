import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class GamePlay extends StatefulWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  _GamePlayState createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  int _start = 4;
  late Timer _timer;
  void timergame() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        if (mounted) {
          setState(() {
            _start = 4;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _start--;
          });
        }
      }
      if (_start == 0 && nbrRacket > 0) {
        if (mounted) {
          setState(() {
            nbrRacket = nbrRacket - 1;
          });
        }
      }

      if (_start == 0 && nbrRacket == 0) {
        _timer.cancel();
        setScore();
        Navigator.pushNamedAndRemoveUntil(
            context, 'score', (Route<dynamic> route) => false);
      }
    });
  }

  bool sound3 = true;
  Future<bool> getSound() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      sound3 = _pref.getBool('sound')!;
    });
    print('sound 3 is $sound3');
    return sound3;
  }

  void setScore() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('score', score);
  }

  final player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getSound();
    getVibration();
    generateRandomColumn();

    generateRandomRow();
    generateIndexForBall();
    coordinateBall();
    liste();

    timergame();
    score = 0;
    song();
  }

  stopsong() async {
    var song = await player.setAsset('assets/Menu.mp3');
    player.play();
  }

  song() async {
    var song = await player.setAsset('assets/Menu.mp3');
    if (sound3 == true) {
      player.play();

      player.setLoopMode(LoopMode.one);
    }
  }

  Random rnd = new Random();
  static int score = 0;
  int nbrRacket = 3;
  bool? vibration1 = false;
  late int randomcolumn1;
  late int randomcolumn2;
  late int randomcolumn3;
  late int randomRow1;
  late int randomRow2;
  late int randomRow3;
  late int indexBall;
  late List<int> coordinate = [0, 0];
  var L = [];
  Map<int, int>? genration;
  List<int> column = [1, 2, 3, 4];
  List<int> row = [1, 2, 3];

  void generateRandomColumn() {
    randomcolumn1 = rnd.nextInt(4) + 1;
    randomcolumn2 = rnd.nextInt(4) + 1;
    randomcolumn3 = rnd.nextInt(4) + 1;

    while (randomcolumn1 == randomcolumn2 ||
        randomcolumn2 == randomcolumn3 ||
        randomcolumn1 == randomcolumn3) {
      setState(() {
        randomcolumn1 = rnd.nextInt(4) + 1;
        randomcolumn2 = rnd.nextInt(4) + 1;
        randomcolumn3 = rnd.nextInt(4) + 1;
      });
    }
  }

  void generateRandomRow() {
    randomRow1 = rnd.nextInt(3) + 1;
    randomRow2 = rnd.nextInt(3) + 1;
    randomRow3 = rnd.nextInt(3) + 1;

    while (randomRow1 == randomRow2 ||
        randomRow2 == randomRow3 ||
        randomRow3 == randomRow1) {
      setState(() {
        randomRow1 = rnd.nextInt(3) + 1;
        randomRow2 = rnd.nextInt(3) + 1;
        randomRow3 = rnd.nextInt(3) + 1;
      });
    }

    // print(randomRow1);
    // print(randomRow2);
    // print(randomRow3);
  }

  void generateIndexForBall() {
    indexBall = rnd.nextInt(12);
  }

  List<int> newCoor = [1, 1];
  List<int> coordinateBall() {
    switch (indexBall) {
      case 0:
        {
          coordinate = [1, 1];
        }
        break;
      case 1:
        {
          coordinate = [1, 2];
        }
        break;
      case 2:
        {
          coordinate = [1, 3];
        }
        break;
      case 3:
        {
          coordinate = [1, 4];
        }
        break;
      case 4:
        {
          coordinate = [2, 1];
        }
        break;
      case 5:
        {
          coordinate = [2, 2];
        }
        break;
      case 6:
        {
          coordinate = [2, 3];
        }
        break;
      case 7:
        {
          coordinate = [2, 4];
        }
        break;
      case 8:
        {
          coordinate = [3, 1];
        }
        break;
      case 9:
        {
          coordinate = [3, 2];
        }
        break;
      case 10:
        {
          coordinate = [3, 3];
        }
        break;
      case 11:
        {
          coordinate = [3, 4];
        }
        break;
      default:
        {
          coordinate = [1, 1];
        }
        break;
    }
    while ((coordinate[0] == randomRow1 && coordinate[1] == randomcolumn1) ||
        (coordinate[0] == randomRow2 && coordinate[1] == randomcolumn2) ||
        (coordinate[0] == randomRow3 && coordinate[1] == randomcolumn3)) {
      generateRandomColumn();
    }
    setState(() {
      newCoor = coordinate;
    });
    print('newcoor=$newCoor');
    return newCoor;
  }

  void liste() {
    L = [
      [randomRow1, randomcolumn1],
      [randomRow2, randomcolumn2],
      [randomRow3, randomcolumn3],
      [newCoor[0], newCoor[1]],
    ];
    print('before shuffle $L');
    L.shuffle();
    print(L);
  }

  var vibrationGame;
  Future<bool> getVibration() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    vibrationGame = _pref.getBool('vibration')!;
    return vibrationGame;
  }

  final player2 = AudioPlayer();
  void wrongAnswer() {
    var song1 = player2.setAsset('assets/Wrong.mp3');
    player2.setVolume(130.0);
    player2.play();
  }

  final player3 = AudioPlayer();
  void correctAnswer() {
    var song3 = player3.setAsset('assets/Correct.mp3');
    player3.setVolume(130.0);
    player3.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 139, 0, 0),
        body: Stack(children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/FDGDGDF.png'),
                    fit: BoxFit.cover)),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Center(
                      child: Text(
                    '$_start',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3.0)),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    children: [
                      Flexible(
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 4,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 5, crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  if (L[index][0] == newCoor[0] &&
                                      L[index][1] == newCoor[1]) {
                                    if (sound3 == true) {
                                      player.pause();
                                      correctAnswer();
                                      player.play();
                                    }

                                    if (mounted) {
                                      setState(() {
                                        score = score + 3;
                                        _start = 4;
                                      });
                                    }
                                    generateRandomColumn();
                                    generateRandomRow();
                                    generateIndexForBall();
                                    coordinateBall();
                                    liste();
                                  } else {
                                    if (sound3 == true) {
                                      player.pause();
                                      wrongAnswer();
                                      player.play();
                                    }

                                    if (mounted) {
                                      setState(() {
                                        nbrRacket = nbrRacket - 1;
                                        _start = 4;
                                      });
                                    }
                                    if (vibrationGame == true) {
                                      if (await Vibration.hasVibrator()) {
                                        Vibration.vibrate(
                                            duration: 200, amplitude: -1);
                                      }
                                    }
                                    generateRandomColumn();
                                    generateRandomRow();
                                    generateIndexForBall();
                                    coordinateBall();
                                    liste();
                                    if (nbrRacket == 0) {
                                      setScore();

                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          'score',
                                          (Route<dynamic> route) => false);
                                    }
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          200, 50, 40, 0.92),
                                      border: Border.all(color: Colors.black)),
                                  child: Center(
                                    child: Text(
                                      '${L[index][0]}/${L[index][1]}',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Flexible(
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 12,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2.5,
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 1.78,
                                    mainAxisSpacing: 1.78),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(250, 191, 150, 155),
                                      border: Border.all(
                                          color: Colors.black, width: 1.5)),
                                  child: Center(
                                    child: indexBall == index
                                        ? Image.asset('assets/ball.png')
                                        : Text(''),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Center(
                          child: Text(
                        '$score',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      )),
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(3.0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 2.3,
                children: List.generate(
                        nbrRacket, (index) => Image.asset('assets/asfe1.png'))
                    .toList()),
          )
        ]),
      ),
    );
  }
}
