import 'package:flutter/material.dart';
import 'package:front/graphql_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Graphql test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    GraphQLService graphQLService = GraphQLService();
    graphQLService.getPolicy(81);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text('Teste graphql'),
      ),
    );
  }
}
