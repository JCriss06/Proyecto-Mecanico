import 'package:ejercicio1/producto.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CarritoPage extends StatefulWidget {
  const CarritoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarritoPageState();
  }
}

class _CarritoPageState extends State<CarritoPage> {
  List<Producto> productos = [];
  TextEditingController codigoController = TextEditingController();

  void addProduct() {
    var codigoBarras = codigoController.text;
    var box = Hive.box('productos');
    for (Producto producto in box.values) {
      if (producto.codigo == codigoBarras) {
        //añadir mi producto
        productos.add(producto);
        setState(() {});
        break;
      }
    }
  }

  void verProducts() {
    var box = Hive.box('productos');
    print(box.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: codigoController,
                      decoration: InputDecoration(
                        hintText: 'Codigo de barras',
                      ),
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      addProduct();
                    },
                    child: Icon(Icons.search),
                  ),
                ],
              ),
              Column(
                children: productos
                    .map(
                      (e) => Text(
                        e.nombre,
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            verProducts();
          },
          child: Icon(Icons.add),
        ));
  }
}
