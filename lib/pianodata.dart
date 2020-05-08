import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sheet_music/sheet_music.dart';

enum Note {
  A, B, C, D, E, F, G
}

String NoteEnumToString(Note note) {
  return note.toString().substring(5, 6);
}

class PianoData {

  PianoData() {
    noteAnswer = _generateNoteAnswer();
    sheet = SheetMusic(
      trebleClef: true,
      pitch: "${NoteEnumToString(noteAnswer)}4",
      scale: "C",
    );
    buttons = _generateButtons();
  }

  void GenerateNextQuizQuestion(bool isTrebleClef) {
    userAnswer = Note.A;
    noteAnswer = _generateNoteAnswer();
    int pitch;
    isTrebleClef ? pitch = 4 : pitch = 3;
    sheet = SheetMusic(
      trebleClef: isTrebleClef,
      pitch: "${NoteEnumToString(noteAnswer)}${pitch}",
      scale: "C",
    );
    buttons = _generateButtons();
  }

  List<RadioListTile<Note>> _generateButtons() {
    List<RadioListTile<Note>> radioButtons = [];
    _notes.forEach((note) {
      radioButtons.add(RadioListTile(
        title: Text(NoteEnumToString(note)),
        onChanged: (Note value) {
          userAnswer = value;
        },
        value: note,
        groupValue: userAnswer,
      ));
    });
    radioButtons.shuffle();
    return radioButtons;
  }

  // Picks a random note from a list as an answer
  Note _generateNoteAnswer() {
    return _notes.elementAt(Random().nextInt(_notes.length));
  }

  SheetMusic sheet;
  List<RadioListTile> buttons = [];
  Note noteAnswer;
  Note userAnswer;
  static const List<Note> _notes = [Note.A, Note.B, Note.C, Note.D, Note.E, Note.F, Note.G];
}