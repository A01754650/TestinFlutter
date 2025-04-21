

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
      intentos: calcInt(),
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
      return true; 
    } else {
      historial.add({'valor': numero.toDouble(), 'noacierto': 1});
      if (numero > model.numeroO) {
        mayor.add(numero);
      } else {
        menor.add(numero);
      }
      return false; 
    }
  
  }

  void seledif(String nivel){
    switch (nivel) {
      case 'Facil':
        mnumero = 10;
        break;
      case 'Medio':
        mnumero = 50;
        break;
      case 'Dificil':
        mnumero = 100;
        break;
      case 'Experto':
        mnumero = 1000;
        break;
      default:
        mnumero = 10; 
    }
    nuevoJuego();
  }

  int calcInt(){
    if (mnumero == 10){
      return 5;
    }else if (mnumero == 20){
      return 8; 
    }else if (mnumero == 100){
      return 15;
    }else if (mnumero == 1000){
      return 25;
  }
  return 5; 
  }
}