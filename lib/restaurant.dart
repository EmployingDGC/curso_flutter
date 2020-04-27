import 'package:flutter/material.dart';

void main() {
  print('ok');
  runApp(MaterialApp(
    title: 'Primeiro App',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  int _max_people = 10;
  String _info_text = 'Pode Entrar!';

  void _changePeople(int delta) {
    setState(() {
      this._people += delta;

      if (this._people > this._max_people) {
        this._changePeople(-1);
      }
      else if (this._people == this._max_people) {
        this._changeInfo(info: 'Lugar Cheio!');
      }
      else if (this._people < 0) {
        this._changePeople(1);
      }
      else {
        this._changeInfo(info: 'Pode Entrar!');
      }
    });
  }
  
  void _changeInfo({String info = 'Pode Entrar!'}) {
    setState(() {
      this._info_text = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget> [
        Image.asset(
          'images/restaurant.jpg',
          fit: BoxFit.cover,
          height: 1000,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pessoas: ${this._people}',
              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(18),
                  child: FlatButton(
                    child: Text(
                      '+1',
                      style: TextStyle(fontSize: 40.0, color: Colors.purple),
                    ),
                    onPressed: () {
                      this._changePeople(1);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(18),
                  child: FlatButton(
                    child: Text(
                      '-1',
                      style: TextStyle(fontSize: 40.0, color: Colors.purple),
                    ),
                    onPressed: () {
                      this._changePeople(-1);
                    },
                  ),
                ),
              ],
            ),
            Text(
              '${this._info_text}',
              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            )
          ]
        ),
      ],
    );
  }
}
