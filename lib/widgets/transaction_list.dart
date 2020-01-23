import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    /** Lista de Gastos */
    //seccion para la lista de gastos
    //forma de convertir los datos de la clase en una lista de Widget que se pueda mostrar en pantalla
    return Container(
      height: 500,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  //definir marge por ancho y alto
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  //para definir un borde, pero creo que decoration se uede usar par amas
                  decoration: BoxDecoration(
                    border: Border.all(
                    color: Theme.of(context).primaryColor, //para acceder a la opcion de colores definidas en el Tema de la App
                    width: 2,
                  )),
                  //padding en todas direcciones
                  padding: EdgeInsets.all(10),
                  child: Text(
                    //Monto
                    "\$${transactions[index].monto.toStringAsFixed(2)}", //Se usa String Interpolation, se forza mostrar hasta dos decimales
                    style: TextStyle(
                      //definiendo estilo del texto
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      //Titulo del Gasto
                      transactions[index].titulo,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      //Fecha cuando se registro el gasto
                      DateFormat.yMMMd().format(transactions[index].fecha), //definiendo un formato para la fecha
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
