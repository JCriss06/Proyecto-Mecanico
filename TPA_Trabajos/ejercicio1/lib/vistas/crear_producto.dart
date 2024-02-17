import 'package:flutter/material.dart';
import 'package:ejercicio1/producto.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

class CrearProducto extends StatefulWidget {
  CrearProducto({super.key});

  @override
  State<CrearProducto> createState() => _CrearProductoState();
}

class _CrearProductoState extends State<CrearProducto> {
  final TextEditingController codigoController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  bool _error = false;

  String barcode = '';

  Future<void> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#FF0000',
      'Cancelar',
      true,
      ScanMode.BARCODE,
    );

    setState(() {
      barcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              'Productos',
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(

              controller: TextEditingController(text: barcode),
              //controller: codigoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Codigo de barras',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nombre',
                errorText: _error ? 'Tu texto esta mal' : null,
              ),
              onChanged: (value) {
                setState(() {
                  if (value.contains('.'))
                    _error = true;
                  else
                    _error = false;
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: precioController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Precio',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: cantidadController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cantidad',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: scanBarcode,
                child: Text('Capturar codigo de barras')),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      Producto(
                        codigo: codigoController.text,
                        nombre: nombreController.text,
                        precio: double.parse(precioController.text),
                        cantidad: int.parse(cantidadController.text),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    //primary: Color(Colors.black),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text('Guardar'),
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
