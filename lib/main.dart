import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiermedizinische Datenbank',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tiermedizinische Datenbank'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page the application.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List text = [{}] ; //create list
  void _incrementCounter() async {
    var db = await mongo.Db.create("mongodb+srv://Cluster2User:gPId3Gm4a0I9icN5@agile2cluster.bxvcw4l.mongodb.net/Test?retryWrites=true&w=majority"); //database connection string
    //mongodb+srv://Cluster2User:gPId3Gm4a0I9icN5@agile2cluster.bxvcw4l.mongodb.net/Test?retryWrites=true&w=majority
    await db.open(); //connect to database
    var collection = db.collection('CollectionTest');

    var mycol = await collection.find().toList(); //list all database objects
    print(mycol);
    setState(()  {
      text = mycol;
      _counter++;
    });
    await db.close(); //close connection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(text.length, (index) { //generate list
              return ListTile(
                title: Text(text[index]['name'].toString()), //display list
              );
            }),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton( //refresh button
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}
