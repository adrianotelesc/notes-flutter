import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          TextField(
            controller: _textEditingController,
          ),
          ElevatedButton(
            onPressed: () {
              context.push('/${_textEditingController.text}');
            },
            child: const Text('Ir'),
          )
        ],
      )),
    );
  }
}
