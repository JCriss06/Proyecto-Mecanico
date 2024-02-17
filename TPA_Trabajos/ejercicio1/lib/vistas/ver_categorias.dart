import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../categoria.dart';

class VerCategorias extends StatelessWidget {
  final List<Categoria> categorias;
  VerCategorias({
    super.key,
    required this.categorias,
  });
  var boxcategorias =
      Hive.box('categorias').values.toList(); //obtengo una lista de producruos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
      ),
      body: ListView.builder(
        itemCount: boxcategorias.length,
        itemBuilder: (BuildContext context, int index) {
          Categoria categoria = boxcategorias[index];
          return ListTile(
            title: Text(categoria.categoria),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Id categoria: ${categoria.idcategoria}'),
              ],
            ),
          );
        },
      ),
      /*ListView(
        children: boxcategorias
        .map(//recorrer cada uno de los objetos
          (categoria) => Container(//aqui va adentro de un contenedor
            child: Row(
              children: [
                Text(categoria.idcategoria),
                Text(categoria.categoria),
              ],
            ),
          ),
        )
          .toList(),
      ),*/
    );
  }
}
