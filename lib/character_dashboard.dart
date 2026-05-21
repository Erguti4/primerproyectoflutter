import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CharacterDashboard extends StatefulWidget {
  const CharacterDashboard({Key? key}) : super(key: key);

  @override
  State<CharacterDashboard> createState() => _CharacterDashboardState();
}

class _CharacterDashboardState extends State<CharacterDashboard> {
  Future<List<dynamic>> _fetchCharacters() async {
    final response = await http.get(Uri.parse('https://potterapi-fedeperin.vercel.app/en/characters'));
    if (response.statusCode == 200) return json.decode(response.body);
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personajes de Hogwarts')),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchCharacters(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final characters = snapshot.data!;
          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 900) return _buildDesktopLayout(characters);
              if (constraints.maxWidth > 600) return _buildTabletLayout(characters);
              return _buildMobileLayout(characters);
            },
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(List<dynamic> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(data[index]['image'])),
        title: Text(data[index]['nickname']),
        subtitle: Text(data[index]['fullName']),
      ),
    );
  }

  Widget _buildTabletLayout(List<dynamic> data) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5),
      itemCount: data.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: Image.network(data[index]['image'], width: 50, fit: BoxFit.cover),
          title: Text(data[index]['nickname']),
          subtitle: Text(data[index]['hogwartsHouse']),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(List<dynamic> data) {
    return Row(
      children: [
        Container(
          width: 250,
          color: Colors.brown[900],
          child: const Center(child: Text('Wiki Lateral', style: TextStyle(color: Colors.white))),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) => Column(
              children: [
                Expanded(child: Image.network(data[index]['image'], fit: BoxFit.cover)),
                const SizedBox(height: 10),
                Text(data[index]['fullName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(data[index]['hogwartsHouse']),
              ],
            ),
          ),
        ),
      ],
    );
  }
}