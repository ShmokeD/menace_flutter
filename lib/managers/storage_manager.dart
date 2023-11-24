import 'package:path/path.dart';
import 'package:menace_flutter/managers/manager.dart';
import 'package:sqflite/sqflite.dart';

class StorageManager {
  StorageManager() {
    initializeStorage();
  }
  late final Future<Database> database;

  void initializeStorage() async {
    database = openDatabase(
        join(await getDatabasesPath(), 'weight_database.db'),
        onCreate: (db, version) async => await db.execute(
            'CREATE TABLE weight_values(state TEXT, weights TEXT, PRIMARY KEY(state))'),
        version: 1);
  }

  void storeDisk(Map<GameState, Map<int, double>> stateValues) async {
    final db = await database;
    stateValues.forEach((state, values) async {
      var mapToInsert = {
        'state': state.toString(),
        'weights': values.toString()
      };
      print('INSERTING MAP');
      print(mapToInsert);
      await db.insert('weight_values', mapToInsert,conflictAlgorithm: ConflictAlgorithm.replace);

      print('Store Complete');
    });
  }
}
