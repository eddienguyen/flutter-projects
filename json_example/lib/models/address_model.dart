/// JSON structure #2 : Simple structure with arrays

class Address {
  String city;
  List<String> streets;

  Address({this.city, this.streets});

  factory Address.fromJson(Map<String, dynamic> parsedJSON) {
    /// maping variable streetsFromJson to the streets entity
    /// 'streetsFromJson' is still a List<dynamic>
    var streetsFromJson = parsedJSON['streets'];
    // print(streetsFromJson.runtimeType); // <= returns List<dynamic>

    /// explicity create a List<String> streetList that contains all elements from streetsFromJson
    // List<String> streetList = new List<String>.from(streetsFromJson);
    List<String> streetList = streetsFromJson.cast<String>();

    return Address(city: parsedJSON['city'], streets: streetList);
  }
}
