import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuessGame extends StatefulWidget {
  const GuessGame({super.key});

  @override
  State<GuessGame> createState() => _GuessGameState();
}

class _GuessGameState extends State<GuessGame> {
    final _controller = TextEditingController();

  
  void _play(){

    var state = context.read<MyState>();
    print(state.random);
    var value = int.tryParse(_controller.text);
    _controller.clear();
    if (value != null){
      
        if(value>=0 && value<=100){
        state.counterPlus();
        if(value>state.random){
          state.message = "Number $value is bigger than the random number";
        }
        else if(value<state.random){
          state.message = "Number $value is smaller than the random number";
        }
        else{
          state.message = "Number $value is the WINNER";
          state.finished = true;
        }
      }else{
        state.message = "Number $value is out of bounds";
      }
      
      
    }
  }
  void _newGame(){

    var state = context.read<MyState>();

    setState(() {
      state.counter = 0;
      state.finished = false;
      state._random = Random().nextInt(101);
      state.message = "";
    });
  }
  @override
  Widget build(BuildContext context) {

    //siempre va watch o select

    var state = context.watch<MyState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Guess Game!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity, //match parent
        //color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset("assets/images/numeros.png"),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Ingresa un número entre 0 y 100",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
                decoration: const InputDecoration(hintText: "number..."),
                keyboardType: TextInputType.number, 
                controller:  _controller),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: state.finished ? null : _play , child: const Text("Jugar!"))),
            const SizedBox(height: 20),
            Text(
              "Mensaje: ${state.message}",
              style: TextStyle(color: state.finished ? Colors.green : Colors.black),
            ),
            const SizedBox(height: 20),
            Text(
              "Intentos: ${state.counter}",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.finished ? _newGame : null,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class MyState extends ChangeNotifier{
  var _counter = 0;
  var _message = "";
  int _random = Random().nextInt(101);
  var _finished = false;

  int get counter => _counter;
  set counter(int value){
     _counter = value;
     notifyListeners();
     }
  void counterPlus (){
    _counter++;
    notifyListeners();
  }

  String get message => _message;
  set message(String value){
    this._message = value;
    notifyListeners();
  }

  int get random => _random;
  void newRandom(){
    this._random = Random().nextInt(101);
    notifyListeners();
  }

  set finished(bool value){
    _finished = value;
    notifyListeners();
  }

  bool get finished => _finished;
}