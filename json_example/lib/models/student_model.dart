/// JSON Structure #1: Simple map

///PODO (Plain Old Dart Object)
class Student {
  String studentID;
  String studentname;
  int studentScores;

  Student({this.studentID, this.studentname, this.studentScores});

  /// Converter method
  /// Using 'factory' keyword for constructor that doesn't always create an instance of a class
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
        studentID: parsedJson['id'],
        studentname: parsedJson['name'],
        studentScores: parsedJson['score']);
  }
}
