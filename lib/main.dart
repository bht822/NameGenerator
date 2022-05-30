import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final word = WordPair.random();

    return MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
        ),
        body: const Center(child: RandomWords()),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestion = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _likedWords = <WordPair> {};  //Dict to stored the liked words
  @override
  final wordPair = WordPair.random();
  Widget build(BuildContext context) {
    return ListView.builder(padding: const EdgeInsets.all(16.0),
    itemBuilder: (context,i){
      if(i.isOdd) return const Divider();
      final index = i~/2;
      if(index >= _suggestion.length){
        _suggestion.addAll(generateWordPairs().take(10));
      }
      return ListTile(
        title: Text(
          _suggestion[index].asPascalCase,
          style: _biggerFont,
        ),
      );
    },
    );
    }
}