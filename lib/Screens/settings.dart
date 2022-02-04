import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AudioPlayer player = AudioPlayer();

  static bool vibration = true;

  static bool sound = true;
  static bool lang = true;

  putSound() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool('sound', sound);
  }

  getSoundFromMenu() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    sound = _pref.getBool('defaultsound')!;

    return sound;
  }

  putVibration() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool('vibration', vibration);
  }

  getVibrationFromMenu() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    vibration = _pref.getBool('defaultvibration')!;

    return vibration;
  }

  putLanguage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool('language', lang);
  }

  getLanguageFromMenu() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    lang = _pref.getBool('defaultlanguage')!;

    return lang;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSoundFromMenu();
    getVibrationFromMenu();
    getLanguageFromMenu();
    print('sound is $sound');
    print(' vibration is $vibration');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/FDGDGDF1.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Group1.png'), fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () async {
                  await putSound();
                  await putVibration();
                  await putLanguage();
                  Navigator.pushNamed(context, 'menu');
                },
                icon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.00)),
                    child: Icon(Icons.arrow_back)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: sound ? Colors.red : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          sound = !sound;
                        });

                        print('soundis$sound');
                      },
                      icon: Icon(Icons.music_note),
                      iconSize: 50,
                    )),
                const SizedBox(
                  width: 40,
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: vibration ? Colors.red : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          vibration = !vibration;
                        });
                        print('vibration is $vibration');
                      },
                      icon: Icon(Icons.vibration),
                      iconSize: 50,
                    )),
                const SizedBox(
                  width: 40,
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          lang = !lang;
                        });

                        print(lang);
                      },
                      icon: lang
                          ? Image.asset('assets/flag-400.png')
                          : Image.asset('assets/index.png'),
                      iconSize: 50,
                    )),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
