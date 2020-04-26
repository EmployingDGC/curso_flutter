import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Primeiro App',
    home:
      Stack(
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
                'Pessoas: 0',
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
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: FlatButton(
                      child: Text(
                        '-1',
                        style: TextStyle(fontSize: 40.0, color: Colors.purple),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Text(
                'Pode Entrar!',
                style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
              )
            ]
          ),
        ],
      ),
  )
  );
}
