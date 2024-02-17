import 'package:ejercicio1/categoria.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CrearCategoria extends StatefulWidget {
  CrearCategoria({super.key});

  @override
  State<CrearCategoria> createState() => _CrearCategoriaState();
}

class _CrearCategoriaState extends State<CrearCategoria> {
  final TextEditingController idcategoriaController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5),
            Text(
              'Categorias',
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
              controller: idcategoriaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Id categoria',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: categoriaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Categoria',
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      Categoria(
                          idcategoria: idcategoriaController.text,
                          categoria: categoriaController.text),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text('Guardar'),
                ),
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent
                  ),
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
