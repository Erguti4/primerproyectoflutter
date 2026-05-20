import 'package:flutter/material.dart';

class SliverArchitectureView extends StatelessWidget {
  const SliverArchitectureView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // RETO 7: Configuración Dinámica de Cabecera
          // OBJETIVO: Personalizar la física del SliverAppBar.
          // TODO: Modifica el 'SliverAppBar' base. Cambia 'pinned: true' por 'floating: true'.
          // Haz scroll hacia abajo en el dispositivo y luego un pequeño gesto hacia arriba.
          // Analiza y documenta internamente cómo difiere este comportamiento.
          // Combina 'floating: true' con 'snap: true' y experimenta el resultado.
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Slivers Corporativos'),
              background: Image.network(
                'https://picsum.photos/800/400',
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Sección de Análisis de Datos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(title: Text('Registro de operaciones #$index')),
                );
              },
              childCount: 15,
            ),
          ),

          // RETO 8: Inyección de una Malla de Datos (SliverGrid)
          // OBJETIVO: Combinar arquitecturas en un mismo lienzo de scroll.
          // TODO: Debajo del 'SliverList' en el código base, inyecta un componente
          // 'SliverGrid'. Utiliza 'SliverGridDelegateWithFixedCrossAxisCount'
          // configurando 3 columnas ('crossAxisCount: 3').
          // En su 'delegate', usa un 'SliverChildBuilderDelegate' para generar 30
          // elementos que muestren íconos o imágenes de red (NetworkImage).

          // RETO 9: SliverPadding Arquitectónico
          // OBJETIVO: Espaciar de forma óptima sin romper el modelo RenderSliver.
          // TODO: Envolver un widget tipo Sliver dentro de un 'Padding' clásico generará
          // una excepción de compilación "A RenderRepaintBoundary expected a child of type RenderBox".
          // Envuelve el 'SliverGrid' que creaste en el Reto 8 dentro de un widget
          // específico llamado 'SliverPadding' e inyecta 20 píxeles asimétricos.

          // Ejemplo de cómo se vería un SliverGrid (sin resolver el reto 9)
          // SliverGrid(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) => Image.network('https://picsum.photos/100/100?random=$index', fit: BoxFit.cover),
          //     childCount: 30,
          //   ),
          // ),
        ],
      ),
    );
  }
}