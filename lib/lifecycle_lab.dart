import 'package:flutter/material.dart';

class AdvancedLifecycleWidget extends StatefulWidget {
  final String endpoint;
  // RETO 6: Reacción a cambios del Padre
  // OBJETIVO: Dominar didUpdateWidget.
  // TODO: Supón que el widget padre pasa un String llamado 'searchQuery'.
  // Añade una propiedad final String? searchQuery a este widget.
  final String? searchQuery;

  const AdvancedLifecycleWidget({Key? key, required this.endpoint, this.searchQuery}) : super(key: key);

  @override
  State<AdvancedLifecycleWidget> createState() => _AdvancedLifecycleWidgetState();
}

class _AdvancedLifecycleWidgetState extends State<AdvancedLifecycleWidget> {
  late ScrollController _scrollController;
  // RETO 5: Formularios y FocusNodes
  // OBJETIVO: Entender el ciclo de vida de otros componentes nativos.
  // TODO: Crea una variable '_textController' de tipo TextEditingController
  // y un '_focusNode' de tipo FocusNode.
  // RETO CRÍTICO: Debes asegurar que ambos controladores sean instanciados en
  // 'initState' y completamente destruidos en 'dispose'.
  late TextEditingController _textController;
  late FocusNode _focusNode;

  // RETO 4: Animación basada en Scroll (Parallax Básico)
  // OBJETIVO: Escuchar un controlador físico y mutar la interfaz en tiempo real.
  // TODO: Declara una variable booleana '_isScrolled' en el estado inicializada en false.
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // RETO 5: Inicialización de TextEditingController y FocusNode
    _textController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant AdvancedLifecycleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // RETO 6: Reacción a cambios del Padre
    // TODO: Si el oldWidget.searchQuery es diferente al
    // actual widget.searchQuery, reinicia el '_scrollController' llamando a
    // '_scrollController.jumpTo(0.0)'.
    if (oldWidget.searchQuery != widget.searchQuery) {
      _scrollController.jumpTo(0.0);
    }
  }

  void _scrollListener() {
    // RETO 4: Lógica condicional para _isScrolled
    // TODO: Si el offset supera los 100 píxeles, cambia '_isScrolled' a true y usa setState.
    // Si desciende de 100, pásalo a false.
    bool newScrolledState = _scrollController.offset > 100;
    if (_isScrolled != newScrolledState) {
      setState(() {
        _isScrolled = newScrolledState;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    // RETO 5: Destrucción de TextEditingController y FocusNode
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offset: ${_scrollController.hasClients ? _scrollController.offset.toStringAsFixed(1) : '0.0'}'),
        // RETO 4: Operador ternario en el color de la AppBar
        // TODO: Finalmente, usa un operador ternario en el color de tu AppBar para
        // que cambie dinámicamente entre azul y rojo basándose en esa variable '_isScrolled'.
        backgroundColor: _isScrolled ? Colors.redAccent : Colors.blueAccent,
        // RETO 5: Inyectar TextField en la AppBar
        // TODO: Añade un TextField en la AppBar para usar _textController y _focusNode.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: 'Buscar...',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 100,
        itemBuilder: (context, index) => ListTile(
          title: Text('Ítem $index'),
          subtitle: const Text('Desliza para ver el ciclo de vida en acción'),
        ),
      ),
    );
  }
}