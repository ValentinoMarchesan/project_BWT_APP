import 'package:fitbitter/fitbitter.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:project/chart/databaseRepository.dart';
import 'package:project/chart/heart.dart';
import 'package:project/chart/heart_chart.dart';
import 'package:project/chart/heartseries.dart';
import 'package:project/utils/strings.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Homepage screen. It will show the list of meals.
class HeartPage3 extends StatefulWidget {
  var heart;

  HeartPage3({Key? key}) : super(key: key);

  static const route = '/home/heart2';
  static const routename = 'Heartpage2';

  @override
  State<HeartPage3> createState() => _HeartPage3State();
}

class _HeartPage3State extends State<HeartPage3> {
  //late
  List<HeartSeries> data_series = [];

  void initState() {
    widget.heart == null ? 0 : widget.heart!.heart;
    super.initState();
  }

  //late List<Heart> data_heart;
  @override
  Widget build(BuildContext context) {
    print('${HeartPage3.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(HeartPage3.routename),
      ),
      body: Center(
          child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
        return FutureBuilder(
          initialData: null,
          future: dbr.findAllHeart(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data as List<Heart>;

              TestDellaVita(context);
              return HeartChart(data: data_series);
            } else {
              return CircularProgressIndicator();
            }
          },
        );
      })),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          // prova = await SharedPreferences.getInstance();
          final sp = await SharedPreferences.getInstance();

          //STEP1: Instanciate a menager
          FitbitHeartDataManager fitbitHeartDataManager =
              FitbitHeartDataManager(
            clientID: Strings.fitbitClientID,
            clientSecret: Strings.fitbitClientSecret,
          );

          //STEP2: Create the request url
          FitbitHeartAPIURL fitbitHeartApiUrl = FitbitHeartAPIURL.dayWithUserID(
              date: DateTime.now().subtract(Duration(days: 5)),
              userID: sp.getString('userid'));
          // userID: prova.getString('userid'));

          //STEP3: Get the data

          final fitbitHeartData = await fitbitHeartDataManager
              .fetch(fitbitHeartApiUrl) as List<FitbitHeartData>;

          if (widget.heart == null) {
            Heart dato1 = Heart(1, fitbitHeartData[0].minimumOutOfRange);
            await Provider.of<DatabaseRepository>(context, listen: false)
                .insertHeart(dato1);

            Heart dato2 = Heart(1, fitbitHeartData[0].minimumFatBurn);
            await Provider.of<DatabaseRepository>(context, listen: false)
                .insertHeart(dato2);

            Heart dato3 = Heart(1, fitbitHeartData[0].minimumCardio);
            await Provider.of<DatabaseRepository>(context, listen: false)
                .insertHeart(dato3);

            Heart dato4 = Heart(1, fitbitHeartData[0].minimumPeak);
            await Provider.of<DatabaseRepository>(context, listen: false)
                .insertHeart(dato4);
          } else {
            Heart updatedata1 = Heart(1, fitbitHeartData[0].minimumOutOfRange);
            await Provider.of<DatabaseRepository>(context, listen: false)
                .updateHeart(updatedata1);

            Heart updatedata2 = Heart(1, fitbitHeartData[0].minimumFatBurn);
            await Provider.of<DatabaseRepository>(context, listen: false)
                .updateHeart(updatedata2);

            Heart updatedata3 = Heart(1, fitbitHeartData[0].minimumCardio);
            await Provider.of<DatabaseRepository>(context, listen: false)
                .updateHeart(updatedata3);

            Heart updatedata4 = Heart(1, fitbitHeartData[0].minimumPeak);
            await Provider.of<DatabaseRepository>(context, listen: false)
                .updateHeart(updatedata4);
          }
        },
        child: Text('tap to fetch today hearth data'),
      ),
    );
  }

  void TestDellaVita(BuildContext context) async {
    List? data;
    Heart? time_OutRange = Heart(1, data![0]);
    await Provider.of<DatabaseRepository>(context, listen: false)
        .findminutes(1);
    Heart? time_FatBurn = Heart(2, data[1]);
    await Provider.of<DatabaseRepository>(context, listen: false)
        .findminutes(2);
    Heart? time_Cardio = Heart(3, data[2]);
    await Provider.of<DatabaseRepository>(context, listen: false)
        .findminutes(3);
    Heart? time_Peak = Heart(4, data[4]);
    await Provider.of<DatabaseRepository>(context, listen: false)
        .findminutes(4);
    data_series = [
      HeartSeries.creation(
          'Out of Range',
          //fitbitHeartData[0].minutesOutOfRange,
          time_OutRange.minute,
          charts.ColorUtil.fromDartColor(Colors.red)),
      HeartSeries.creation(
          'Fat Burn',
          // fitbitHeartData[0].minutesFatBurn,
          time_FatBurn.minute,
          charts.ColorUtil.fromDartColor(Colors.orangeAccent)),
      HeartSeries.creation(
          'Cardio',
          // fitbitHeartData[0].minutesCardio,
          time_Cardio.minute,
          charts.ColorUtil.fromDartColor(Colors.black12)),
      HeartSeries.creation(
          'Peak',
          // fitbitHeartData[0].minutesPeak,
          time_Peak.minute,
          charts.ColorUtil.fromDartColor(Colors.blue))
    ];
  }
} //Page