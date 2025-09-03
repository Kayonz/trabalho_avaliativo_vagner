import 'package:flutter/material.dart';
import 'package:trabalho_vagner/apps/InfoTela.dart';
import 'HomeTela.dart';

class SegundaTela extends StatefulWidget {
  const SegundaTela({super.key, required this.title});
  final String title;

  @override
  State<SegundaTela> createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {
  final _value1 = TextEditingController();
  final _value2 = TextEditingController();

  double result = 0;

  void sum() {
    setState(() {
      result = (double.tryParse(_value1.text) ?? 0.0) +
          (double.tryParse(_value2.text) ?? 0.0);
    });
  }

  void sub() {
    setState(() {
      result = (double.tryParse(_value1.text) ?? 0.0) -
          (double.tryParse(_value2.text) ?? 0.0);
    });
  }

  void div() {
    setState(() {
      final num2 = double.tryParse(_value2.text) ?? 0.0;
      if (num2 != 0) {
        result = (double.tryParse(_value1.text) ?? 0.0) / num2;
      } else {
        result = double.nan;
      }
    });
  }

  void mult() {
    setState(() {
      result = (double.tryParse(_value1.text) ?? 0.0) *
          (double.tryParse(_value2.text) ?? 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const HomeTela(title: "Tela de Login"),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Info Tela'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const Infotela(title: "Calculadora"),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Valor 1
              TextFormField(
                controller: _value1,
                decoration: const InputDecoration(
                  hintText: "First number",
                  icon: Icon(Icons.numbers, color: Colors.lightBlueAccent),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),

              // Valor 2
              TextFormField(
                controller: _value2,
                decoration: const InputDecoration(
                  hintText: "Second number",
                  icon: Icon(Icons.numbers, color: Colors.lightBlueAccent),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Linha 1 - Soma e Divisão
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: sum,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent),
                    child: const Text(
                      "Sum",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: div,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent),
                    child: const Text(
                      "Divide",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Linha 2 - Subtração e Multiplicação
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: sub,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent),
                    child: const Text(
                      "Subtract",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: mult,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent),
                    child: const Text(
                      "Multiply",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Resultado
              Text(
                "Resultado: $result",
                style: const TextStyle(color: Colors.red, fontSize: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
