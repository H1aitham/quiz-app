// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:quizapp/config/get_it_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

PageController controller = PageController();

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDA8BD9),
      body: FutureBuilder(
        future: getQuiz(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PageView.builder(
              controller: controller,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Scaffold(
                  backgroundColor: Color(0xff914576),
                  body: Padding(
                    padding: const EdgeInsets.all(35),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              // height: double.maxFinite,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.centerRight,
                                  image: AssetImage(
                                    'assets/images/thunderbolt 2.png',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                        ),
                        ListTile(
                          title: Container(
                            width: 281,
                            height: 205,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(29),
                                gradient: LinearGradient(colors: [
                                  Color(0xffDA8BD9),
                                  Color(0xffF3BD6B)
                                ])),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data![index].question,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data![index].answer.length,
                            itemBuilder: (context, ind) {
                              return Dismissible(
                                key: GlobalKey(),
                                child: ListTile(
                                  onTap: () {
                                    if (ind ==
                                        snapshot.data![index].indexOfCorrect) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        showCloseIcon: true,
                                        action: SnackBarAction(
                                            label: 'Undo', onPressed: () {}),
                                        duration: Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        content: Text("Success"),
                                        backgroundColor: Color(0xff1F8435),
                                      ));

                                      if (index == snapshot.data!.length - 1) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HelloPage(),
                                          ),
                                        );
                                      } else {
                                        controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          showCloseIcon: true,
                                          duration: Duration(seconds: 2),
                                          behavior: SnackBarBehavior.floating,
                                          content: Text("Wrong answer"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                    ;
                                  },
                                  title: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Container(
                                        width: 240,
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data![index].answer[ind],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<List<QuizModel>> getQuiz() async {
  Dio req = Dio();
  Response response =
      await req.get("https://6640c46da7500fcf1a9ea9fb.mockapi.io/ex");
  print(response);
  List<QuizModel> quiz = List.generate(
    response.data.length,
    (index) => QuizModel.fromMap(response.data[index]),
  );
  print(quiz);
  return quiz;
}

class QuizModel {
  String question;
  List<String> answer;
  num indexOfCorrect;
  QuizModel({
    required this.question,
    required this.answer,
    required this.indexOfCorrect,
  });

  QuizModel copyWith({
    String? question,
    List<String>? answer,
    num? indexOfCorrect,
  }) {
    return QuizModel(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      indexOfCorrect: indexOfCorrect ?? this.indexOfCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answer': answer,
      'indexOfCorrect': indexOfCorrect,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      question: map['question'] as String,
      answer: List.generate(
        map['answer'].length,
        (index) => map['answer'][index],
      ),
      indexOfCorrect: map['indexOfCorrect'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) =>
      QuizModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'QuizModel(question: $question, answer: $answer, indexOfCorrect: $indexOfCorrect)';

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;

    return other.question == question &&
        listEquals(other.answer, answer) &&
        other.indexOfCorrect == indexOfCorrect;
  }

  @override
  int get hashCode =>
      question.hashCode ^ answer.hashCode ^ indexOfCorrect.hashCode;
}

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8D376F),
      body: Center(
          child: Container(
        width: 220,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient:
                LinearGradient(colors: [Color(0xffDA8BD9), Color(0xffF3BD6B)])),
        child: Text(
          "Hello .${core.get<SharedPreferences>().getString('email')}",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      )),
    );
  }
}
