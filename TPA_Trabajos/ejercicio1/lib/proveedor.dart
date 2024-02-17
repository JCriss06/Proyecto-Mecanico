import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Proveedor {
  @HiveField(0)
  String idproveedor = '';
  @HiveField(1) 
  String proveedor = '';

  Proveedor({
    required this.idproveedor,
    required this.proveedor,
  });

  Map<String, dynamic> toMap(){
    return{
      'idproveedor': idproveedor,
      'proveedor': proveedor,
    };
  }

  @override
  String toString(){
    return 'Proveedor{idproveedor: $idproveedor, proveedor: $proveedor}';
  }
}

class ProveedorAdapter extends TypeAdapter <Proveedor>{
  @override
  Proveedor read(BinaryReader reader) {
    return Proveedor(
      idproveedor: reader.read(),
      proveedor: reader.read(),
      );
  }
  
  @override
  int get typeId => 2;

  @override
  void write(BinaryWriter writer, Proveedor obj) {
    writer.write(obj.idproveedor);
    writer.write(obj.proveedor);
  }
}