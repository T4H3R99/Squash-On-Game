import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:audioplayers/audio_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';

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

    getSound();
    getVibration();
    getLnaguage();
    print('sound1 is $sound1');
    print('vibration is $vibration1');
    player.pause();
    player.dispose();
  }

  bool lang = true;
  static bool _defaultSound = true;
  static var sound1 = true;
  static bool defaultVibration = true;
  static bool vibration1 = true;
  static bool lang1 = true;

  Future<bool> getSound() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      sound1 = _pref.getBool('sound')!;
    });
    print('sound from settings is $sound1');
    return sound1;
  }

  putSoundToSettings() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool('defaultsound', _defaultSound);
  }

  Future<bool> getVibration() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    vibration1 = _pref.getBool('vibration')!;
    return vibration1;
  }

  putVibrationToSettings() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool('defaultvibration', vibration1);
  }

  Future<bool> getLnaguage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    lang1 = _pref.getBool('language')!;
    return lang1;
  }

  putLanguageForSettings() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool('defaultlanguage', lang1);
  }

  AudioPlayer player = AudioPlayer();

  song() async {
    var song = await player.setAsset('assets/Menu.mp3');

    player.play();
    player.setVolume(60.0);

    player.setLoopMode(LoopMode.one);
  }

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
                  onPressed: () async {
                    await putSoundToSettings();
                    await putVibrationToSettings();
                    Navigator.pushNamed(context, 'settings');
                  },
                  icon: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2.00)),
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
                    song();
                    Navigator.pushReplacementNamed(context, 'game');
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
