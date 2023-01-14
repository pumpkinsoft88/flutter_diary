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

  int imgIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {},
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
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  widget.diary.image,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                widget.diary.image = images[imgIndex];
                imgIndex++;
                imgIndex = imgIndex % images.length;
              },
            );
          } else if (idx == 1) {
            return Container();
          }

          return Container();
        },
        itemCount: 6,
      ),
    );
  }
}
