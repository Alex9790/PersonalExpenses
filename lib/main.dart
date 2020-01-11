import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transacciones = [
    Transaction(
      id: "1",
      titulo: "Zapatos",
      monto: 10.10,
      fecha: DateTime.now(),
    ),
    Transaction(
      id: "2",
      titulo: "Comida",
      monto: 20.20,
      fecha: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra superior con titulo y opciones
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //seccion para el grafico resumen, con Container puedes definir el tamaño que cubre
          Container(
            width: double.infinity, //tanto espacio como sea posible
            child: Card(
              color: Colors.blue,
              child: Text("Grafico"),
            ),
          ),
          //seccion para la lista de gastos
          //forma de convertir los datos de la clase en una lista de Widget que se pueda mostrar en pantalla
          Column(
            children: transacciones.map((transaccion) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      //definir marge por ancho y alto
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      //para definir un borde, pero creo que decoration se uede usar par amas
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      )),
                      //padding en todas direcciones
                      padding: EdgeInsets.all(10),
                      child: Text(
                        //Monto
                        "\$${transaccion.monto}",        //Se usa String Interpolation
                        style: TextStyle(
                          //definiendo estilo del texto
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[                        
                        Text(                   //Titulo del Gasto
                          transaccion.titulo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(                   //Fecha cuando se registro el gasto
                          DateFormat.yMMMd().format(transaccion.fecha),         //definiendo un formato para la fecha
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
