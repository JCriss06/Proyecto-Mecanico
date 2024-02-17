import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:ejercicio1/categoria.dart';
import 'package:ejercicio1/producto.dart';
import 'package:ejercicio1/proveedor.dart';
import 'package:ejercicio1/vistas/carrito.dart';
import 'package:ejercicio1/vistas/crear_carrito.dart';
import 'package:ejercicio1/vistas/crear_categorias.dart';
import 'package:ejercicio1/vistas/crear_producto.dart';
import 'package:ejercicio1/vistas/crear_proveedor.dart';
import 'package:ejercicio1/vistas/ver_categorias.dart';
import 'package:ejercicio1/vistas/ver_productos.dart';
import 'package:ejercicio1/vistas/ver_proveedores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(MyApp());

  await Hive.initFlutter();
  Hive.registerAdapter(ProductoAdapter());
  Hive.registerAdapter(CategoriaAdapter());
  Hive.registerAdapter(ProveedorAdapter());

  var box = await Hive.openBox('productos');
  var box2 = await Hive.openBox('categorias');
  var box3 = await Hive.openBox('proveedores');
  var box4 = await Hive.openBox('ventas');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: const MyHomePage(title: 'Punto de venta'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    this.title = '',
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool errorNombre = false;
  List<Producto> productos = [];
  List<Categoria> categorias = [];
  List<Proveedor> proveedores = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.padding, color: Colors.purple),
                  label: Text('Crear Producto', style: TextStyle(fontSize: 25)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CrearProducto();
                        },
                      ),
                    ).then(
                      (value) {
                        if (value != null) {
                          /** ESTO ES CON HIVE */
                          /** OJO!!! 
                           *  VEAN EL MAIN
                           *   AHÍ YA ABRÍ CON OPENBOX ('PRODUCTOS')
                           *  POR ESO PUEDO USAR HIVE.BOX PORQUE YA ESTA ABIERTO
                           *  SI HACEMOS BOX.CLOSE EN ALGUNA PARTE
                           *  LA CAJA SE CIERRA Y DARA ERROR LO DE ABAJO
                           *  POR LO TANTO ANTES DE USAR HIVE.BOX
                           *  TENEMOS QUE ABRIR LA CAJA CON OPENBOX :)!
                           */
                          var producto = value;
                          var box = Hive.box('productos');
                          box.add(producto);
                          print(box.values);
                        }
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VerProductos(
                          productos: productos,
                        );
                      },
                    ),
                  );
                },
                child: Text('Ver Productos'),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.category, color: Colors.purple),
                  label:
                      Text('Crear Categoria', style: TextStyle(fontSize: 25)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CrearCategoria();
                        },
                      ),
                    ).then(
                      (value) {
                        if (value != null) {
                          var categoria = value;
                          var box2 = Hive.box('categorias');
                          box2.add(categoria);
                          print(box2.values);
                        }
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VerCategorias(
                          categorias: categorias,
                        );
                      },
                    ),
                  );
                },
                child: Text('Ver Categorias'),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.supervisor_account_outlined,
                      color: Colors.purple),
                  label:
                      Text("Crear Proveedor", style: TextStyle(fontSize: 25)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CrearProveedor();
                        },
                      ),
                    ).then(
                      (value) {
                        if (value != null) {
                          var proveedor = value;
                          var box3 = Hive.box('proveedores');
                          box3.add(proveedor);
                          print(box3.values);
                        }
                      },
                    );
                  },
                ),
              ),
              //Padding(padding: EdgeInsets.all(5)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade300,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VerProveedores(
                          proveedores: proveedores,
                        );
                      },
                    ),
                  );
                },
                child: Text('Ver Proveedores'),
              ),
            ],
          ),
          ElevatedButton.icon(
            icon: Icon(Icons.car_repair, color: Colors.purple),
            label: Text("Carrito", style: TextStyle(fontSize: 25)),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CrearCarrito();
                  },
                ),
              ).then(
                (value) {
                  if (value != null) {
                    var ventas = value;
                    var box4 = Hive.box('ventas');
                    box4.add(ventas);
                    print(box4.values);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
