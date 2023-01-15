import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _p
  Widget _buildName() {
    return TextField(
      controller: _controllerName,
      autofocus: true,
      decoration: const InputDecoration(
        labelText: "用户名",
        hintText: "请输入用户名",
        prefixIcon: Icon(
          Icons.people,
        ),
        border: OutlineInputBorder(),
      ),
      onChanged: (value) {
        print(value);
      },
    );
  }

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('输入框Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildName(),
          ],
        ),
      ),
    );
  }
}
