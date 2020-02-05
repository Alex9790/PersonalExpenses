import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  //Inputs
  final Function nuevaTransaccion;

  NewTransaction(this.nuevaTransaccion);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final tituloController = TextEditingController();

  final montoController = TextEditingController();

  void submitData() {
    print(tituloController
        .text); //se prueba que se esten recibiendo bien los datos de entrada
    //print(montoInput);
    print(montoController
        .text); //de esta forma se accede al contenido almacenado en la varible Controller

    if (tituloController.text.isNotEmpty &&
        tituloController.text != null &&
        montoController.text != null) {
      double monto = double.parse(montoController.text);
      if (monto > 0.0) {
        widget.nuevaTransaccion(tituloController.text, monto);
        //para cerrar el Modal al finalizar el insert
        Navigator.of(context).pop();
      }
    }
  }

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
              //onChanged: (val) => tituloInput = val, //se asigna el valor del input a la variable, cada vez que presione una tecla
              controller: tituloController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Monto"),
              /*onChanged: (valor) {
                      montoInput = valor;
                    },*/
              controller:
                  montoController, //otra forma de obtener datos input, es utilizando controllers
              keyboardType: TextInputType
                  .number, //tipo de teclado a mostrar en pantalla cuando se hace focus
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text("No se ha seleccionado una Fecha."),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text("Seleccionar Fecha", style: TextStyle(fontWeight: FontWeight.bold),),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text("Agregar Transacción"),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
