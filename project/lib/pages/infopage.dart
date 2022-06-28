import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project/pages/gamepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//define the InfoPage where there are the some curious educational information about MECO avatar mood

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  static const route = '/home/game/info';
  static const routename = 'INFORMATION PAGE';

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BRAIN HEALTH',
            style: TextStyle(
              fontFamily: 'Goldman',
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )),
        centerTitle: true,
        flexibleSpace: Container(
            decoration: const BoxDecoration(
          gradient: LinearGradient(
            //shade
            colors: [
              Color.fromARGB(255, 239, 65, 123),
              Color.fromARGB(255, 244, 190, 110)
            ],
            // direction of shade
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        )),
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
                    color: Color.fromARGB(255, 92, 211, 154),
                    height: 100,
                  ),
                ),
              ),
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      //shade
                      colors: [
                        Color.fromARGB(255, 239, 65, 123),
                        Color.fromARGB(255, 244, 190, 110)
                      ],
                      // direction of shade
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  height: 80,
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 124, 171, 164),
          ),
          height: 550,
          width: MediaQuery.of(context).size.width - 30,
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder(
                  initialData: null,
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final sp = snapshot.data as SharedPreferences;
                      if (sp.getBool('infodemo') == false) {
                        return FutureBuilder(
                            initialData: null,
                            future: SharedPreferences.getInstance(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final sp = snapshot.data as SharedPreferences;
                                //statusinfo is a control parameter to understand which is the mood of MECO avatar
                                if (sp.getInt('statusinfo') == 1) {
                                  return const Text(
                                      'MeCo IS HAPPY, YOU HAVE SLEPT AND MOVED ENOUGH. IN ORDER TO MAKE MeCo HAPPIER, TRY TO DRINK AND MEDITATE A LITTLE BIT MORE!\n'
                                      '\n'
                                      '• SLEEPING BENEFITS '
                                      '\n'
                                      '\nSleep helps us to retain and consolidate memories. When a subject practice or learn new skills, sleep has a huge impact in forming new memories and it contributes to an improved performance in the future. \n'
                                      'Without sleep, the pathways in the brain that allow you to learn and make memories can’t be formed or maintained. Sleep is also essential for cognitive processing and for improving subjects’ mental health. In fact, quality of sleep is associated with an improved overall mood. An healthy sleep schedule prevents irritability and decreases the risk of developments of various conditions (such as depression). \n'
                                      '\n'
                                      '• ACTIVITY BENEFITS\n'
                                      '\n 1) Research shows that playing sports boosts blood flow to your brain. This enables your body to build more nerves\' connections within the brain. Thus it improves memory, stimulates creativity, and helps your brain develop better problem-solving skills. \n'
                                      '\n 2) One study reported that playing sports can improve brain function and it has a positive impact on your brain. In fact, playing sports can have a positive effect on the neural networks that support language comprehension.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'OpenSans',
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.justify);
                                } else if (sp.getInt('statusinfo') == 2) {
                                  return Column(
                                    children: [
                                      const Text(
                                        'TO MAKE MeCo HAPPIER, SLEEP MORE! PAY ATTENTION, SLEEP IS VERY IMPORTANT. \n'
                                        '\n'
                                        'Sleep plays a critical role in thinking and learning processes: the lack of sleep hurts these cognitive processes in many ways.'
                                        '\nFirstly, it impairs attention, alertness, concentration, reasoning, and problem solving. This makes it more difficult to learn efficiently.'
                                        ' Secondly, during the night, various sleep cycles play a role in “consolidating” memories in the mind. Thus, if you don’t get enough sleep, you won’t be able to remember what you\'ve learned and experienced during the day.',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'OpenSans',
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.justify,
                                      ),
                                      Container(
                                          height: 320,
                                          child: Image.asset(
                                              'assets/MeCo/idea.png'))
                                    ],
                                  );
                                } else if (sp.getInt('statusinfo') == 3) {
                                  return const Text(
                                    'MeCo IS WELL-RESTED, BUT TRY TO MAKE SOME SPORT TO MAKE HIM HAPPIER! '
                                    'In fact, there are 3 mainly advantages in doing sports: \n'
                                    ' \n• EXERCISE FEEDS THE BRAIN \n'
                                    'Remember that exercise increases blood flow to the brain. Due to its high metabolic demand, the brain demands good circulation and exercise aids it. An increase in blood flow is not only extremely beneficial, it is essential. Exercise induces good blood flow to deliver all the nutrients required to carry out brain’s activity, while it also increases the production of important molecules that are essential to the brain\'s functions.'
                                    '\n'
                                    ' \n• EXERCISE SECURES MEMORIES \n'
                                    'Exercise improves memory by increasing molecular targets, such as the brain-derived neurotrophic factor (BDNF). This molecular factor increases synaptogenesis (the creation of new synapses that mediate learning and memory) making it easier to absorb informations and form long-term memories. The more BDNF, the more our memory improves in function and capacity.'
                                    '\n'
                                    ' \n• EXERCISE LOWERS STRESS IMPACT \n'
                                    'Exercise is not a direct solution to stress, but it can greatly affects it. In fact, exercise does not decrease stress hormones, but it decreases the number of stress receptors in the hippocampus. This minimizes the effect of stress hormones on the brain, decreasing the impact of stressful experiences.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    textAlign: TextAlign.justify,
                                  );
                                } else if (sp.getInt('statusinfo') == 4) {
                                  return Column(
                                    children: [
                                      const Text(
                                          'MeCo IS VERY SAD! TO IMPROVE MeCo\'S WELL-BEING, TRY TO SLEEP MORE AND MAKE SOME SPORT! In fact, it is known that:'
                                          '\n'
                                          '\n• exercise increases blood flow to the brain. Due to its high metabolic demand, the brain demands good circulation and exercise aids it; \n'
                                          '• exercise improves memory;\n'
                                          '• exercise has a huge impact in managing stress;\n'
                                          '• a good sleep helps us to retain and consolidate memories; \n'
                                          '• a good sleep contributes to an improved sport performance; \n'
                                          '• without sleep, the pathways in the brain that allow you to learn and make memories can’t be performed or maintained; \n'
                                          '• sleep is essential for improving subjects’ mental health.\n',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'OpenSans',
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.justify),
                                      Container(
                                          height: 200,
                                          child: Image.asset(
                                              'assets/MeCo/idea.png'))
                                    ],
                                  );
                                } else if (sp.getInt('statusinfo') == 5) {
                                  return const Text(
                                    'CONGRATS! MeCo IS THE HAPPIEST BRAIN ON EARTH RIGHT NOW! You have: slept the right amount of hours, reached your activity goal, hydrated properly and meditated enough! \n'
                                    '\n                                    HYDRATATION \n'
                                    'Water helps your brain cells to communicate with each other, clears out toxins that impairs brain function and carries nutrients to your brain. This all falls apart if your fluid levels drop.'
                                    '\nStaying hydrated has been linked to:'
                                    '\n• faster decision making and improved performance on cognitive tests;'
                                    '\n• better concentration and enhanced short-term memory;'
                                    '\n• higher test scores in an educational context;'
                                    '\n• stronger cognitive functioning across the board, including more alertness, less confusion, and even improved learning.'
                                    '\n'
                                    '\n                                    MEDITATION \n'
                                    'Meditating strengthens neural connections and can change the configuration of these networks. With regular practice, you can cultivate a more resilient neurobiology that: '
                                    '\n•	contributes to a greater sense of well-being;'
                                    '\n•	helps to maintain brain health as you age;'
                                    '\n•	it alleviates mental stress;'
                                    '\n•	promotes an healthy, sustained focus;'
                                    '\n•	helps regulate the balance of vital hormones;'
                                    '\n•	with practice, it can also help you develop empathy and be more compassionate.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              } else {
                                return CircularProgressIndicator();
                              }
                            });
                      } else {
                        return FutureBuilder(
                            initialData: null,
                            future: SharedPreferences.getInstance(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final sp = snapshot.data as SharedPreferences;
                                if (sp.getInt('info') == 1) {
                                  return const Text(
                                      'MeCo IS HAPPY, YOU HAVE SLEPT AND MOVED ENOUGH. IN ORDER TO MAKE MeCo HAPPIER, TRY TO DRINK AND MEDITATE A LITTLE BIT MORE!\n'
                                      '\n'
                                      '• SLEEPING BENEFITS '
                                      '\n'
                                      '\nSleep helps us to retain and consolidate memories. When a subject practice or learn new skills, sleep has a huge impact in forming new memories and it contributes to an improved performance in the future. \n'
                                      'Without sleep, the pathways in the brain that allow you to learn and make memories can’t be formed or maintained. Sleep is also essential for cognitive processing and for improving subjects’ mental health. In fact, quality of sleep is associated with an improved overall mood. An healthy sleep schedule prevents irritability and decreases the risk of developments of various conditions (such as depression). \n'
                                      '\n'
                                      '• ACTIVITY BENEFITS\n'
                                      '\n 1) Research shows that playing sports boosts blood flow to your brain. This enables your body to build more nerves\' connections within the brain. Thus it improves memory, stimulates creativity, and helps your brain develop better problem-solving skills. \n'
                                      '\n 2) One study reported that playing sports can improve brain function and it has a positive impact on your brain. In fact, playing sports can have a positive effect on the neural networks that support language comprehension.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'OpenSans',
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.justify);
                                } else if (sp.getInt('info') == 2) {
                                  return Column(
                                    children: [
                                      const Text(
                                          'TO MAKE MeCo HAPPIER, SLEEP MORE! PAY ATTENTION, SLEEP IS VERY IMPORTANT. \n'
                                          '\n'
                                          'Sleep plays a critical role in thinking and learning processes: the lack of sleep hurts these cognitive processes in many ways.'
                                          '\nFirstly, it impairs attention, alertness, concentration, reasoning, and problem solving. This makes it more difficult to learn efficiently.'
                                          ' Secondly, during the night, various sleep cycles play a role in “consolidating” memories in the mind. Thus, if you don’t get enough sleep, you won’t be able to remember what you\'ve learned and experienced during the day.',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'OpenSans',
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.justify),
                                      Container(
                                          height: 320,
                                          child: Image.asset(
                                              'assets/MeCo/idea.png'))
                                    ],
                                  );
                                } else if (sp.getInt('info') == 3) {
                                  return const Text(
                                    'MeCo IS WELL-RESTED, BUT TRY TO MAKE SOME SPORT TO MAKE HIM HAPPIER! '
                                    'In fact, there are 3 mainly advantages in doing sports: \n'
                                    ' \n• EXERCISE FEEDS THE BRAIN \n'
                                    'Remember that exercise increases blood flow to the brain. Due to its high metabolic demand, the brain demands good circulation and exercise aids it. An increase in blood flow is not only extremely beneficial, it is essential. Exercise induces good blood flow to deliver all the nutrients required to carry out brain’s activity, while it also increases the production of important molecules that are essential to the brain\'s functions.'
                                    '\n'
                                    ' \n• EXERCISE SECURES MEMORIES \n'
                                    'Exercise improves memory by increasing molecular targets, such as the brain-derived neurotrophic factor (BDNF). This molecular factor increases synaptogenesis (the creation of new synapses that mediate learning and memory) making it easier to absorb informations and form long-term memories. The more BDNF, the more our memory improves in function and capacity.'
                                    '\n'
                                    ' \n• EXERCISE LOWERS STRESS IMPACT \n'
                                    'Exercise is not a direct solution to stress, but it can greatly affects it. In fact, exercise does not decrease stress hormones, but it decreases the number of stress receptors in the hippocampus. This minimizes the effect of stress hormones on the brain, decreasing the impact of stressful experiences.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  );
                                } else if (sp.getInt('info') == 4) {
                                  return Column(
                                    children: [
                                      const Text(
                                          'MeCo IS VERY SAD! TO IMPROVE MeCo\'S WELL-BEING, TRY TO SLEEP MORE AND MAKE SOME SPORT! In fact, it is known that:'
                                          '\n'
                                          '\n• exercise increases blood flow to the brain. Due to its high metabolic demand, the brain demands good circulation and exercise aids it; \n'
                                          '• exercise improves memory;\n'
                                          '• exercise has a huge impact in managing stress;\n'
                                          '• a good sleep helps us to retain and consolidate memories; \n'
                                          '• a good sleep contributes to an improved sport performance; \n'
                                          '• without sleep, the pathways in the brain that allow you to learn and make memories can’t be performed or maintained; \n'
                                          '• sleep is essential for improving subjects’ mental health.\n',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'OpenSans',
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.justify),
                                      Container(
                                          height: 200,
                                          child: Image.asset(
                                              'assets/MeCo/idea.png'))
                                    ],
                                  );
                                } else if (sp.getInt('info') == 5) {
                                  return const Text(
                                    'CONGRATS! MeCo IS THE HAPPIEST BRAIN ON EARTH RIGHT NOW! You have: slept the right amount of hours, reached your activity goal, hydrated properly and meditated enough! \n'
                                    '\n                                    HYDRATATION \n'
                                    'Water helps your brain cells to communicate with each other, clears out toxins that impairs brain function and carries nutrients to your brain. This all falls apart if your fluid levels drop.'
                                    '\nStaying hydrated has been linked to:'
                                    '\n• faster decision making and improved performance on cognitive tests;'
                                    '\n• better concentration and enhanced short-term memory;'
                                    '\n• higher test scores in an educational context;'
                                    '\n• stronger cognitive functioning across the board, including more alertness, less confusion, and even improved learning.'
                                    '\n'
                                    '\n                                    MEDITATION \n'
                                    'Meditating strengthens neural connections and can change the configuration of these networks. With regular practice, you can cultivate a more resilient neurobiology that: '
                                    '\n•	contributes to a greater sense of well-being;'
                                    '\n•	helps to maintain brain health as you age;'
                                    '\n•	it alleviates mental stress;'
                                    '\n•	promotes an healthy, sustained focus;'
                                    '\n•	helps regulate the balance of vital hormones;'
                                    '\n•	with practice, it can also help you develop empathy and be more compassionate.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.justify,
                                  );
                                } else {
                                  return CircularProgressIndicator();
                                }
                              } else {
                                return CircularProgressIndicator();
                              }
                            });
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  })),
        )
      ]),
      floatingActionButton: Builder(
        builder: (context) => FabCircularMenu(
          key: fabKey,
          alignment: Alignment(-1, -0.68),
          ringColor: Colors.white.withAlpha(0),
          ringDiameter: 300.0,
          ringWidth: 80,
          fabSize: 50.0,
          fabElevation: 8.0,
          fabIconBorder: CircleBorder(),
          // Also can use specific color based on wether
          // the menu is open or not:
          // fabOpenColor: Colors.white
          // fabCloseColor: Colors.white
          // These properties take precedence over fabColor
          fabColor: Colors.white,
          fabOpenIcon: Icon(Icons.info_outline, color: Colors.orange),
          fabCloseIcon: Icon(Icons.close, color: Colors.orange),
          fabMargin: const EdgeInsets.all(16.0),
          animationDuration: const Duration(milliseconds: 800),
          animationCurve: Curves.easeInOutCirc,
          onDisplayChange: (isOpen) async {
            if (isOpen) {
              final sp = await SharedPreferences.getInstance();
              sp.setBool('infodemo', true);
            } else {
              final sp = await SharedPreferences.getInstance();
              sp.setBool('infodemo', false);
              sp.remove('info');
              setState(() {});
            }
          },
          children: <Widget>[
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('info', 1);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child:
                  const Icon(FontAwesomeIcons.faceSmile, color: Colors.black),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('info', 2);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceDizzy, color: Colors.black),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('info', 3);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceMeh, color: Colors.black),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('info', 4);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: Icon(FontAwesomeIcons.faceSadCry, color: Colors.black),
            ),
            RawMaterialButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                sp.setInt('info', 5);
                setState(() {});
              },
              shape: CircleBorder(),
              padding: const EdgeInsets.all(24.0),
              child: const Icon(FontAwesomeIcons.faceLaughSquint,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
} //InfoPage
