/// JSON structure #6 : Complex nested structures
class Page {
  int pageNumber;
  int perPage;
  int totalPeople;
  int totalPages;
  Author author;
  List<Person> people;

  Page(
      {this.pageNumber,
      this.perPage,
      this.totalPeople,
      this.totalPages,
      this.author,
      this.people});

  factory Page.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;

    List<Person> dataList =
        list.map((person) => Person.fromJson(person)).toList();

    return Page(
        pageNumber: parsedJson['page'],
        perPage: parsedJson['per_page'],
        totalPeople: parsedJson['total'],
        totalPages: parsedJson['total_pages'],
        author: Author.fromJson(parsedJson['author']),
        people: dataList);
  }
}

class Author {
  String firstName;
  String lastName;

  Author({this.firstName, this.lastName});

  factory Author.fromJson(Map<String, dynamic> parsedJson) {
    return Author(
      firstName: parsedJson['first_name'],
      lastName: parsedJson['last_name'],
    );
  }
}

class Person {
  int id;
  String firstName;
  String lastName;
  String avatarUrl;
  List<Image> images;

  Person({
    this.id,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.images,
  });

  factory Person.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['images'] as List;

    List<Image> imgList = list.map((img) => Image.fromJson(img)).toList();

    return Person(
      id: parsedJson['id'],
      firstName: parsedJson['first_name'],
      lastName: parsedJson['last_name'],
      avatarUrl: parsedJson['avatar'],
      images: imgList,
    );
  }
}

class Image {
  int id;
  String imageName;

  Image({this.id, this.imageName});

  factory Image.fromJson(Map<String, dynamic> parsedJson) {
    return Image(
      id: parsedJson['id'],
      imageName: parsedJson['imageName'],
    );
  }
}
