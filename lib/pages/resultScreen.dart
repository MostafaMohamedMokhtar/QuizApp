import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quiz.dart';
class ResultScreen extends StatelessWidget {

  int score ;
  ResultScreen({this.score});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D046E),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Center(
                child: Image(
                  image: AssetImage('assets/images/quiz.jpeg'),
                  width: 300,
                  height: 300,
                ),
              ),
              Text(
                'Result',
                style: TextStyle(fontSize: 35, color: Color(0xFFA20CBE)),
              ),
              Text(
                '$score/10',
                style: TextStyle(fontSize: 60, color: Color(0xFFFFBA00)),
              ),
              Container(
                width: MediaQuery.of(context).size.width ,
                margin: EdgeInsets.symmetric(
                  vertical: 40 ,
                  horizontal: 30 ,
                ),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'RESTART',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  color: Color(0xFFFFBA00),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, QuizScreen.ROUTE ) ;
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width ,
                margin: EdgeInsets.symmetric(
                  horizontal: 30 ,
                ),
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'EXIT',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  color: Color(0xFF511AAB),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context) ;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
