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

  var x = true;
  var y = true;

  bool lang = false;
  AudioCache audioPlayer = AudioCache();
  var play = true;
  void audioplay() async {
    if (play == true) {
      print(play);
    }
  }

  setData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('lang', lang);
  }

  setVibration() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('vibration', y);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(lang);
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
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'menu');
              },
              icon: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5.00)),
                  child: Icon(Icons.arrow_back)),
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
                      color: x ? Colors.grey : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          audioplay();

                          play = !play;
                          x = !x;
                        });
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
                      color: y ? Colors.grey : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          y = !y;
                        });
                        setVibration();
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
                        setData();
                        print(lang);
                      },
                      icon: !lang
                          ? Image.asset('assets/index.png')
                          : Image.asset('assets/flag-400.png'),
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
