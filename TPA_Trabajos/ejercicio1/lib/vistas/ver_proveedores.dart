import 'package:ejercicio1/proveedor.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class VerProveedores extends StatelessWidget {
  final List<Proveedor> proveedores;
  const VerProveedores({
    super.key,
    required this.proveedores,
  });

  @override
  Widget build(BuildContext context) {
    var boxproveedores = Hive.box('proveedores')
        .values
        .toList(); //obtengo una lista de producruos
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
      ),
      body: ListView.builder(
        itemCount: boxproveedores.length,
        itemBuilder: (BuildContext context, int index) {
          Proveedor proveedor = boxproveedores[index];
          return ListTile(
            title: Text(proveedor.proveedor),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Id proveedor: ${proveedor.idproveedor}'),
              ],
            ),
          );
        },
      ),

      /*ListView(
        children: boxproveedores
        .map(//recorrer cada uno de los objetos
          (proveedor) => Container(//aqui va adentro de un contenedor
            child: Row(
              children: [
                Text(proveedor.idproveedor),
                //Text(proveedor),
                Text(proveedor.proveedor),
              ],
            ),
          ),
        )
          .toList(),
      ),*/
    );
  }
}
