import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_app/pages/quiz.dart';

class Home extends StatelessWidget {
  // ignore: non_constant_identifier_names
  static final ROUTE = '/';

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
                'Quiz',
                style: TextStyle(fontSize: 90, color: Color(0xFFA20CBE)),
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
                    'PLAY',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
