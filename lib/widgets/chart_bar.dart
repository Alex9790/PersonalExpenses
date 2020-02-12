import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double gasto;
  final double
      gastoPorcentaje; //para conocer el porcentaje del background a colorear

  ChartBar(this.label, this.gasto, this.gastoPorcentaje);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      //para acceder a los constraint definidos para este Widget
      builder: (context, constraint) {
        return Column(
          children: <Widget>[
            Container(
              //se encienra dentro container para poder definir una latura y no se descuadren las barras
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                //encoge tamaño de contenido para que se ajuste al tamaño disponible
                child: Text(
                    "\$${gasto.toStringAsFixed(0)}"), //colocar el gasto sin decimales
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            Container(
              height: constraint.maxHeight *
                  0.6, //a partir del parametro constraint se puede obtener la altura maxima disponible para este Widget
              width: 10,
              //monta widgets uno sobre otro
              child: Stack(
                children: <Widget>[
                  //widget para representar la parte vacia de la barra, con color gris
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: Color.fromRGBO(
                          220, 220, 220, 1), //Color.fromRGBO(r, g, b, opacity)
                      borderRadius:
                          BorderRadius.circular(10), //esquina redondeada
                    ),
                  ),
                  //caja que crece dependiendo del porcentaje suministrado, esta barra representa la parte llena de la barra, es decir, el gasto
                  FractionallySizedBox(
                    heightFactor: gastoPorcentaje, //valor entre 0 y 1
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            BorderRadius.circular(10), //esquina redondeada
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
            ),
            Container(
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        );
      },
    );
  }
}
