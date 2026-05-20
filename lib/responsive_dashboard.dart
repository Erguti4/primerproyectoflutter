import 'package:flutter/material.dart';

class ResponsiveDashboard extends StatelessWidget {
  const ResponsiveDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 900) {
              return _buildDesktopLayout(constraints);
            } else if (constraints.maxWidth > 600) {
              return _buildTabletLayout(constraints);
            } else {
              return _buildMobileLayout(constraints);
            }
          },
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BoxConstraints constraints) {
    return ListView.separated(
      itemCount: 20,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return Container(
          height: 100,
          alignment: Alignment.center,
          color: Colors.blueGrey[100],
          child: Text('Elemento móvil $index'),
        );
      },
    );
  }

  Widget _buildTabletLayout(BoxConstraints constraints) {
    // RETO 1: Adaptación a Tablet mediante GridView
    // OBJETIVO: Optimizar el espacio visual cuando hay más de 600px de ancho.
    // TODO: En el método '_buildTabletLayout', reemplaza el Center por un
    // GridView.builder. Utiliza 'gridDelegate: SliverGridDelegateWithFixedCrossAxisCount'
    // configurando 'crossAxisCount: 2' para mostrar dos columnas, y añade
    // un 'crossAxisSpacing' y 'mainAxisSpacing' de 16.0.
    // RETO 3: Restricciones Forzadas (ConstrainedBox)
    // OBJETIVO: Evitar que elementos específicos crezcan desproporcionadamente.
    // TODO: Dentro de los elementos generados por tu GridView del Reto 1,
    // envuelve el contenido textual en un 'ConstrainedBox' garantizando que
    // el 'minHeight' sea de 80 píxeles, sin importar el texto introducido.
    return const Center(child: Text('Vista de Tablet'));
  }

  Widget _buildDesktopLayout(BoxConstraints constraints) {
    // RETO 2: Implementación de Menú Lateral (Desktop)
    // OBJETIVO: Crear una vista dividida (Split-View) para resoluciones mayores a 900px.
    // TODO: En el método '_buildDesktopLayout', retorna un widget 'Row'.
    // El primer hijo de la fila debe ser un contenedor con ancho fijo (ej. 250px)
    // simulando un menú lateral. El segundo hijo debe ser el contenido principal,
    // pero ATENCIÓN: debes envolverlo en un widget 'Expanded' para evitar errores
    // de overflow en el eje horizontal.
    return const Center(child: Text('Vista de Escritorio'));
  }
}