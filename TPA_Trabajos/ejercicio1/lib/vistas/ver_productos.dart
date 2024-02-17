import 'package:ejercicio1/producto.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class VerProductos extends StatelessWidget {
  final List<Producto> productos;
  const VerProductos({
    super.key,
    required this.productos,
  });

  @override
  Widget build(BuildContext context) {
    var boxproductos =
        Hive.box('productos').values.toList(); //obtengo una lista de producruos
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: boxproductos.length,
        itemBuilder: (BuildContext context, int index) {
          Producto producto = boxproductos[index];
          return ListTile(
            title: Text(producto.nombre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Código: ${producto.codigo}'),
                Text('Precio: ${producto.precio.toString()}'),
                Text('Cantidad: ${producto.cantidad.toString()}'),
              ],
            ),
          );
        },
      ),
      /*ListView(
        children: boxproductos
        .map(//recorrer cada uno de los objetos
          (producto) => Container(//aqui va adentro de un contenedor
            child: Row(
              children: [
                Text(producto.codigo),
                Text(producto.nombre),
                Text(producto.precio.toString()),
                Text(producto.cantidad.toString()),
              ],
            ),
          ),
        )
          .toList(),
      ),*/
    );
  }
}
