import 'package:flutter/cupertino.dart';

import 'transaction_list.dart';
import 'new_transaction.dart';
import '../models/transaction.dart';

class UserTransactions extends StatelessWidget {
  
  final List<Transaction> transactions;
  final Function nuevaTransaccion;

  UserTransactions(this.nuevaTransaccion, this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      //** Input Data */
      NewTransaction(nuevaTransaccion),
      /** Lista de Gastos */
      TransactionList(transactions),
    ],);
  }
}