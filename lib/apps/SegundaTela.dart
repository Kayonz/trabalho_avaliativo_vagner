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
  String display = "0";
  String previousNumber = "";
  String operation = "";
  bool waitingForOperand = false;

  void inputNumber(String number) {
    setState(() {
      if (waitingForOperand) {
        display = number;
        waitingForOperand = false;
      } else {
        display = display == "0" ? number : display + number;
      }
    });
  }

  void inputOperation(String nextOperation) {
    setState(() {
      if (previousNumber.isEmpty) {
        previousNumber = display;
      } else if (!waitingForOperand) {
        calculate();
      }

      waitingForOperand = true;
      operation = nextOperation;
    });
  }

  void calculate() {
    double prev = double.tryParse(previousNumber) ?? 0;
    double current = double.tryParse(display) ?? 0;
    double result = 0;

    switch (operation) {
      case "+":
        result = prev + current;
        break;
      case "-":
        result = prev - current;
        break;
      case "×":
        result = prev * current;
        break;
      case "÷":
        result = current != 0 ? prev / current : 0;
        break;
    }

    setState(() {
      display = result % 1 == 0 ? result.toInt().toString() : result.toString();
      previousNumber = "";
      operation = "";
      waitingForOperand = true;
    });
  }

  void clear() {
    setState(() {
      display = "0";
      previousNumber = "";
      operation = "";
      waitingForOperand = false;
    });
  }

  void percentage() {
    setState(() {
      double value = double.tryParse(display) ?? 0;
      display = (value / 100).toString();
    });
  }

  Widget buildButton({
    required String text,
    required VoidCallback onPressed,
    Color backgroundColor = const Color(0xFF333333),
    Color textColor = Colors.white,
    bool isWide = false,
  }) {
    return Container(
      width: isWide ? 160 : 70,
      height: 70,
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
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
                    const Infotela(title: "Tela de Informação"),
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
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Display
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20),
                height: 150,
                child: Text(
                  display,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),


              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton(
                        text: "AC",
                        onPressed: clear,
                        backgroundColor: const Color(0xFFA6A6A6),
                        textColor: Colors.black,
                      ),
                      buildButton(
                        text: "%",
                        onPressed: percentage,
                        backgroundColor: const Color(0xFFA6A6A6),
                        textColor: Colors.black,
                      ),
                      buildButton(
                        text: "÷",
                        onPressed: () => inputOperation("÷"),
                        backgroundColor: const Color(0xFFFF9500),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton(text: "7", onPressed: () => inputNumber("7")),
                      buildButton(text: "8", onPressed: () => inputNumber("8")),
                      buildButton(text: "9", onPressed: () => inputNumber("9")),
                      buildButton(
                        text: "×",
                        onPressed: () => inputOperation("×"),
                        backgroundColor: const Color(0xFFFF9500),
                      ),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton(text: "4", onPressed: () => inputNumber("4")),
                      buildButton(text: "5", onPressed: () => inputNumber("5")),
                      buildButton(text: "6", onPressed: () => inputNumber("6")),
                      buildButton(
                        text: "-",
                        onPressed: () => inputOperation("-"),
                        backgroundColor: const Color(0xFFFF9500),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton(text: "1", onPressed: () => inputNumber("1")),
                      buildButton(text: "2", onPressed: () => inputNumber("2")),
                      buildButton(text: "3", onPressed: () => inputNumber("3")),
                      buildButton(
                        text: "+",
                        onPressed: () => inputOperation("+"),
                        backgroundColor: const Color(0xFFFF9500),
                      ),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton(
                        text: "0",
                        onPressed: () => inputNumber("0"),
                        isWide: true,
                      ),
                      buildButton(text: ".", onPressed: () => inputNumber(".")),
                      buildButton(
                        text: "=",
                        onPressed: calculate,
                        backgroundColor: const Color(0xFFFF9500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
