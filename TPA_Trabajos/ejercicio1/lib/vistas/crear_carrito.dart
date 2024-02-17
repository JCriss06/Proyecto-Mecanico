import 'package:flutter/material.dart';

class CrearCarrito extends StatefulWidget {
  const CrearCarrito({super.key});

  @override
  State<CrearCarrito> createState() => _CrearCarritoState();
}

class _CrearCarritoState extends State<CrearCarrito> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de compras'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(5.0)),
            Text('Venta:'),
            Row(
              children: [
               /*TextField(
              controller: (){},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Buscar producto',
              ),
            ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
