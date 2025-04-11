import 'package:flutter/material.dart';
import '../servico api/servico_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _userData;
  String? _errorMessage;

  void _fetchUser() async {
    final id = _controller.text;
    final user = await ApiService.fetchUser(id);

    setState(() {
      if (user != null) {
        _userData = user;
        _errorMessage = null;
      } else {
        _userData = null;
        _errorMessage = 'Usuário não encontrado!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Digite o ID do usuário (1-12)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchUser,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 16),
            if (_userData != null) ...[
              Text('Nome: ${_userData!['first_name']} ${_userData!['last_name']}'),
              Text('Email: ${_userData!['email']}'),
              const SizedBox(height: 8),
              Image.network(_userData!['avatar']),
            ] else if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
