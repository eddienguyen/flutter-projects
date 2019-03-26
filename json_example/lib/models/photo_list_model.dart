/// JSON structure #5 : List of maps
import './photo_model.dart';

class PhotoList {
  List<Photo> photoList;

  PhotoList({this.photoList});

  factory PhotoList.fromJson(List<dynamic> parsedJson) {
    List<Photo> photos =
        parsedJson.map((photo) => Photo.fromJson(photo)).toList();
        
    return PhotoList(photoList: photos);
  }
}
