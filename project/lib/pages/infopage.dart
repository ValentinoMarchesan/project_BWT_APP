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
                        return const Text(
                            'IMPORTANCE OF SLEEP AND ACTIVITY \n'
                            'Sleep helps everyone to retain and consolidate memories. When a subject practice or learn new skills, sleep helps form memories, and contributes to improved performance in the future. \n'
                            'Without sleep, the pathways in the brain that allow you to learn and make memories can’t be performed or maintained. Sleep is also essential for cognitive processing. Also, just as exercise can help improve or maintain mental health, sleep is important for maintaining subjects’ mental health. Quality sleep is associated with improving overall mood. Healthy sleep prevents irritability and decreases the risk of developments such as depression. \n'
                            '\nTHE BENEFIT OF ACTIVITY '
                            '\n • Research shows that playing sports boosts blood flow to your brain. This enables your body to build more connections between nerves within the brain. This improves memory, stimulates creativity, and helps your brain develop better problem-solving skills. \n'
                            '\n • One study found that playing sports can improve brain function. It also showed that just being a sports fan may have a positive impact on your brain. Playing or watching sports can have an effect on the neural networks that support language comprehension.',
                            style:
                                TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                            textAlign: TextAlign.start);
                      } else if (sp.getInt('statusinfo') == 2) {
                        return Column(
                          children: [
                            const Text(
                              'PAY ATTENTION: SLEEP IS VERY IMPORTANT \n'
                              'Sleep plays a critical role in thinking and learning. Lack of sleep hurts these cognitive processes in many ways. First, it impairs attention, alertness, concentration, reasoning, and problem solving. This makes it more difficult to learn efficiently. Second, during the night, various sleep cycles play a role in “consolidating” memories in the mind. If you don’t get enough sleep, you won’t be able to remember what you learned and experienced during the day.',
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                              textAlign: TextAlign.start,
                            ),
                            Container(
                                height: 320,
                                child: Image.asset('assets/MeCo/idea.png'))
                          ],
                        );
                      } else if (sp.getInt('statusinfo') == 3) {
                        return const Text(
                          'OK,YOU HAVE SLEEP ENOUGH HOURS BUT REMEMBER TO DO SPORT \n'
                          'in fact there are three mainly advantages in doing sport: '
                          '\n        EXERCISE FEEDS THE BRAIN \n'
                          'Exercise increases blood flow to the brain. Due to its high metabolic demand, the brain demands good circulation, and exercise aids it. An increase in blood flow is not only extremely beneficial, it is essential. Exercise induces good blood flow to deliver all the nutrients required to carry out the brain’s job, while it also increases production molecules important to brain function, including memory.'
                          '\n         EXERCISE SECURE PRICELES MEMORIES \n'
                          'Exercise improves memory by increasing molecular targets like the brain-derived neurotrophic factor (BDNF). This molecular factor increases synaptogenesis, forming new synapses that mediate learning and memory, making it easier to absorb information and form long-term memories. The more BDNF, the more the memory improves in function and capacity.'
                          '\n         EXERCISE LOWERS STRESS IMPACT \n'
                          'Exercise is not a direct solution to stress, but it does pacify the experience. It is important to note that exercise does not decrease stress hormones, but it does decrease the number of stress receptors in the hippocampus. Reducing stress receptors minimizes the effect of stress hormones on the brain, decreasing the impact of stressful experiences.',
                          style: TextStyle(fontSize: 14, fontFamily: 'Roboto'),
                          textAlign: TextAlign.start,
                        );
                      } else if (sp.getInt('statusinfo') == 4) {
                        return Column(
                          children: [
                            const Text(
                                'PAY ATTENTION: TRY TO SLEEP MORE HOURS AND TRY TO MAKE SOME SPORTS \n'
                                'because: \n - Exercise increases blood flow to the brain. Due to its high metabolic demand, the brain demands good circulation, and exercise aids it; \n'
                                '• Exercise improves memory;\n'
                                '• Exercise help in contrasting stress.\n'
                                '• Sleep helps everyone to retain and consolidate memories; \n'
                                '• Sleep contributes to improved sport performance; \n'
                                '• Without sleep, the pathways in the brain that allow you to learn and make memories can’t be performed or maintained; \n'
                                '• Sleep is important for maintaining subjects’ mental health.\n',
                                style: TextStyle(
                                    fontSize: 14, fontFamily: 'Roboto'),
                                textAlign: TextAlign.start),
                            Container(
                                height: 200,
                                child: Image.asset('assets/MeCo/idea.png'))
                          ],
                        );
                      } else if (sp.getInt('statusinfo') == 5) {
                        return const Text(
                          'SUPER! YOU SLEEP THE NEEDED HOURS, YOU PLAYING SPORTS, YOU HYDRATE AND YOU DO MEDITATION \n'
                          '\n focusing on hydratation and meditation: \n'
                          '\n                                    HYDRATATION \n'
                          'Water helps your brain cells communicate with each other, clears out toxins and waste that impairs brain function, and carries nutrients to your brain. This all falls apart if your fluid levels drop.'
                          'Staying hydrated has been linked to:'
                          '\n •	Faster decision making and improved performance on cognitive tests;'
                          '\n •	Better concentration and enhanced short-term memory;'
                          '\n •	Higher test scores in an educational context;'
                          '\n •	Improved focus and decreased mental fatigue;'
                          '\n •	Stronger cognitive functioning across the board, including more alertness, less confusion, and even improved learning.'
                          '\n '
                          '\n                                    MEDITATION \n'
                          'Meditation benefits for the brain are abundant. Meditating strengthens neural connections and can literally change the configuration of these networks. With regular practice, you can cultivate a more resilient neurobiology that: '
                          '\n•	Contributes to a greater sense of well-being;'
                          '\n•	Helps to maintain brain health as you age;'
                          '\n•	Aids in alleviating mental stress;'
                          '\n•	Promotes healthy, sustained focus;'
                          '\n•	help regulate the balance of vital hormones;'
                          '\n•	with practice, meditation can also help you develop empathy and be more compassionate.',
                          style: TextStyle(fontSize: 13, fontFamily: 'Roboto'),
                          textAlign: TextAlign.start,
                        );
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
