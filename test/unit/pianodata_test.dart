import 'package:test/test.dart';
import 'package:flutterpiano/pianodata.dart';

void main() {
  test('Note Enum to String', () {
    Note.values.forEach((note) {
      String noteString = NoteEnumToString(note);
      String noteEnumString = note.toString();
      expect(noteEnumString.substring(noteEnumString.length - 1), noteString);
    });
  });

  test('PianoData constructor', () {
    PianoData pianoData = PianoData();
    expect(true, pianoData.noteAnswer is Note);
  });

  test('GenerateNextQuizQuestion', () {
    PianoData pianoData = PianoData();

    pianoData.GenerateNextQuizQuestion(true);
    expect(Note.A, pianoData.userAnswer);
    expect(true, pianoData.noteAnswer is Note);
    expect(true, pianoData.sheet.trebleClef);

    pianoData.GenerateNextQuizQuestion(false);
    expect(false, pianoData.sheet.trebleClef);
  });
}