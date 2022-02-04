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
  static int score1 = 0;
  static int bestScore = 0;

  void getScore() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    score1 = pref.getInt('score')!;
    print('score is $score1;');
    if (score1 > bestScore) {
      if (mounted) {
        setState(() {
          bestScore = score1;
        });
      }
    }
  }

  void score() {
    if (mounted) {
      setState(() {
        score1 = 0;
      });
    }
  }

  var lang2 = true;
  Future<bool> getlang() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        lang2 = _pref.getBool('language')!;
      });
    }

    return lang2;
  }

  @override
  void initState() {
    // TODO: implement initState
    print(lang2);
    getlang();
    super.initState();
    print(lang2);
    getScore();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    score();
  }

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
                lang2 == true ? ' СЧЁТ: $score1' : 'SCORE :$score1',
                style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(200, 200, 200, 1)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                lang2 ? 'ЛУЧШИЙ СЧЁТ : $bestScore' : 'BEST SCORE :  $bestScore',
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
