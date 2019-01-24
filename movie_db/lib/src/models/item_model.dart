class ItemModel {
  int _page;
  int _total_results;
  int _total_pages;
  List<_Result> _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _total_pages = parsedJson['total_pages'];
    _total_results = parsedJson['total_results'];

    List<_Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][i]);
      temp.add(result);
    }

    _results = temp;
  }

  List<_Result> get results => _results;
  int get page => _page;
  int get total_results => _total_results;
  int get total_pages => _total_pages;
}

class _Result {
  int _vote_count;
  int _id;
  bool _video;
  dynamic _vote_average;
  String _title;
  dynamic _popularity;
  String _poster_path;
  String _original_language;
  String _original_title;
  List _genre_ids = [];
  String _backdrop_path;
  bool _adult;
  String _overview;
  String _release_date;

  _Result(result) {
    _vote_count = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _vote_average = result['vote_average'];
    _title = result['title'];
    _popularity = result['popularity'];
    _poster_path = result['poster_path'];
    _original_language = result['original_language'];
    _original_title = result['original_title'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genre_ids.add(result['genre_ids'][i]);
    }
    _backdrop_path = result['backdrop_path'];
    _adult = result['adult'];
    _overview = result['overview'];
    _release_date = result['release_date'];
  }

  int get vote_count => _vote_count;
  int get id => _id;
  bool get video => _video;
  dynamic get vote_average => _vote_average;
  String get title => _title;
  dynamic get popularity => _popularity;
  String get poster_path => _poster_path;
  String get original_language => _original_language;
  String get original_title => _original_title;
  List get genre_ids => _genre_ids;
  String get backdrop_path => _backdrop_path;
  bool get adult => _adult;
  String get overview => _overview;
  String get release_date => _release_date;
}
