class Crossword {
  int id;
  String name;
  List<Word> across = [];

  // Crossword(this.id, this.name, this.across);

  Crossword.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'];
    List<Word> words = [];
    parsedJson['across'].forEach((word) => words.add(new Word(word)));

    across = words;
  }
}

class Word {
  int _number;
  String _word;

  Word(word) {
    _number = word['number'];
    _word = word['word'];
  }

  int get number => number;
  String get word => _word;

  // Word(this.number, this.word);
}
