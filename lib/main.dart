import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmotionsPage()
    );
  }
}

class EmotionsPage extends StatefulWidget {
  @override
  _EmotionsPageState createState() => _EmotionsPageState();
}

class _EmotionsPageState extends State<EmotionsPage> with SingleTickerProviderStateMixin{
  String feel = "0";
  double _value = 0;
  double lastSection = 0.0;
  String feedBackText = "Very Poor";
  Color backgroundColor = Colors.red;
  String howFeeling = "Very Poor";
  // Color endingColor;
  // Color startingColor = Colors.red;

  ///variables for the tween usage
  Color _lastColor = Colors.red;
  Color _nextColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      ///TWeen Animation Builder
      child: TweenAnimationBuilder(
        tween: ColorTween(begin: _lastColor, end: _nextColor), ///Start and end colors
        duration: Duration(milliseconds: 500),
        builder: (BuildContext context, Color color, _){
          return Scaffold(
            backgroundColor: color,
            body: Stack(
              children: <Widget> [
                Center(
                  child: FlareActor(
                    'assets/flares/feelings.flr',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    animation: feel,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Text(howFeeling,
                        style: TextStyle(
                          fontSize: 36,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),),
                    ),
                    Slider(
                      value: _value,
                      min: 0.0,
                      max: 100.0,
                      divisions: 100,
                      activeColor: Colors.blue,
                      label: "How satisfied are you?",
                      onChanged: (val){
                        ///Feeling really bad, slider at 0
                        setState(() {
                          _value = val;
                        });
                        if(_value == 0.0){
                          if(lastSection > 0.0){
                            setState(() {
                              feel = "0-";
                            });
                          }
                          setState(() {
                            lastSection = 0.0;
                            _lastColor = color;
                            _nextColor = Colors.red;
                            howFeeling = "Very Poor";
                          });
                        }
                        ///Feeling less bad, slider between 0-25
                        else if (_value > 0.0 && _value < 25.0){
                          if(lastSection == 0.0){
                            setState(() {
                              feel = "0+";
                            });
                          } else if (lastSection == 50.0){
                            setState(() {
                              feel = "25-";
                            });
                          }
                          setState(() {
                            lastSection = 25.0;
                            _lastColor = color;
                            _nextColor = Colors.orange;
                            howFeeling = "Poor";
                          });
                        }
                        /// feeling neutral, slider between 25-50
                        else if (_value >= 25.0 && _value < 50.0){
                          if(lastSection == 25.0){
                            setState(() {
                              feel = "25+";
                            });
                          } else if (lastSection == 75.0){
                            setState(() {
                              feel = "50-";
                            });
                          }
                          setState(() {
                            lastSection = 50.0;
                            _lastColor = color;
                            _nextColor = Colors.yellow;
                            howFeeling = "Okay";
                          });
                        }
                        ///Feleing okay, slider between 50-75
                        else if (_value >= 50.0 && _value < 75.0){
                          if (lastSection == 50.0){
                            setState(() {
                              feel = "50+";
                            });
                          } else if (lastSection == 100 ){
                            setState(() {
                              feel = "75-";
                            });
                          }
                          setState(() {
                            lastSection = 75.0;
                            _lastColor = color;
                            _nextColor = Colors.lightGreen;
                            howFeeling = "Good";
                          });
                        }
                        ///Feeling pretty good, slider between 75-100
                        else if(_value >= 75.0 && _value <=100){
                          if(lastSection == 75){
                            setState(() {
                              feel = "75+";
                            });
                          }
                          setState(() {
                            lastSection = 100;
                            _lastColor = color;
                            _nextColor = Colors.green;
                            howFeeling = "Excellent";
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
