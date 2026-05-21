import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SpellVaultView extends StatefulWidget {
  const SpellVaultView({Key? key}) : super(key: key);

  @override
  State<SpellVaultView> createState() => _SpellVaultViewState();
}

class _SpellVaultViewState extends State<SpellVaultView> {
  Future<List<dynamic>> _fetchSpells() async {
    final response = await http.get(Uri.parse('https://potterapi-fedeperin.vercel.app/en/spells'));
    if (response.statusCode == 200) return json.decode(response.body);
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _fetchSpells(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final spells = snapshot.data!;
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                expandedHeight: 150.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Bóveda de Hechizos'),
                  background: Icon(Icons.auto_fix_high, size: 80, color: Colors.white24),
                ),
                backgroundColor: Colors.deepPurple,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Card(
                      child: ListTile(
                        title: Text(spells[index]['spell'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(spells[index]['use']),
                        leading: const Icon(Icons.flare, color: Colors.amber),
                      ),
                    ),
                    childCount: spells.length,
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.bolt, color: Colors.deepPurple),
                  ),
                  childCount: 9,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}