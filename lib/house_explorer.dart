import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HouseController {
  final ValueNotifier<List<dynamic>> housesNotifier = ValueNotifier([]);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> fetchHouses() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://potterapi-fedeperin.vercel.app/en/houses'));
      if (response.statusCode == 200) {
        housesNotifier.value = json.decode(response.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void dispose() {
    housesNotifier.dispose();
    isLoading.dispose();
  }
}

class HouseExplorerView extends StatelessWidget {
  final HouseController controller;
  const HouseExplorerView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Casas de Hogwarts')),
      body: ValueListenableBuilder<bool>(
        valueListenable: controller.isLoading,
        builder: (context, loading, _) {
          if (loading) return const Center(child: CircularProgressIndicator());
          return ValueListenableBuilder<List<dynamic>>(
            valueListenable: controller.housesNotifier,
            builder: (context, houses, _) {
              if (houses.isEmpty) {
                return const Center(child: Text('Explora las grandes casas'));
              }
              return ListView.builder(
                itemCount: houses.length,
                itemBuilder: (context, index) {
                  final house = houses[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(house['house'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Fundador: ${house['founder']}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(house['animal']),
                          const Icon(Icons.shield, size: 16),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fetchHouses,
        child: const Icon(Icons.search),
      ),
    );
  }
}