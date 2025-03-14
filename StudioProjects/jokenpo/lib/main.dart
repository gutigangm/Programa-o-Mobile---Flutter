import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pedra, Papel e Tesoura")),
      body: GameScreen(),
    );
  }
}

class GameScreen extends StatelessWidget {
  final List<String> options = ["pedra", "papel", "tesoura"];

  void _playGame(BuildContext context, String userChoice) {
    final String appChoice = options[Random().nextInt(3)]; // Escolha aleatória do app

    String result;
    if (userChoice == appChoice) {
      result = "Empate!";
    } else if (
    (userChoice == "pedra" && appChoice == "tesoura") ||
        (userChoice == "papel" && appChoice == "pedra") ||
        (userChoice == "tesoura" && appChoice == "papel")) {
      result = "Você venceu!";
    } else {
      result = "Você perdeu!";
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(userChoice: userChoice, appChoice: appChoice, result: result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Escolha uma opção:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: options.map((choice) {
              return GestureDetector(
                onTap: () => _playGame(context, choice),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("images/$choice.png", width: 100, height: 100),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String userChoice;
  final String appChoice;
  final String result;

  ResultScreen({required this.userChoice, required this.appChoice, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resultado")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sua escolha:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Image.asset("images/$userChoice.png", width: 80, height: 80),
            SizedBox(height: 10),
            Text("Escolha do app:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Image.asset("images/$appChoice.png", width: 80, height: 80),
            SizedBox(height: 10),
            Text(result, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Jogar Novamente"),
            )
          ],
        ),
      ),
    );
  }
}