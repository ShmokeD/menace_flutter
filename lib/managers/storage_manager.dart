import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'game_state.dart';

class StorageManager {
  StorageManager() {
    initializeStorage();
  }
  late final Future<Database> database;
  bool isReady = false;

  Future<bool> initializeStorage() async {
    try {
      database = openDatabase(
          join(await getDatabasesPath(), 'weight_database.db'),
          onCreate: (db, version) async => db.transaction((txn) async =>
              await txn.execute(
                  'CREATE TABLE weight_values(state TEXT, weights TEXT, PRIMARY KEY(state))')), // package documentation asks to always do txns
          version: 1);
      isReady = true;
      return true;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      return false;
    }
  }

  void storeDisk(Map<GameState, Map<int, int>> stateValues) async {
    if (kDebugMode) {
      print("Saving $stateValues");
    }
    final db = await database;
    stateValues.forEach((state, values) async {
      var newMap = values.map((key, value) => MapEntry(key.toString(), value));
      var mapToInsert = {
        'state': state.toUint8List(), // To be converted to Uint8List
        'weights': json.encode(newMap)
      };
      await db.transaction((txn) => txn.insert('weight_values', mapToInsert,
          conflictAlgorithm: ConflictAlgorithm.replace));
    });
  }

  void resetDisk() async {
    final db = await database;
    db.delete('weight_values');
    if (kDebugMode) {
      print("Table Cleared");
    }
  }

  Future<Map<GameState, Map<int, int>>> readDisk() async {
    final db = await database;
    Map<GameState, Map<int, int>> stateValues = {};
    var query = await db.query('weight_values');
    for (var svPair in query) {
      GameState state = GameState.fromUint8List(svPair['state'] as Uint8List);

      Map<int, int> weights = (jsonDecode(svPair['weights'] as String) as Map)
          .map((key, value) => MapEntry(int.parse(key), value));

      stateValues[state] = weights;
    }
    if (kDebugMode) {
      print('read $stateValues');
    }
    return stateValues;
  }
}
