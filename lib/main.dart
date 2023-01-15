import 'package:diary/data/database.dart';
import 'package:diary/data/diary.dart';
import 'package:diary/data/util.dart';
import 'package:diary/write.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectIndex = 0;
  final dbHelper = DatabaseHelper.instance;
  Diary todayDiary;

  List<String> statusImg = [
    "assets/img/ico-weather.png",
    "assets/img/ico-weather_2.png",
    "assets/img/ico-weather_3.png",
  ];

  void getTodayDiary() async {
    List<Diary> diary =
        await dbHelper.getDiaryByDate(Utils.getFormatTime(DateTime.now()));
    if (diary.isNotEmpty) {
      todayDiary = diary.first;

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getTodayDiary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Container(
        child: getPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => DiaryWritePage(
                    diary: Diary(
                      date: Utils.getFormatTime(DateTime.now()),
                      title: "",
                      memo: "",
                      status: 0,
                      image: "assets/img/b1.jpg",
                    ),
                  )));
          getTodayDiary();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: "오늘",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: "기록",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: "통계",
          ),
        ],
        onTap: (idx) {
          setState(() {
            selectIndex = idx;
          });
        },
      ),
    );
  }

  Widget getPage() {
    if (selectIndex == 0) {
      return getTodayPage();
    } else if (selectIndex == 1) {
      return getHistoryPage();
    } else {
      return getChartPage();
    }
  }

  Widget getTodayPage() {
    if (todayDiary == null) {
      return Container(
        child: const Text("일기를 작성해 주세요!"),
      );
    }
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              todayDiary.image,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${DateTime.now().month}.${DateTime.now().day}",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Image.asset(
                      statusImg[todayDiary.status],
                      fit: BoxFit.contain,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getHistoryPage() {
    return Container();
  }

  Widget getChartPage() {
    return Container();
  }
}
