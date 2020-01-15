import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  //Inputs
  String tituloInput;
  //String montoInput;
  final montoController = TextEditingController();

  final Function nuevaTransaccion;

  NewTransaction(this.nuevaTransaccion);

  @override
  Widget build(BuildContext context) {
    //** Input Data */
    return Card(
      elevation:
          5, //mediante el uso de sombras logra un efecto de elevacion en el Card()
      child: Container(
        //se usa container para poder incluir padding a los textfields
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  labelText:
                      "Titulo"), //label para identificar el input al usuario
              onChanged: (val) => tituloInput =
                  val, //se asigna el valor del input a la variable, cada vez que presione una tecla
            ),
            TextField(
              decoration: InputDecoration(labelText: "Monto"),
              /*onChanged: (valor) {
                      montoInput = valor;
                    },*/
              controller:
                  montoController, //otra forma de obtener datos input, es utilizando controllers
            ),
            FlatButton(
              child: Text("Agregar Transacción"),
              textColor: Colors.purple,
              onPressed: () {
                print(
                    tituloInput); //se prueba que se esten recibiendo bien los datos de entrada
                //print(montoInput);
                print(montoController
                    .text); //de esta forma se accede al contenido almacenado en la varible Controller
                if(tituloInput != null && montoController.text != null){
                  nuevaTransaccion(tituloInput, double.parse(montoController.text));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
