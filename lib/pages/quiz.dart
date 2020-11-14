import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/pages/QuizHelper.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/pages/resultScreen.dart';

class QuizScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  static final ROUTE = '/quiz';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String apiURL =
      "https://opentdb.com/api.php?amount=10&category=18&type=multiple";

  QuizHelper quizHelper;
  int currentQuestion = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int totalSeconds = 30;

  int elapsedSeconds = 0;

  Timer timer;
  int score = 0 ;

  @override
  void initState() {
    fetchAllQuiz();
    super.initState();
  }

  void initTimer() {
    timer = Timer.periodic(
        Duration(seconds: 1),
            (t) {
      if (t.tick == totalSeconds) {
        print('time completed ');
        t.cancel();
        changeQuestion() ;
      }
      else{
        setState(() {
          elapsedSeconds = t.tick ;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void fetchAllQuiz() async {
    var response = await http.get(apiURL);
    var body = response.body;
    var json = jsonDecode(body);

    setState(() {
      quizHelper = QuizHelper.fromJson(json);
      quizHelper.results[currentQuestion].incorrectAnswers
          .add(quizHelper.results[currentQuestion].correctAnswer
      );
      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();

      initTimer();
    });

  }


  void showInSnackBar(value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      duration: Duration(seconds: 2),
    ));
  }

  void checkAnswer(answer) {
    String correctAnswer = quizHelper.results[currentQuestion].correctAnswer;
    if (correctAnswer == answer) {
      showInSnackBar("correct");
      score += 1 ;
    } else {
      showInSnackBar("wrong");
    }
    changeQuestion() ;
  }
  changeQuestion(){
    timer.cancel() ;
    if(currentQuestion == quizHelper.results.length -1 ){
      showInSnackBar('Quiz completed and your score = $score') ;

      // Navigation
      Navigator.pushReplacement(context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(score: score,),
          ));

    }else{
      setState(() {
        currentQuestion += 1 ;
      });
      quizHelper.results[currentQuestion].incorrectAnswers.add(
          quizHelper.results[currentQuestion].correctAnswer) ;
      quizHelper.results[currentQuestion].incorrectAnswers.shuffle();
      initTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (quizHelper != null) {
      return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF2D046E),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('assets/images/quiz.jpeg'),
                        width: 80,
                        height: 80,
                      ),
                      Text(
                        '$elapsedSeconds s',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Q. ${quizHelper.results[currentQuestion].question}',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    children: quizHelper
                        .results[currentQuestion].incorrectAnswers
                        .map((option) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          color: Color(0xFF511AAB),
                          colorBrightness: Brightness.dark,
                          onPressed: () {
                            checkAnswer(option);
                          },
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } // end if
    else {
      return Scaffold(
        backgroundColor: Color(0xFF2D046E),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  } // end build()

}
