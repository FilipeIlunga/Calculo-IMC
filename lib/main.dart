import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My app',
      theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var icone = null;
  String _infoText = 'Informe seus dados';
  final weightControler = TextEditingController();
  final heightControler = TextEditingController();

  void _resetFilds() {
    weightControler.text = '';
    heightControler.text = '';
    icone = null;
    backgroundColor = Color(0xFFFFBFB3);
    setState(() {
      _infoText = 'Informe seus dados';
    });
  }

  var backgroundColor = Color(0xFFFFBFB3);

  void calculate() {
    backgroundColor = Color(0xFFFFBFB3);
    setState(
      () {
        if (weightControler.text.isEmpty && heightControler.text.isEmpty) {
          _infoText = 'Informe a Altura e o Peso';
          backgroundColor = Colors.red;
          return;
        } else if (weightControler.text.isEmpty) {
          _infoText = ' Informe o Peso';
          backgroundColor = Colors.red;
          return;
        } else if (heightControler.text.isEmpty) {
          _infoText = 'Informe a Altura';
          backgroundColor = Colors.red;
          return;
        }
        double weight = double.parse(weightControler.text);
        double height = double.parse(heightControler.text) / 100;

        double imc = weight / (height * height);
        if (imc < 19) {
          _infoText = 'Magreza - IMC:${imc.toStringAsFixed(2)}';
          icone = Icons.access_alarm;
        } else if (imc >= 19 && imc < 24) {
          _infoText = 'Peso Ideal- IMC:${imc.toStringAsFixed(2)}';
          icone = Icons.pages;
        } else if (imc >= 25 && imc < 29) {
          _infoText = 'Sobrepeso - IMC:${imc.toStringAsFixed(2)}';
          icone = Icons.place;
        } else if (imc >= 30 && imc < 34) {
          _infoText = 'Obesidade Grau I - IMC:${imc.toStringAsFixed(2)}';
        } else if (imc >= 30 && imc < 39) {
          _infoText = 'Obesidade Grau II - IMC:${imc.toStringAsFixed(2)}';
        } else if (imc >= 40) {
          _infoText = 'Obesidade Grau III - IMC:${imc.toStringAsFixed(2)}';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculadora de IMC'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.refresh),
            onPressed: _resetFilds,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
              size: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 5,
                child: TextField(
                  controller: weightControler,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Peso (Kg)',
                    hintText: 'Digite o peso em Kg',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Card(
                elevation: 5,
                child: TextField(
                  controller: heightControler,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Altura (cm)',
                      hintText: 'Digite a altura em cm'),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
              ),
              child: FlatButton(
                onPressed: calculate,
                child: Text('Calcuar'),
              ),
            ),
            SizedBox(height: 15),
            Text(
              _infoText,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Icon(icone),
          ],
        ),
      ),
    );
  }
}
