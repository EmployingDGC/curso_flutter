import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _imc = 0;

  TextEditingController controladorPeso = TextEditingController();
  TextEditingController controladorAltura = TextEditingController();

  void _calcIMC(double peso, double altura) {
    setState(() {
      if (altura > 0 && peso > 0) {
        this._imc = peso / (altura * altura);
      }
      else {
        this._imc = 0;
      }
    });
  }

  void _reloadPage() {
    setState(() {
      this._imc = 0;
      controladorPeso.text = '';
      controladorAltura.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              this._reloadPage();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(Icons.person_outline, size: 120.0, color: Colors.green,),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controladorPeso,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controladorAltura,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Altura (m)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 75,
                child: RaisedButton(
                  onPressed: () {
                    this._calcIMC(double.parse(controladorPeso.text.trim().isEmpty ? '0' : controladorPeso.text), double.parse(controladorAltura.text.trim().isEmpty ? '0' : controladorAltura.text));
                  },
                  child: Text(
                    'Calcular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  color: Colors.green,
                  hoverElevation: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '${this._imc == 0.0 ? "Informe seus dados!" : "Seu IMC é ${this._imc.toStringAsFixed(2)}\n ${(this._imc < 18.5) ? 'Baixo Peso' : (this._imc < 24.9) ? 'Peso Saudável' : (this._imc < 29.9) ? 'Sobrepeso' : 'Obesidade'}"}',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
