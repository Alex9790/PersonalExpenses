import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //permite formatear la fecha

class NewTransaction extends StatefulWidget {
  //Inputs
  final Function nuevaTransaccion;

  NewTransaction(this.nuevaTransaccion);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _tituloController = TextEditingController();
  final _montoController = TextEditingController();
  DateTime _fechaSeleccionada;

  void _submitData() {
    print(_tituloController
        .text); //se prueba que se esten recibiendo bien los datos de entrada
    //print(montoInput);
    print(_montoController
        .text); //de esta forma se accede al contenido almacenado en la varible Controller

    if (_tituloController.text.isNotEmpty &&
        _tituloController.text != null &&
        _montoController.text != null &&
        _fechaSeleccionada != null) {
      double monto = double.parse(_montoController.text);
      if (monto > 0.0) {
        widget.nuevaTransaccion(
            _tituloController.text, monto, _fechaSeleccionada);
        //para cerrar el Modal al finalizar el insert
        Navigator.of(context).pop();
      }
    }
  }

  void _presentDatePicker() {
    showDatePicker(
            context:
                context, //context que viene incluido en el State de la clase
            initialDate: DateTime
                .now(), //fecha inicial que se mostrara al abrir el Datepicker
            firstDate: DateTime(2019), //restriccion para fecha mas antigua
            lastDate: DateTime
                .now() //restriccion para fecha mas reciente o futura, en este caso no se permite fechas a futuro
            )
        .then((fechaSeleccionada) {
      //funcion que se ejecuta despues de que el usuario selecciona una fecha o cancele
      if (fechaSeleccionada == null) {
        //si el usuario cancela retorna null
        return;
      }
      setState(() {
        //Actualizar el Widget
        this._fechaSeleccionada =
            fechaSeleccionada; //de seleccionar una fecha se setea la variable global
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //** Input Data */
    return SingleChildScrollView( //para que se pueda hacer scroll cuando se despligue el teclado virtual
          child: Card(
        elevation:
            5, //mediante el uso de sombras logra un efecto de elevacion en el Card()
        child: Container(
          //se usa container para poder incluir padding a los textfields
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,  //para que se desplace hacia arriba tanto como opcupe el teclado
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    labelText:
                        "Titulo"), //label para identificar el input al usuario
                //onChanged: (val) => tituloInput = val, //se asigna el valor del input a la variable, cada vez que presione una tecla
                controller: _tituloController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Monto"),
                /*onChanged: (valor) {
                        montoInput = valor;
                      },*/
                controller:
                    _montoController, //otra forma de obtener datos input, es utilizando controllers
                keyboardType: TextInputType
                    .number, //tipo de teclado a mostrar en pantalla cuando se hace focus
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    //para formatear la fecha seleccionada
                    Expanded(
                        //para darle todo el espacio disponible al texto, darle solo lo necesario al boton manteniendolo en el extremo derecho de la pantalla
                        child: Text(
                      _fechaSeleccionada == null
                          ? "No se ha seleccionado una Fecha."
                          : "Fecha Seleccionada: ${DateFormat.yMd().format(_fechaSeleccionada)}",
                    )),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        "Seleccionar Fecha",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text("Agregar Transacción"),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
