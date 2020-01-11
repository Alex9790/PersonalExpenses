import 'package:flutter/foundation.dart'; //es la libreria que provee la anotacion @required

class Transaction {
  final String id;
  final String titulo;
  final double monto;
  final DateTime fecha;

  Transaction(
      {@required this.id,
      @required this.titulo,
      @required this.monto,
      @required this.fecha}); //constructor con named parameters
}
