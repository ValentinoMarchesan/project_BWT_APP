import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/gamepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  static const route = '/home/game/info';
  static const routename = 'INFORMATION PAGE';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(InfoPage.routename,
              style: TextStyle(
                fontFamily: 'AudioWide',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF000000),
              )),
          centerTitle: true,
          backgroundColor: Colors.orange,
          elevation: 0,
        ),
        body: Column(children: [
          Container(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      color: Colors.deepOrangeAccent,
                      height: 100,
                    ),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    color: Colors.orange,
                    height: 80,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange[500],
            ),
            height: 500,
            width: MediaQuery.of(context).size.width - 30,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                  initialData: null,
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final sp = snapshot.data as SharedPreferences;
                      if (sp.getInt('statusinfo') == 1) {
                        return const Text('IMPORTANCE OF SLEEP AND ACTIVITY \n'
                            'Sleep helps everyone to retain and consolidate memories. When a subject practice or learn new skills, sleep helps form memories, and contributes to improved performance in the future. Without sleep, the pathways in the brain that allow you to learn and make memories can’t be performed or maintained. \n'
                            'Sleep is also essential for cognitive processing. Also, just as exercise can help improve or maintain mental health, sleep is important for maintaining subjects’ mental health. Quality sleep is associated with improving overall mood. Healthy sleep prevents irritability and decreases the risk of developments such as depression. \n');
                      } else if (sp.getInt('statusinfo') == 2) {
                        return Text('PAPER SU MANCANZA DI SONNO');
                      } else if (sp.getInt('statusinfo') == 3) {
                        return Text('PAPER SU MANCANZA IDRATAZIONE');
                      } else if (sp.getInt('statusinfo') == 4) {
                        return Text('PAPER SCORRETTO STILE DI VITA');
                      } else if (sp.getInt('statusinfo') == 5) {
                        return Text('PAPER SU UN CORRETTO STILE DI VITA');
                      } else {
                        return CircularProgressIndicator();
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          )
        ]));
  }
}
