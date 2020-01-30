import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction>
      recentTransactions; //lista de transacciones registradas

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    //lista de transacciones por dia
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      ); //fume: la idea es restarle al dia de hoy el indice. index = 0 = hoy; index = 1 = ayer; index = 2 = antier......

      var totalSum = 0.0;  //suma total de gastos del dia, sino se inicializa se debe especificar el tipo de dato (double totalSum)

      for(var i=0; i < recentTransactions.length; i++){
        //validar solo gastos de la fecha indicada
        if(recentTransactions[i].fecha.day == weekDay.day &&
            recentTransactions[i].fecha.month == weekDay.month &&
            recentTransactions[i].fecha.year == weekDay.year){
              //suma total de gastos
              totalSum += recentTransactions[i].monto;
        }
      }
      //se retorna map con el dia y el gasto total
      return {
        "dia": DateFormat.E(weekDay),       //para obtener en texto el dia de la semana
        "monto": totalSum,                  
      }; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
          children: <Widget>[],
        ));
  }
}
