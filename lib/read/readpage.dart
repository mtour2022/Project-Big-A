import 'package:flutter/material.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({super.key});

  @override
  State<ReadPage> createState() => _BagPageState();
}

class _BagPageState extends State<ReadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text("read page"));
  }
}
