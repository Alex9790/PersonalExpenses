import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

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
      print("Weekday = "+weekDay.toString());
      print("Weekday = "+DateFormat.E().format(weekDay).toString());
      print("Monto = "+totalSum.toString());
      //se retorna map con el dia y el gasto total
      return {
        "dia": DateFormat.E().format(weekDay).substring(0,1),       //para obtener en texto el dia de la semana, substring para solo obtener la primera letra
        "monto": totalSum,                  
      }; 
    }).reversed.toList();
  }

  //metodo para conocer el total de gasto de la semana
  double get totalSpending{
                                 //.fold(initialValue, combine)
                                              //sum: resultado acumulado despues de cada iteracion por la lista de items, en este caso es solo sumar los montos
    return groupedTransactionValues.fold(0.0, (sum, item){
        return sum + item["monto"];
    }); 
  }

  @override
  Widget build(BuildContext context) {

    print(groupedTransactionValues);

    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(               //se usa para poder agregar padding al Row, ya que desde Row no se puede
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data){      //el metodo GET retorna una Lista, pero para poder mostar en pantalla necesitamos Widgets
                return Flexible(        //para gestionar espaciado dentro de los elementos del Row
                    fit: FlexFit.tight, //se forza a un Widget hijo a respetar su espacio correspondiente sn tomar espacio de los demas hijos
                    child: ChartBar(
                      data["dia"], 
                      data["monto"], 
                      totalSpending == 0.0 ? 0.0 : (data["monto"] as double) / totalSpending), //se debe evitar division entre 0
                    ); 
            }).toList(),
          ),
        ));
  }
}
