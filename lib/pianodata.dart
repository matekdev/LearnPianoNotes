import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sheet_music/sheet_music.dart';

enum Note {
  A, B, C, D, E, F, G
}

// Converts enum Note.A to string "A"
// @Param Note to convert Note.A
// @Return String in format "A"
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
  }

  // Generates the next question in the quiz
  void GenerateNextQuizQuestion(bool isTrebleClef) {
    // User answer is set to A as default due to radio buttons
    userAnswer = Note.A;
    noteAnswer = _generateNoteAnswer();
    int pitch;
    isTrebleClef ? pitch = 4 : pitch = 3;
    sheet = SheetMusic(
      trebleClef: isTrebleClef,
      pitch: "${NoteEnumToString(noteAnswer)}${pitch}",
      scale: "C",
    );
  }

  // Picks a random note from a list as an answer
  Note _generateNoteAnswer() {
    return _notes.elementAt(Random().nextInt(_notes.length));
  }

  SheetMusic sheet;
  Note noteAnswer;
  Note userAnswer;
  static const List<Note> _notes = [Note.A, Note.B, Note.C, Note.D, Note.E, Note.F, Note.G];
}