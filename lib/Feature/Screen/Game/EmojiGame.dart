import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Joke {
  final String setup;
  final String delivery;

  Joke({required this.setup, required this.delivery});

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'] ?? '',
      delivery:
          json['delivery'] != null ? json['delivery'] : json['joke'] ?? '',
    );
  }
}

class JokesPage extends StatefulWidget {
  @override
  _JokesPageState createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  late List<Joke> jokes = [];
  int currentIndex = 0;
  String set = "Programming";
  String prefixTitle = '';
  Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    fetchJokes();
  }

  Future<void> fetchJokes() async {
    final response =
        await http.get(Uri.parse('https://v2.jokeapi.dev/joke/$set?amount=10'));
    final jsonData = jsonDecode(response.body);
    final List<dynamic> jokeList = jsonData['jokes'];
    jokes = jokeList.map((json) => Joke.fromJson(json)).toList();
    setState(() {});
  }

  void goToNextJoke() {
    setState(() {
      currentIndex = (currentIndex + 1) % jokes.length;
      if (currentIndex == 0) {
        fetchJokes(); // Reload jokes when all 10 have been seen
      }
    });
  }

  void changeBackgroundColor() {
    fetchJokes();
    setState(() {
      _backgroundColor = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor:
            _backgroundColor == Colors.white ? Colors.black : Colors.white,
        backgroundColor: _backgroundColor,
        title: InkWell(
          onTap: () {
            setState(() {
              set = "Dark";
              prefixTitle = "Dark";
            });
            changeBackgroundColor();
          },
          child: Text(
            '$prefixTitle Jokes',
          ),
        ),
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: _backgroundColor,
        child: Center(
          child: jokes.isEmpty
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      jokes[currentIndex].setup,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _backgroundColor == Colors.white
                              ? Colors.black
                              : Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      jokes[currentIndex].delivery,
                      style: TextStyle(
                          fontSize: 16,
                          color: _backgroundColor == Colors.white
                              ? Colors.black
                              : Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: goToNextJoke,
                      child: Text('Next Joke'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
