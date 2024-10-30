import 'package:flutter/material.dart';
import 'package:myapp/guessGame.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MyState(),
    child: const MaterialApp(
      home: GuessGame(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  var _counter = 0;


  void _change(bool increase) {
    setState(() {
      if (increase) {
        _counter++;
      } else {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Counter App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity, //match parent
        //color: Colors.amber,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Has oprimido el botón",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Text("$_counter veces")
          ],
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton(
            onPressed: () => _change(true), child: const Icon(Icons.add)),
        FloatingActionButton(
            onPressed: () => {_change(false)}, child: const Icon(Icons.remove))
      ],
    );
  }
}
