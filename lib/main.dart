import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_overview_06/models/babies.dart';

import 'models/dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Dog>(
          create: (context) => Dog(name: 'dog06', breed: 'breed06', age: 3),
        ),
        FutureProvider<int>(
            create: (context) {
              final int dogAge = context.read<Dog>().age;
              final babies = Babies(age: dogAge);
              return babies.getBabies();
            },
            initialData: 0),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider 06'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '- name: ${context.watch<Dog>().name}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const BreadAndAge()
          ],
        ),
      ),
    );
  }
}

class BreadAndAge extends StatelessWidget {
  const BreadAndAge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '- breed: ${context.select<Dog, String>((Dog dog) => dog.breed)}',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Age()
      ],
    );
  }
}

class Age extends StatelessWidget {
  const Age({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          ' -age: ${context.select<Dog, int>((Dog dog) => dog.age)}',
          style: const TextStyle(fontSize: 20.0),
          
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          '- number of babies: ${context.watch<int>()}',
          style: const TextStyle(fontSize: 20.0),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
            onPressed: () => context.read<Dog>().grow(),
            child: const Text(
              'Grow',
              style: TextStyle(fontSize: 20.0),
            ))
      ],
    );
  }
}
