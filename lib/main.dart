import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calculator());

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        } else if (buttonText == "=") {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          expression = equation;
          expression = expression.replaceAll('×', '*');

          //     expression=expression.replaceAll('', replace)
          try {
            Parser p = new Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = "Error";
          }
        } else {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        }
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.2),
            side: BorderSide(
                color: Colors.white70, width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(15.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.greenAccent),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Simple Calculator')),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Text("0", style: TextStyle(fontSize: equationFontSize)),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(8, 20, 8, 0),
              child: Text(
                "0",
                style: TextStyle(fontSize: resultFontSize),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * .80,
                    child: Table(children: [
                      TableRow(children: [
                        buildButton("C", 1, Colors.deepPurpleAccent),
                        buildButton("⌫", 1, Colors.deepPurple),
                        buildButton("/", 1, Colors.deepPurple)
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, Colors.black87),
                        buildButton("8", 1, Colors.black87),
                        buildButton("9", 1, Colors.black87),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Colors.black87),
                        buildButton("5", 1, Colors.black87),
                        buildButton("6", 1, Colors.black87),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, Colors.black87),
                        buildButton("2", 1, Colors.black87),
                        buildButton("3", 1, Colors.black87),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, Colors.black87),
                        buildButton("0", 1, Colors.black87),
                        buildButton("00", 1, Colors.black87),
                      ]),
                    ])),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("×", 1, Colors.deepPurple),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("+", 1, Colors.deepPurple),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("-", 1, Colors.deepPurple),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("=", 2, Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
