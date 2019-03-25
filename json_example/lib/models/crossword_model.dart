class Crossword {
  int id;
  String name;
  List<Word> words = [];

  // Crossword(this.id, this.name, this.across);

  Crossword.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    name = parsedJson['name'];
    List<Word> temp = [];
    parsedJson['across'].forEach((word) => temp.add(new Word(word)));

    words = temp;
  }
}

class Word {
  int number;
  String word;

  Word(word) {
    number = word['number'];
    word = word['word'];
  }

  // Word(this.number, this.word);
}
