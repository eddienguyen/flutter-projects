import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController keyInputController = new TextEditingController();
  TextEditingController valueInputController = new TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "myJSONFile.json";
  bool fileExixts = false;
  Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      print(directory);
      dir = directory;
      jsonFile = new File(dir.path +
          "/" +
          fileName); // concat the directory with the path to the actual file
      fileExixts = jsonFile.existsSync();
      if (fileExixts)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  @override
  void dispose() {
    keyInputController.dispose();
    valueInputController.dispose();
    super.dispose();
  }

  void createFile(Map<String, String> content, Directory dir, String fileName) {
    print('creating file');
    File file = new File(dir.path + "/" + fileName); // immutability
    file.createSync();
    fileExixts = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, String value) {
    print('writing to file');
    Map<String, dynamic> content = {key: value};
    if (fileExixts) {
      print('file exists');
      // get content in the JSON file
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      // merge that content to the new content that we want to add to the JSON file
      jsonFileContent.addAll(content);
      // write the merged content to JSON file
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print('file does not exists');
      createFile(content, dir, fileName);
    }
    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON Local Storage'),
      ),
      body: Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(top: 10.0),
          ),
          new Text(
            'File content: ',
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
          new Text(fileContent.toString()),
          new Padding(
            padding: new EdgeInsets.only(top: 10.0),
          ),
          new Text('Add to JSON file:'),
          new TextField(
            controller: keyInputController,
          ),
          new TextField(
            controller: valueInputController,
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 20.0),
          ),
          new RaisedButton(
            child: new Text('Add key, value pair'),
            onPressed: () =>
                writeToFile(keyInputController.text, valueInputController.text),
          )
        ],
      ),
    );
  }
}
