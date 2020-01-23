import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
//import './widgets/user_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
      ), //se define tema de la app, y se utiliza primarySwatch para generar diferentes tonalidades
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //lista con transacciones de ejemplo
  final List<Transaction> _userTransactions = [
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

  //metodo para agregar gastos nuevos a la lista
  void _addNewTransaction(String titulo, double monto) {
    final nuevaTransaccion = Transaction(
        titulo: titulo,
        monto: monto,
        fecha: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      //se actualiza el estado del Widget con la nueva lista de gastos
      //_userTransactions es final, pero es el apuntador hacia los datos lo que es constante, asi que se pueden agregar nuevos elementos a esa lista
      //pero no se puede cambiar por otra lista
      _userTransactions.add(nuevaTransaccion);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //funcion para mostrar modal (ventana emergente) que muestre el widget "NewTransaction"
    showModalBottomSheet(
        context: ctx,
        builder: (BuildContext context) {
          //se retorna el widget que se mostrara en la ventana emergente
          return GestureDetector(
            //widget para capturar el evento al interactuar con el Modal
            onTap: () {},                               //funcion al realizar al hacer "tap" sobre modal, no queremos que haga nada (modal se cierra al hacer tap sobre el sin esto)
            child: NewTransaction(_addNewTransaction),  //** Input Data */
            //behavior: HitTestBehavior.opaque,         //creo q esta linea se usaba antes para que onTap funcionara bien, pero ahora sin esta linea funciona igual
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra superior con titulo y opciones
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //como la funcion recibe por parametro el Contexto, es necesario invocarlo desde una funcion anonima
              _startAddNewTransaction(context);
            },
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
            //UserTransactions(_addNewTransaction, _userTransactions),
            /** Lista de Gastos */
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
