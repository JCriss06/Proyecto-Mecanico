import 'package:hive/hive.dart';

//el typeIdCambia para cada clase
@HiveType(typeId: 0)
class Producto {
  @HiveField(0)
  String codigo = '';
  @HiveField(1)
  String nombre = '';
  @HiveField(2)
  double precio = 0.0;
  @HiveField(3)
  int cantidad = 0;
  //String create_date = DateTime.now();//11/09/2021 12:00:00

  Producto({
    required this.codigo,
    required this.nombre,
    required this.precio,
    required this.cantidad,
  });

  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'nombre': nombre,
      'precio': precio,
      'cantidad': cantidad,
    };
  }

  @override
  String toString() {
    return 'Producto{codigo: $codigo, nombre: $nombre, precio: $precio, cantidad: $cantidad}';
  }
}

class ProductoAdapter extends TypeAdapter<Producto> {
  @override
  Producto read(BinaryReader reader) {
    return Producto(
      codigo: reader.read(),
      nombre: reader.read(),
      precio: reader.read(),
      cantidad: reader.read(),
    );
  }

  //Hay que cambiarlo para cada clase
  //En otras palabras esta clase producto
  //le toca el typeId 0
  //Si tienes Gato le toca el typeId 1
  //Si tienes Perro le toca el typeId 2
  //Si tienes Caballo le toca el typeId 3
  //...
  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Producto obj) {
    writer.write(obj.codigo);
    writer.write(obj.nombre);
    writer.write(obj.precio);
    writer.write(obj.cantidad);
  }
}
