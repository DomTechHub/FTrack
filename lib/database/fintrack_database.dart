import 'package:fintrack/data/categories_data.dart';
import 'package:fintrack/models/date_start_to_end_model.dart';
import 'package:fintrack/models/expense_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FintrackDatabase {

  static Database? _database;

  static Future<Database> get database async {

    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase('fintrack.db');
    return _database!;
  }

  static Future<Database> _initDatabase(String filePath) async {

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);

    return await openDatabase(

      path,

      version: 1,

      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },

      onCreate: (db, version) async {

        await db.execute(
          'CREATE TABLE periods(id INTEGER PRIMARY KEY AUTOINCREMENT, startDate TEXT, endDate TEXT, amount REAL)'
        );

        await db.execute(
          'CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount REAL, category TEXT, date TEXT, time TEXT, periodId INTEGER, FOREIGN KEY(periodId) REFERENCES periods(id) ON DELETE CASCADE)'
        );
      },

      onUpgrade: (db, oldVersion, newVersion) async {

        if (oldVersion < newVersion) {

          await db.execute('DROP TABLE IF EXISTS expenses');

          await db.execute('DROP TABLE IF EXISTS periods');

          await db.execute(
            'CREATE TABLE periods(id INTEGER PRIMARY KEY AUTOINCREMENT, startDate TEXT, endDate TEXT, amount REAL)'
          );

          await db.execute(
            'CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount REAL, category TEXT, date TEXT, time TEXT, periodId INTEGER, FOREIGN KEY(periodId) REFERENCES periods(id) ON DELETE CASCADE)'
          );
        }
      },
    );
  }

  // INSERT PERIOD
  static Future<void> insertPeriod(DateStartToEndModel period) async {

    final db = await database;

    await db.insert(
      'periods',
      {
        'startDate': period.startDate.toIso8601String(),
        'endDate': period.endDate.toIso8601String(),
        'amount': period.amount,
      },
    );
  }

  // GET PERIODS
  static Future<List<DateStartToEndModel>> getPeriods() async {

    final db = await database;

    final maps = await db.query('periods');

    return List.generate(maps.length, (index) {

      final item = maps[index];

      return DateStartToEndModel(
        startDate: DateTime.parse(item['startDate'] as String),
        endDate: DateTime.parse(item['endDate'] as String),
        amount: item['amount'] as double,
        id: item['id'] as int,
      );
    });
  }

  // DELETE PERIOD
  static Future<void> deletePeriod(int periodId) async {

    final db = await database;

    await db.delete(
      'periods',
      where: 'id = ?',
      whereArgs: [periodId],
    );
  }


  // INSERT EXPENSE
static Future<void> insertExpense({
  required String name,
  required double amount,
  required String category,
  required DateTime date,
  required DateTime time,
  required int periodId,
}) async {

  final db = await database;

  await db.insert(
    'expenses',
    {
      'name': name,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'periodId': periodId,
    },
  );
}

// GET EXPENSES
static Future<List<ExpenseModel>> getExpenses() async {

  final db = await database;

  final maps = await db.query('expenses');

  return List.generate(maps.length, (index) {

    final item = maps[index];

    final category = categoriesData.firstWhere(
      (category) => category.name == item['category'],
    );

    return ExpenseModel(
      id: item['id'] as int,
      name: item['name'] as String,
      amount: item['amount'] as double,
      category: category,
      date: DateTime.parse(item['date'] as String),
      time: DateTime.parse(item['time'] as String),
      periodId: item['periodId'] as int,
    );
  });
}

// DELETE EXPENSE
static Future<void> deleteExpense(int expenseId) async {

  final db = await database;

  await db.delete(
    'expenses',
    where: 'id = ?',
    whereArgs: [expenseId],
  );
}

  // CLOSE DATABASE
  static Future<void> close() async {

    final db = _database;

    if (db != null) {
      await db.close();
    }
  }
}