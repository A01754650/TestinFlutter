import 'package:flutter/material.dart';
import '../viewmodels/adivina_vm.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final ViewModel viewModel = ViewModel();
  final TextEditingController controller = TextEditingController();
  String nivel = 'Facil';

  @override
  void initState() {
    super.initState();
    viewModel.nuevoJuego(); // Inicia un nuevo juego al cargar la pantalla
  }

  void adivinar() {
    final input = int.tryParse(controller.text);
    if (input == null) {
      showDialog(context: context, builder: (_) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, ingresa un número válido.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Aceptar'),
            ),
          ],
        );
      });
    }

    bool gano = viewModel.adivinarNum(input!);
    if (gano){
      showDialog(context: context, builder: (_) {
        return AlertDialog(
          title: Text('¡Ganaste!'),
          content: Text('Adivinaste el número ${viewModel.game.numeroO} en ${viewModel.game.intentos} intentos.'),
          actions: [
            TextButton(
              onPressed: () {
                viewModel.nuevoJuego();
                Navigator.of(context).pop();
                setState(() {}); // Actualiza la UI
              },
              child: Text('Jugar de nuevo'),
            ),
          ],
        );
      });
    } else if (viewModel.game.intentos == 0) {
      showDialog(context: context, builder: (_) {
        return AlertDialog(
          title: Text('Perdiste'),
          content: Text('El número era ${viewModel.game.numeroO}. ¡Intenta de nuevo!'),
          actions: [
            TextButton(
              onPressed: () {
                viewModel.nuevoJuego();
                Navigator.of(context).pop();
                setState(() {}); // Actualiza la UI
              },
              child: Text('Jugar de nuevo'),
            ),
          ],
        );
      });
    } else {
      setState(() {}); // Actualiza la UI si no se ganó ni se perdió
      controller.clear(); // Limpia el campo de texto después de enviar el número
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adivina el Número')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  columnas('Mayor', []),
                  SizedBox(width: 30),
                  columnas('Menor', []),
                  SizedBox(width: 30),
                  columnas('Historial', []),
                ],
              ),
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Ingresa un número',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(onPressed: adivinar, child: Text('Enviar')),
              ],
            ),
            SizedBox(height: 20),
            Text("Dificultad: $nivel", style: TextStyle(fontSize: 15)),
            Slider(
              value:
                  [
                    'Facil',
                    'Medio',
                    'Dificil',
                    'Experto',
                  ].indexOf(nivel).toDouble(), // ← Aquí corregido
              min: 0,
              max: 3,
              divisions: 3,
              label: nivel,
              onChanged: (value) {
                setState(() {
                  nivel =
                      ['Facil', 'Medio', 'Dificil', 'Experto'][value.toInt()];
                  viewModel.seledif(nivel);
                  controller.clear();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget columnas(String titulo, List<int> numeros) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(titulo, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: numeros.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      numeros[index].toString(),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
