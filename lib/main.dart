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
    return Container();
  }

  Widget getHistoryPage() {
    return Container();
  }

  Widget getChartPage() {
    return Container();
  }
}
