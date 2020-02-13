import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
//import './widgets/user_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  //para impedir Landscape Mode (investigar bien porque no me funciono)
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                //definir estilo de titulos
                fontFamily: "OpenSans",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold), //definir estilo de botones
            ),
        appBarTheme: AppBarTheme(
          //tema particular solo para el AppBar
          textTheme: ThemeData.light().textTheme.copyWith(
                //ahora se define que exactamente del tema principal quieres sobreescribir
                title: TextStyle(
                  //en este caso el titulo
                  fontFamily: "OpenSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
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

  //para el activar/desactivar el Switch que mustra el grafico
  bool _mostrarGrafico = false;

  //metodo para extraer de la lista de transaciones totales, solo las de la ultima semana
  List<Transaction> get _transaccionesRecientes {
    //metodo de List para generar una lista con los elementos que cumplan la condicion
    return _userTransactions.where((tx) {
      //transacciones con fecha despues de (hoy - 7 dias)
      return tx.fecha.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList(); //where() retorna un "Iterable" no una List, asi que se debe convertir a List
  }

  //metodo para agregar gastos nuevos a la lista
  void _addNewTransaction(String titulo, double monto, DateTime fecha) {
    final nuevaTransaccion = Transaction(
        titulo: titulo,
        monto: monto,
        fecha: fecha,
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
            onTap:
                () {}, //funcion al realizar al hacer "tap" sobre modal, no queremos que haga nada (modal se cierra al hacer tap sobre el sin esto)
            child: NewTransaction(_addNewTransaction), //** Input Data */
            //behavior: HitTestBehavior.opaque,         //creo q esta linea se usaba antes para que onTap funcionara bien, pero ahora sin esta linea funciona igual
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    //para conocer si el dispositivo se encuentra en Portrait o Landscape Mode
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
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
    );
    final listaGastosWidget = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.9,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    return Scaffold(
      //barra superior con titulo y opciones
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start, //se comenta por q es la opcion por defecto
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /** Grafico Resumen */
            //seccion para el grafico resumen, con Container puedes definir el tamaño que cubre
            /*Container(
              width: double.infinity, //tanto espacio como sea posible
              child: Card(
                color: Colors.blue,
                child: Text("Grafico"),
              ),
            ),*/
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Gráfico"),
                  //literalmente muestra un suiche para activar/desactivar
                  Switch(
                    value: _mostrarGrafico,
                    onChanged: (val) {
                      setState(() {
                        _mostrarGrafico = val;
                      });
                    },
                  ),
                ],
              ),
            //para mostrar grafico y lista cuando Portraint Mode
            if (!isLandscape)
              Container(
                //se usa la clase MediaQuery para obtener la altuma maxima disponible
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_transaccionesRecientes),
              ),
            if (!isLandscape)
              listaGastosWidget,
            //si se encuentra en Landscape Mode se alterna entre lista y grafico segun el estado del Switch
            if (isLandscape)
              _mostrarGrafico
                  ? //se muestra el grafico o la lista
                  Container(
                      //se usa la clase MediaQuery para obtener la altuma maxima disponible
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: Chart(_transaccionesRecientes),
                    )
                  :
                  //formulario nuevos gastos y lista de gastos
                  //UserTransactions(_addNewTransaction, _userTransactions),
                  /** Lista de Gastos */
                  listaGastosWidget,
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
