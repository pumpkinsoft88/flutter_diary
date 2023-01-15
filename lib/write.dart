import 'package:diary/data/database.dart';
import 'package:diary/data/diary.dart';
import 'package:flutter/material.dart';

class DiaryWritePage extends StatefulWidget {
  final Diary diary;

  const DiaryWritePage({Key key, this.diary}) : super(key: key);

  @override
  State<DiaryWritePage> createState() => _DiaryWritePageState();
}

class _DiaryWritePageState extends State<DiaryWritePage> {
  List<String> images = [
    "assets/img/b1.jpg",
    "assets/img/b2.jpg",
    "assets/img/b3.jpg",
    "assets/img/b4.jpg",
  ];

  List<String> statusImg = [
    "assets/img/ico-weather.png",
    "assets/img/ico-weather_2.png",
    "assets/img/ico-weather_3.png",
  ];

  int imgIndex = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.diary.title;
    memoController.text = widget.diary.memo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                await dbHelper.insertDiary(widget.diary);
                Navigator.of(context).pop();
              },
              child: const Text(
                "저장",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          if (idx == 0) {
            return InkWell(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                width: 100,
                height: 100,
                child: Image.asset(
                  widget.diary.image,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                setState(() {
                  widget.diary.image = images[imgIndex];
                  imgIndex++;
                  imgIndex = imgIndex % images.length;
                });
              },
            );
          } else if (idx == 1) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(statusImg.length, (idx) {
                    return InkWell(
                      child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: idx == widget.diary.status
                                    ? Colors.blue
                                    : Colors.transparent),
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(
                          statusImg[idx],
                          fit: BoxFit.contain,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          widget.diary.status = idx;
                        });
                      },
                    );
                  })),
            );
          } else if (idx == 2) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: const Text(
                "제목",
                style: TextStyle(fontSize: 20),
              ),
            );
          } else if (idx == 3) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: nameController,
              ),
            );
          } else if (idx == 4) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: const Text("내용", style: TextStyle(fontSize: 20)),
            );
          } else if (idx == 5) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: TextField(
                controller: nameController,
                minLines: 10,
                maxLines: 20,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              ),
            );
          }

          return Container();
        },
        itemCount: 6,
      ),
    );
  }
}
