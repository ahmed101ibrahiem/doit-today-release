import 'package:doit_today/core/constants/app_settings.dart';
import 'package:doit_today/core/models/request/note.model.dart';
import 'package:doit_today/core/models/request/todo_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlService {
  static Database? _database;

  static SqlService? _instance;

  static Future<SqlService> getInstance() async {
    _instance ??= SqlService();
    _database ??= await _initDB();
    return _instance!;
  }

  static Future<Database> _initDB() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, '${AppSettings.appName}.db');
    return openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE ${AppSettings.todoTable} ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT NOT NULL,'
            'description TEXT,'
            'isCompleted INTEGER NOT NULL DEFAULT 0'
            ')');

        // Create Notes table
        await db.execute('CREATE TABLE ${AppSettings.notesTable} ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT NOT NULL,'
            'content TEXT NOT NULL,'
            'createdAt TEXT NOT NULL'
            ')');
      },
    );
  }

  // ---------------------- ToDo Methods ----------------------

  /// Insert a new ToDo
  Future<void> insertTodo({required TodoModel todo}) async {
    await _database?.insert(
      AppSettings.todoTable,
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Delete a ToDo by ID
  Future<void> deleteTodo(int id) async {
    await _database?.delete(
      AppSettings.todoTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Update a ToDo
  Future<void> updateTodo(TodoModel todo) async {
    await _database?.update(
      AppSettings.todoTable,
      todo.toJson(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  /// Load all ToDos
  Future<List<TodoModel>> loadTodos() async {
    final res = await _database?.query(AppSettings.todoTable);
    if (res != null && res.isNotEmpty) {
      return res.map((json) => TodoModel.fromJson(json)).toList();
    }
    return [];
  }

  /// Clear all ToDos
  Future<int> clearTodoList() async {
    return await _database?.delete(AppSettings.todoTable) ?? 0;
  }

  // ---------------------- Notes Methods ----------------------

  /// Insert a new Note
  Future<void> insertNote({required NoteModel note}) async {
    await _database?.insert(
      AppSettings.notesTable,
      note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Delete a Note by ID
  Future<void> deleteNote(int id) async {
    await _database?.delete(
      AppSettings.notesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Update a Note
  Future<void> updateNote(NoteModel note) async {
    await _database?.update(
      AppSettings.notesTable,
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  /// Load all Notes
  Future<List<NoteModel>> loadNotes() async {
    final res = await _database?.query(AppSettings.notesTable);
    if (res != null && res.isNotEmpty) {
      return res.map((json) => NoteModel.fromJson(json)).toList();
    }
    return [];
  }

  /// Clear all Notes
  Future<int> clearNotesList() async {
    return await _database?.delete(AppSettings.notesTable) ?? 0;
  }
}
