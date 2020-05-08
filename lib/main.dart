import 'package:flutter/material.dart';
import 'package:flutterpiano/pianodata.dart';
import 'package:sheet_music/sheet_music.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Piano Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PianoQuizPage(),
    );
  }
}

class PianoQuizPage extends StatefulWidget {
  @override
  _PianoQuizPageState createState() => _PianoQuizPageState();
}

class _PianoQuizPageState extends State<PianoQuizPage> {

  PianoData pianoData = PianoData();
  bool isTrebleClef = true;

  List<RadioListTile> buttons = [];
  List<RadioListTile> generateButtons() {
    List<RadioListTile<Note>> radioButtons = [];
    Note.values.forEach((note) {
      radioButtons.add(RadioListTile(
        title: Text(NoteEnumToString(note)),
        onChanged: (Note value) {
          setState(() {
            pianoData.userAnswer = value;
          });
        },
        value: note,
        groupValue: pianoData.userAnswer,
      ));
    });
    return radioButtons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Piano Notes'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info), onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InfoPage()),
            );
          },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                SwitchListTile(
                  title: Text("Bass Clef / Trebble Clef"),
                  value: isTrebleClef,
                  secondary: Icon(Icons.queue_music),
                  onChanged: (newVal) {
                    setState(() {
                      isTrebleClef = newVal;
                      pianoData.GenerateNextQuizQuestion(isTrebleClef);
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        buttons.clear();
                        setState(() {
                          bool isAnswerCorrect = pianoData.userAnswer == pianoData.noteAnswer;
                          if (!isAnswerCorrect) {
                            SheetMusic incorrectSheet = pianoData.sheet;
                            showAlertDialog(context, pianoData.noteAnswer, incorrectSheet);
                          }
                          pianoData.GenerateNextQuizQuestion(isTrebleClef);
                        });
                      },
                      color: Color(0xFF2196f3),
                      textColor: Colors.white,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      child: Text("Confirm"),
                    ),
                    pianoData.sheet,
                  ],
                ),
              ],
            ),
            Column(
              children: generateButtons(),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, Note correctAnswer, SheetMusic sheet) {
    AlertDialog alert = AlertDialog(
      title: Text("Correct answer was ${NoteEnumToString(correctAnswer)}"),
      content: sheet,
      actions: <Widget>[
        FlatButton(
          child: Text("Close"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Learn Piano Notes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            Text("Created by Matthew Zegar",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 22.0,
              ),
            ),
            FlatButton(
              onPressed: () => launch("https://github.com/mzegar"),
              child: Text("https://github.com/mzegar",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.lightBlue,
                  fontSize: 22.0,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
