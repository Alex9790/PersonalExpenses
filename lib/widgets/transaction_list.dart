import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    /** Lista de Gastos */
    //seccion para la lista de gastos
    //forma de convertir los datos de la clase en una lista de Widget que se pueda mostrar en pantalla
    return transactions
            .isEmpty //condicional para el caso en que "transactions" tenga contenido o no
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(children: <Widget>[
                //si no tiene contenido se muestra texto e imagen
                Text(
                  "No hay Gastos registrados.",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ), //puede tener contenido, pero se usa mas que todo para aplicar espaciado
                Container(
                  //se necesita colocar la imagen dentro de un container para poder definir el tamaño a ocupar
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    "assets/images/waiting.png", //ubicacion del asset
                    fit: BoxFit
                        .cover, //pára que se ajusta al tamaño definido por el Container()
                  ),
                ),
              ]);
            },
          )
        : ListView.builder(
            //si tiene contenido se muestra la lista de gastos
            itemBuilder: (context, index) {
              /*return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        //definir marge por ancho y alto
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        //para definir un borde, pero creo que decoration se uede usar par amas
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context)
                              .primaryColor, //para acceder a la opcion de colores definidas en el Tema de la App
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
                            style: Theme.of(context)
                                .textTheme
                                .title, //se asigna el estilo utilizado para los titulos
                          ),
                          Text(
                            //Fecha cuando se registro el gasto
                            DateFormat.yMMMd().format(transactions[index]
                                .fecha), //definiendo un formato para la fecha
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                );*/
              //Alternativa de Card()
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    //en el argumento "leading" se define un widget que se posiciona al inicio de la ListTile()
                    radius: 30,
                    child: Padding(
                      //agregar solo padding
                      padding: EdgeInsets.all(10),
                      child: FittedBox(
                          //ajustar tamaño de texto interno
                          child: Text(
                        "\$${transactions[index].monto.toStringAsFixed(2)}", //texto con dos decimales
                      )),
                    ),
                  ),
                  title: Text(
                    //Titulo del Gasto
                    transactions[index].titulo,
                    style: Theme.of(context)
                        .textTheme
                        .title, //se asigna el estilo utilizado para los titulos
                  ),
                  subtitle: Text(
                    //Fecha cuando se registro el gasto
                    DateFormat.yMMMd().format(transactions[index]
                        .fecha), //definiendo un formato para la fecha
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  //dependiendo del ancho disponible se ecide si se usa un boton con Label o sin Label
                  trailing: MediaQuery.of(context).size.width > 450
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(transactions[index].id),
                          icon: Icon(Icons.delete),
                          label: Text("Eliminar"),
                          //color: Theme.of(context).errorColor,  //Color de todo el boton
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
