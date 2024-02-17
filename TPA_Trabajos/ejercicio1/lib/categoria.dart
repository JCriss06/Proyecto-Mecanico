import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Categoria {
  @HiveField(0)
  String idcategoria = '';
  @HiveField(1) 
  String categoria = '';

  Categoria({
    required this.idcategoria,
    required this.categoria,
  });

  Map<String, dynamic> toMap(){
    return{
      'idcategoria': idcategoria,
      'categoria': categoria,
    };
  }

  @override
  String toString(){
    return 'Categoria{idcategoria: $idcategoria, categoria: $categoria}';
  }
}

class CategoriaAdapter extends TypeAdapter <Categoria>{
  @override
  Categoria read(BinaryReader reader) {
    return Categoria(
      idcategoria: reader.read(),
      categoria: reader.read(),
      );
  }
  
  @override
  int get typeId => 1;

  @override
  void write(BinaryWriter writer, Categoria obj) {
    writer.write(obj.idcategoria);
    writer.write(obj.categoria);
  }
}