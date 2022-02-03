import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  bool lang = false;

  int score = 0;
  int bestScore = 0;
  int bestScoreever = 0;
  getScore() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      score = pref.getInt('score')!;
    });
  }

  int whosBigger() {
    if (score > bestScore) {
      setState(() {
        bestScore = score;
        bestScoreever = bestScore;
      });
      return 1;
    } else {
      return 0;
    }
  }

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      lang = pref.getBool('lang')!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getScore();

    getData();
  }

  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/BG.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                lang ? ' СЧЁТ: $score' : 'SCORE :$score',
                style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(200, 200, 200, 1)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                lang
                    ? 'ЛУЧШИЙ СЧЁТ'
                    : 'BEST SCORE : ${whosBigger() == 1 ? bestScore : score}',
                style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(200, 200, 200, 1)),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(255, 70, 70, 1))),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'menu');
                },
                child: const Text(
                  "MAIN MENU",
                  style: TextStyle(
                    fontSize: 23.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
