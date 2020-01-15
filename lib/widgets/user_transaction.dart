import 'package:flutter/cupertino.dart';

import 'transaction_list.dart';
import 'new_transaction.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
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
  void _addNewTransaction(String titulo, double monto){
    final nuevaTransaccion = Transaction(titulo: titulo, monto: monto, fecha: DateTime.now(), id: DateTime.now().toString());

    setState(() {
      //se actualiza el estado del Widget con la nueva lista de gastos
      //_userTransactions es final, pero es el apuntador hacia los datos lo que es constante, asi que se pueden agregar nuevos elementos a esa lista
      //pero no se puede cambiar por otra lista
      _userTransactions.add(nuevaTransaccion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      //** Input Data */
      NewTransaction(_addNewTransaction),
      /** Lista de Gastos */
      TransactionList(_userTransactions),
    ],);
  }
}