import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recherche')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _ctrl,
              onChanged: (v) => setState(() => _query = v.toUpperCase()),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Numéro de vol, compagnie, route...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            if (_query.isEmpty)
              const Text('Tapez un numéro de vol (ex : AF1234, TU712)')
            else
              Text('Recherche : $_query'),
          ],
        ),
      ),
    );
  }
}
