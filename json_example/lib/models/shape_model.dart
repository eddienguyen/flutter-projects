/// Json structure #3: Simple Nested structures
/// For nested structures, make the classes and constructors first, and then add the factory methods from bottom level.
class Shape {
  String shapeName;
  Property shapeProperty;

  Shape({this.shapeName, this.shapeProperty});

  factory Shape.fromJson(Map<String, dynamic> parsedJson) {
    return Shape(
        shapeName: parsedJson['shape_name'],
        shapeProperty: Property.fromJson(parsedJson['property']));
  }
}

class Property {
  double width;
  double breadth;

  Property({this.width, this.breadth});

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(width: json['width'], breadth: json['breadth']);
  }
}
