import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    title: 'Lista de Tarefas',
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _toDoList = [];

  final _controladorTarefas = TextEditingController();

  @override
  void initState() {
    super.initState();

    this._readData().then((data) {
      setState(() {
        this._toDoList = json.decode(data);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newTodo = Map();

      newTodo['title'] = this._controladorTarefas.text;
      this._controladorTarefas.text = '';

      newTodo['ok'] = false;

      this._toDoList.add(newTodo);

      this._saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Lista de Tarefas',),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(17, 1, 7, 1),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: this._controladorTarefas,
                    decoration: InputDecoration(
                      labelText: 'Nova Tarefa',
                      labelStyle: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text('ADD'),
                  textColor: Colors.white,
                  onPressed: () {
                    _addToDo();
                  }
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsetsDirectional.only(top: 10),
              itemCount: this._toDoList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text('${this._toDoList[index]["title"]}'),
                  value: this._toDoList[index]['ok'],
                  secondary: CircleAvatar(
                    child: Icon(this._toDoList[index]['ok'] ? Icons.check : Icons.error),
                  ),
                  onChanged: (checked) {
                    setState(() {
                      this._toDoList[index]['ok'] = checked;
                      this._saveData();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/data.json');
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);

    final file = await _getFile();

    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
