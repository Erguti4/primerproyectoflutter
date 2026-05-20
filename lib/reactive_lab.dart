import 'package:flutter/material.dart';

// RETO FINAL INTENSIVO: Extracción de Lógica y Clean Architecture
// PASO 1: Creación del Modelo/Controlador
// TODO: Crea una clase 'AuthSessionController'. Define dentro un 'ValueNotifier<bool>'
// llamado 'isLogged' inicializado en false. Crea métodos públicos llamados 'login()'
// y 'logout()' que alteren el valor interno simulando autenticación.
class AppController {
  final ValueNotifier<int> contadorEstado = ValueNotifier<int>(0);

  void incrementar() {
    contadorEstado.value++;
  }

  void dispose() {
    contadorEstado.dispose();
  }
}

// PASO 2: La Vista Tonta (Dumb UI)
// TODO: Crea un 'StatelessWidget' principal llamado 'SessionView'. Este widget debe
// recibir tu 'AuthSessionController' por constructor.
class ReactiveArchitectureView extends StatelessWidget {
  final AppController controller;
  
  const ReactiveArchitectureView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Estado Desacoplado')),
      body: Center(
        // PASO 3: Renderizado Condicional Desacoplado
        // TODO: En el body de tu 'SessionView', implementa un 'ValueListenableBuilder'.
        // Evalúa el valor inyectado: Si el valor 'isLogged' es falso, retorna un widget
        // con dos 'TextField' (Usuario y Contraseña) y un botón de "Entrar" que llame al
        // método 'login()' de tu controlador.
        // Si el valor es verdadero, retorna un widget mostrando los datos del usuario
        // y un botón para 'logout()'.

        // PASO 4 (Avanzado): Optimización del Builder.
        // TODO: Documenta el uso del parámetro opcional 'child' dentro del
        // 'ValueListenableBuilder'. Úsalo para pasar un logotipo de la empresa que NO debe
        // repintarse nunca durante los cambios de estado del login.
        child: ValueListenableBuilder<int>(
          valueListenable: controller.contadorEstado,
          builder: (BuildContext context, int valorActual, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (child != null) child,
                const SizedBox(height: 20),
                Text(
                  'Valor centralizado: $valorActual',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
          child: const FlutterLogo(size: 100), // Este widget se pasa como 'child' y no se repinta
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementar,
        child: const Icon(Icons.add),
      ),
    );
  }
}