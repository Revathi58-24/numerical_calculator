import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numeric Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _inputValue = '';
  double _result = 0.0;

  void _onPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == 'C') {
        _clear();
      } else {
        _inputValue += buttonText;
      }
    });
  }


  void _calculateResult() {
    try {
      if (_inputValue.isNotEmpty) {
        // Use the 'eval' function to calculate the result
        Parser parser = Parser();
        Expression exp = parser.parse(_inputValue);
        ContextModel cm = ContextModel();
        _result = exp.evaluate(EvaluationType.REAL, cm);
        _inputValue = _result.toString();
      }
    } catch (e) {
      _inputValue = 'Error';
    }
  }

  double evalExpression(String expression) {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      return double.nan;
    }
  }



  void _clear() {
    _inputValue = '';
    _result = 0.0;
  }

  // Widget buildButton(String buttonText) {
  //   return Expanded(
  //     child: Padding(
  //       padding: EdgeInsets.all(8.0),
  //       child: OutlinedButton(
  //         onPressed: () => _onPressed(buttonText),
  //         child: Text(
  //           buttonText,
  //           style: TextStyle(
  //             fontSize: 20.0,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                width: 1.5,
                color: Colors.lightBlue,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.blueGrey,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.black,
            ),
          ),
          onPressed: () => _onPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numerical Calculator'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20.0),
      Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Playing with numbers',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "In mathematics, you don't understand things. You just get used to them.",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
              child: Text(
                _inputValue,
                style: TextStyle(fontSize: 48.0),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('/'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('*'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('-'),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton('C'),
              buildButton('0'),
              buildButton('='),
              buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}
