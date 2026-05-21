import 'package:flutter/material.dart';
import 'character_dashboard.dart';
import 'book_wiki.dart';
import 'spell_vault.dart';
import 'house_explorer.dart';

void main() {
  runApp(const SoltelMasterclassApp());
}

class SoltelMasterclassApp extends StatelessWidget {
  const SoltelMasterclassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soltel Masterclass Módulo 2',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF740001)), // Gryffindor Red
        textTheme: const TextTheme(
          displayMedium: TextStyle(fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      home: const MasterclassNavigator(),
    );
  }
}

class MasterclassNavigator extends StatefulWidget {
  const MasterclassNavigator({super.key});

  @override
  State<MasterclassNavigator> createState() => _MasterclassNavigatorState();
}

class _MasterclassNavigatorState extends State<MasterclassNavigator> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  late HouseController _houseController;

  @override
  void initState() {
    super.initState();
    _houseController = HouseController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _houseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> blocks = [
      const CharacterDashboard(),
      const BookWiki(endpoint: 'https://potterapi-fedeperin.vercel.app/en'),
      const SpellVaultView(),
      HouseExplorerView(controller: _houseController),
    ];

    return Scaffold(
      // SafeArea protege el contenido de la barra de estado y los gestos del sistema
      body: SafeArea(
        child: Column(
          children: [
            // Expanded fuerza al PageView a ocupar solo el espacio sobrante en la columna,
            // respetando la altura exacta que exijan los controles de navegación inferiores.
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: blocks,
              ),
            ),
            // La botonera ahora es un bloque estructural, no un elemento flotante
            _buildNavigationControls(blocks.length),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationControls(int totalBlocks) {
    // Se elimina el widget Positioned porque ya no estamos dentro de un Stack.
    // Usamos un Padding para darle respiro a los botones respecto a los bordes.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _currentPage > 0 
              ? () => _controller.previousPage(
                  duration: const Duration(milliseconds: 300), 
                  curve: Curves.easeInOut) 
              : null,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "SECCIÓN ${_currentPage + 1} / $totalBlocks", 
              style: const TextStyle(fontWeight: FontWeight.bold)
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: _currentPage < totalBlocks - 1 
              ? () => _controller.nextPage(
                  duration: const Duration(milliseconds: 300), 
                  curve: Curves.easeInOut) 
              : null,
          ),
        ],
      ),
    );
  }
}