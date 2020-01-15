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

  //Inputs
  String tituloInput;
  //String montoInput;
  final montoController = TextEditingController(); 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra superior con titulo y opciones
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start, //se comenta por q es la opcion por defecto
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /** Grafico Resumen */
          //seccion para el grafico resumen, con Container puedes definir el tamaño que cubre
          Container(
            width: double.infinity, //tanto espacio como sea posible
            child: Card(
              color: Colors.blue,
              child: Text("Grafico"),
            ),
          ),
          //** Input Data */
          Card(
            elevation:
                5, //mediante el uso de sombras logra un efecto de elevacion en el Card()
            child: Container(              
              //se usa container para poder incluir padding a los textfields
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "Titulo"),   //label para identificar el input al usuario
                    onChanged: (val) => tituloInput = val,              //se asigna el valor del input a la variable, cada vez que presione una tecla
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Monto"),
                    /*onChanged: (valor) {
                      montoInput = valor;
                    },*/
                    controller: montoController,      //otra forma de obtener datos input, es utilizando controllers
                  ),
                  FlatButton(
                    child: Text("Agregar Transacción"),
                    textColor: Colors.purple,
                    onPressed: () {
                      print(tituloInput);   //se prueba que se esten recibiendo bien los datos de entrada
                      //print(montoInput);
                      print(montoController.text);  //de esta forma se accede al contenido almacenado en la varible Controller
                    },   
                  ),
                ],
              ),
            ),
          ),
          /** Lista de Gastos */
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
                        "\$${transaccion.monto}", //Se usa String Interpolation
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
                        Text(
                          //Titulo del Gasto
                          transaccion.titulo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          //Fecha cuando se registro el gasto
                          DateFormat.yMMMd().format(transaccion
                              .fecha), //definiendo un formato para la fecha
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
