import 'package:flutter/material.dart';
import '../viewmodels/adivina_vm.dart';

class Screen  extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final ViewModel viewModel = ViewModel();
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.nuevoJuego(); // Inicia un nuevo juego al cargar la pantalla
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adivina el Número'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  _buildColumn('Mayor', []),
                  SizedBox(width: 30),
                  _buildColumn('Menor', []),
                  SizedBox(width: 30),
                  _buildColumn('Historial', []),
                ],
              ),
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Ingresa un número',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
        
      ),

      
    );
  }

  Widget _buildColumn(String title, List<int> numbers) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10), 
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      numbers[index].toString(),
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
