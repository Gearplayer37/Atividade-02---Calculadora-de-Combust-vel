import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FuelCalculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FuelCalculator extends StatefulWidget {
  @override
  _FuelCalculatorState createState() => _FuelCalculatorState();
}

class _FuelCalculatorState extends State<FuelCalculator> {
  final TextEditingController _alcoholController = TextEditingController();
  final TextEditingController _gasolineController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _resultMessage = "Informe os preços dos combustíveis!";

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final alcoholPrice = double.parse(_alcoholController.text);
      final gasolinePrice = double.parse(_gasolineController.text);

      final ratio = alcoholPrice / gasolinePrice;

      setState(() {
        if (ratio < 0.7) {
          _resultMessage = 'Abasteça com Álcool (${ratio.toStringAsFixed(2)})';
        } else {
          _resultMessage = 'Abasteça com Gasolina (${ratio.toStringAsFixed(2)})';
        }
      });
    }
  }

  void _clear() {
    setState(() {
      _alcoholController.clear();
      _gasolineController.clear();
      _resultMessage = "Informe os preços dos combustíveis!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de Combustível",
        style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _clear,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.local_gas_station, size: 120.0, color: Colors.blue),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _alcoholController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.local_gas_station, size: 30.0, color: Colors.blue),
                  labelText: "Preço do Álcool (R\$)",
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 20.0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira o preço do álcool!";
                  }
                  try {
                    double.parse(value);
                  } catch (e) {
                    return "Preço inválido!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _gasolineController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.local_gas_station, size: 30.0, color: Colors.blue),
                  labelText: "Preço da Gasolina (R\$)",
                  labelStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 20.0),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira o preço da gasolina!";
                  }
                  try {
                    double.parse(value);
                  } catch (e) {
                    return "Preço inválido!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _clear,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                      ),
                      child: Text(
                        "Limpar",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                _resultMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _resultMessage.contains('Álcool') ? Colors.green : Colors.red,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
