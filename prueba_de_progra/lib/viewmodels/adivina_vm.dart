

import '../models/adivina_model.dart';
import 'dart:math';

class ViewModel{

  late GameModel model;
  int mnumero = 10;

  // Guarda los valores para mostrarlos en las columnas 
  List <int> mayor = [];
  List <int> menor = [];
  List <Map<String, double>> historial = []; // Se ocupa una Map para guardar el valor e identificarlos

  GameModel get game => model;

  void nuevoJuego() {
    final random = Random();
    model = GameModel(
      numeroO: random.nextInt(mnumero) + 1,
      historial: [],
      intentos: 4,
    );
    mayor.clear();
    menor.clear();
    historial.clear();
  }

  bool adivinarNum(int numero) {
    model.historial.add(numero);
    model.intentos--;

    if (numero == model.numeroO) {
      historial.add({'valor': numero.toDouble(), 'acierto': 1});
      return true; // Adivinó el número
    } else {
      historial.add({'valor': numero.toDouble(), 'noacierto': 1});
      if (numero > model.numeroO) {
        mayor.add(numero);
      } else {
        menor.add(numero);
      }
      return false; // No adivinó el número 
    }




  }
}
