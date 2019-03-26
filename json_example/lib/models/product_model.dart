/// JSON structure #4 : Nested structures with Lists

class Product {
  int productID;
  String productName;
  List<Image> productImages;

  Product({this.productID, this.productName, this.productImages});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['images'] as List;  // <= this is List<dynamic>
    
    /// iterate over 'list' and map each object in list to 'Image' by calling [Image.fromJson] 
    /// then put each map object into a new list with 'toList()' 
    /// and store it in 'List<Image> imagesList'.
    List<Image> imagesList =
        list.map((img) => new Image.fromJson(img)).toList();

    // print(imagesList.runtimeType); // <= returns List<Image>

    return Product(
      productID: parsedJson['id'],
      productName: parsedJson['name'],
      productImages: imagesList,
    );
  }
}

class Image {
  int imageID;
  String imageName;

  Image({this.imageID, this.imageName});

  factory Image.fromJson(Map<String, dynamic> parsedJson) {
    return Image(imageID: parsedJson['id'], imageName: parsedJson['imageName']);
  }
}
