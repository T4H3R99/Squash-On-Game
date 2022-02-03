import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audio_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // AudioPlayer audioPlayer = AudioPlayer();
  // AudioCache audioCache = AudioCache();
  //AudioPlayerState audioPlayerState = AudioPlayerState.PAUSED;
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    //audioCache = AudioCache(fixedPlayer: audioPlayer);

    //audioplay();
  }

  bool lang = false;
  getLang() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      lang = pref.getBool('lang')!;
    });
  }

  putLang() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('forsettings', lang);
  }

  var x = true;
  var y = true;
  var z = true;
  //AudioCache audioPlayer = AudioCache();
  var play = true;
  // void audioplay() async {
  //   //audio
  //   await audioCache.loop('Menu.mp3');
  // }

  // void audioPause() async {
  //   await audioPlayer.pause();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/FDGDGDF1.png'),
                      fit: BoxFit.cover)),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/Group1.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'settings');
                  },
                  icon: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5.00)),
                      child: Center(child: Icon(Icons.settings))),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width * 0.03,
              left: MediaQuery.of(context).size.height * 0.7,
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/asfe1.png')),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width * 0.03,
              left: MediaQuery.of(context).size.height * 0.7,
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/asfe2.png')),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width * 0.03,
              left: MediaQuery.of(context).size.height * 0.7,
              child: Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/asfe3.png')),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width * 0.08,
              left: MediaQuery.of(context).size.height * 0.5,
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  child: RotationTransition(
                    turns: new AlwaysStoppedAnimation(345 / 360),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Image.asset('assets/ball.png'),
                        ),
                        const Text(
                          "START",
                          style: TextStyle(
                              shadows: [
                                Shadow(
                                  color: Colors.blueGrey,
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 2.0,
                                )
                              ],
                              letterSpacing: 5.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    getLang();
                    putLang();

                    Navigator.pushNamed(context, 'game');
                  },
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
