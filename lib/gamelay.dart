import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  }

  final List<int> _list = [1, 2, 3];
  final _raq = ['assets/asfe1.png'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.red[700],
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: const Center(
                      child: Text(
                    '1:22',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3.0)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GridView.builder(
                        itemCount: 9,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white)),
                              child: Center(
                                child: Text(
                                  index.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 35),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
                Container(
                  child: const Center(
                      child: Text(
                    '300',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                  height: 40,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(3.0)),
                ),
              ],
            ),
          )),
    );
  }
}
