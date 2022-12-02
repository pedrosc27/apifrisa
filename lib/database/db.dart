import 'package:api/domain/models/cart_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static final NotesDatabase instance = NotesDatabase._init();
  final String tableNotes = 'carrito';
  static Database? _database;

  NotesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('FriCarrito.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // ignore: prefer_const_declarations
    final textType = 'TEXT';

    await db.execute('''
CREATE TABLE $tableNotes ( 
 id $idType, 
  nombre $textType,
  imagen $textType,
  descripcion $textType,
  cantidad $textType
  )
''');
  }

  // Agregar un producto al carrito
  Future<int> create(CartModel note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return id;
  }

  //Leer todos los ficheros en la base de datos
  Future<List<CartModel>> readAllNotes() async {
    final db = await instance.database;

    final result = await db.query(tableNotes);

    return result.map((json) => CartModel.fromJson(json)).toList();
  }

  //Actualizar un Producto
  Future<int> update(CartModel note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  //Borrar un Producto
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //Borrar todos los registros
  Future<int> deleteAll() async {
    final db = await instance.database;
    final res = await db.delete('carrito');
    return res;
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
