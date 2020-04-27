import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = 'https://api.hgbrasil.com/finance?key=15b66f7a';

void main(List<String> args) async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.amber,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.amber,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    )
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _dolar;
  double _euro;

  final controladorReal = TextEditingController();
  final controladorDolar = TextEditingController();
  final controladorEuro = TextEditingController();

  void _realChanged(String text) {
    double real = double.parse(text);

    controladorDolar.text = (real / this._dolar).toStringAsFixed(2);
    controladorEuro.text = (real / this._euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);

    controladorReal.text = (dolar * this._dolar).toStringAsFixed(2);
    controladorEuro.text = (dolar * this._dolar / this._euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);

    controladorReal.text = (euro * this._euro).toStringAsFixed(2);
    controladorDolar.text = (euro * this._euro / this._dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          
        ],
        title: Text('\$ Conversor \$'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  'Carregando Dados...',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro ao Carregar Dados :(',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              else {
                _dolar = snapshot.data['results']['currencies']['USD']['buy'];
                _euro = snapshot.data['results']['currencies']['EUR']['buy'];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: buildTextField('Reais', 'R\$', controladorReal, this._realChanged),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: buildTextField('Dólares', 'US\$', controladorDolar, this._dolarChanged),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: buildTextField('Euros', '€', controladorEuro, this._euroChanged),
                      ),
                    ],
                  ),
                );
              }
            break;
          }
        },
        future: getData(),
      ),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

Widget buildTextField(String label, String prefix, TextEditingController currencie, Function changedCurrencie) {
  return TextField(
    controller: currencie,
    decoration: InputDecoration(
      labelText: '${label}',
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: '${prefix} ',
    ),
    style: TextStyle(
      color: Colors.amber,
      fontSize: 25,
    ),
    onChanged: changedCurrencie,
    keyboardType: TextInputType.number,
  );
}
