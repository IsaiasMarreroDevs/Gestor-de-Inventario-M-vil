import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseDatosInventario {
  static final BaseDatosInventario _instancia = BaseDatosInventario._interno();
  static Database? _baseDeDatos;

  BaseDatosInventario._interno();

  factory BaseDatosInventario() => _instancia;

  Future<Database> get baseDeDatos async {
    if (_baseDeDatos != null) return _baseDeDatos!;
    _baseDeDatos = await _inicializarBD();
    return _baseDeDatos!;
  }

  Future<Database> _inicializarBD() async {
    final rutaBD = await getDatabasesPath();
    final rutaCompleta = join(rutaBD, 'inventario.db');

    return await openDatabase(
      rutaCompleta,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE productos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            descripcion TEXT,
            cantidad INTEGER NOT NULL,
            precio REAL NOT NULL,
            imagen TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertarProducto(Map<String, dynamic> producto) async {
    final db = await baseDeDatos;
    return await db.insert('productos', producto);
  }

  Future<List<Map<String, dynamic>>> obtenerProductos() async {
    final db = await baseDeDatos;
    return await db.query('productos', orderBy: 'nombre');
  }

  Future<int> actualizarProducto(int id, Map<String, dynamic> producto) async {
    final db = await baseDeDatos;
    return await db
        .update('productos', producto, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> eliminarProducto(int id) async {
    final db = await baseDeDatos;
    return await db.delete('productos', where: 'id = ?', whereArgs: [id]);
  }
}
