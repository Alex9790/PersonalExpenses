import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/user_transaction.dart';

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

  /*void startAddNewTransaction(BuildContext ctx){    
    //funcion para mostrar modal (ventana emergente) que muestre el widget "NewTransaction"
    showModalBottomSheet(context: ctx, builder: (BuildContext context) {  
      return NewTransaction(nuevaTransaccion);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra superior con titulo y opciones
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            //formulario nuevos gastos y lista de gastos
            UserTransactions(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
