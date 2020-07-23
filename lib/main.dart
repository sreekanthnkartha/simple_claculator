import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
//In this calculator long press on ⌫ to clear all
void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Center(child: Text('Calculator',
            style: TextStyle(
              fontFamily: 'FAV',
              letterSpacing: 3.0,
            ) ,
          ),
          ),
        ),
        body: calcu(),
      ),
    )
);
class calcu extends StatefulWidget {
  @override
  _calcuState createState() => _calcuState();
}

class _calcuState extends State<calcu> {
  String equation = "0";
  String result = "0";
  String expression = "";
  final con=PageController(initialPage:1);
  buttonPressedl(String buttonText) {
    setState(() {
      if (buttonText == "⌫")
      {
        equation = "0";
        result = "0";
      }
    });}
  buttonPressed(String buttonText) {
    setState(() {
      if (equation=="0"){
        result="0";

      }
      if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      }

      else if (buttonText == "=") {


        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
        if(result!="Error")
        equation=result;
      }

      else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight,
      Color buttonColor, Color fontcolor) {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.blueGrey[900],
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          onLongPress: () => buttonPressedl(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: fontcolor,
            ),
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end ,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(flex:3, child: Text(equation, style: TextStyle(fontSize: 30,color: Colors.white),),),
          Expanded(
            child: Divider(
              color: Colors.white,
            ),
          ),


          Expanded(flex:1, child: Text(result, style: TextStyle(fontSize: 30,color: Colors.white),),),
          Expanded(flex:7, child: PageView(
            controller: con,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              buildButton("+", 1, Colors.black54,Colors.teal,),
                              buildButton("x", 1, Colors.black54,Colors.teal,),
                              buildButton("÷", 1, Colors.black54,Colors.teal,),

                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("7", 1, Colors.black54,Colors.white,),
                              buildButton("8", 1, Colors.black54,Colors.white,),
                              buildButton("9", 1, Colors.black54,Colors.white,),

                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("4", 1, Colors.black54,Colors.white,),
                              buildButton("5", 1, Colors.black54,Colors.white,),
                              buildButton("6", 1, Colors.black54,Colors.white,),

                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton("1", 1, Colors.black54,Colors.white,),
                              buildButton("2", 1, Colors.black54,Colors.white,),
                              buildButton("3", 1, Colors.black54,Colors.white,),

                            ]
                        ),

                        TableRow(
                            children: [
                              buildButton(".", 1, Colors.black54,Colors.white,),
                              buildButton("0", 1, Colors.black54,Colors.white,),
                              buildButton("^", 1, Colors.black54,Colors.teal,),

                            ]
                        ),

                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Table(
                      children: [
                        TableRow(
                            children: [
                              buildButton("-", 1, Colors.black54,Colors.teal,),
                            ]
                        ),
                        TableRow(
                            children: [
                              buildButton("⌫", 2, Colors.black54,Colors.teal,),
                            ]
                        ),
                        TableRow(
                            children: [
                              buildButton("=", 2, Colors.red[400],Colors.white,),
                            ]
                        ),
                      ],
                    ),
                  )                 ],
              ),

            ],
          ) ),
        ],
      ),
    );
  }
}
