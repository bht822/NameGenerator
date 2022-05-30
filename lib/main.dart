import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const RandomWords(),
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
  final _likedWords = <WordPair>{}; //Dict to stored the liked words
  @override
  final wordPair = WordPair.random();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.list),
            tooltip: 'Save Suggestions',
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          if (index >= _suggestion.length) {
            _suggestion.addAll(generateWordPairs().take(10));
          }
          final _alreadyLiked = _likedWords.contains(_suggestion[
              index]); //Check if the name is saved already , if not show heart icon
          return ListTile(
            title: Text(
              _suggestion[index].asPascalCase,
              style: _biggerFont,
            ),
            trailing: Icon(
              _alreadyLiked ? Icons.favorite : Icons.favorite_border,
              color: _alreadyLiked ? Colors.red : null,
              semanticLabel: _alreadyLiked ? 'Remove from saved' : 'Save',
            ),
            onTap: () {
              setState(() {
                if (_alreadyLiked) {
                  _likedWords.remove(_suggestion[index]);
                } else {
                  _likedWords.add(_suggestion[index]);
                }
              });
            },
          );
        },
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final tiles = _likedWords.map(
        (pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Likes Names'),
        ),
        body: ListView(children: divided),
      );
    }));
  }
}
