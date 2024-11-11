import 'package:gestion/DatabaseHelper/connection.dart';
import 'package:gestion/DatabaseHelper/tables.dart';
import 'package:gestion/Models/users.dart';

class Repository {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  Future<bool> authenticate(Users users) async {
    final db = await databaseHelper.initDB();
    final authenticated = await db.query(Tables.userTableName,
        where: "username= ? and password= ? ",
        whereArgs: [users.username, users.password]);
    if (authenticated.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> registerUser(Users users) async {
    final db = await databaseHelper.initDB();
    final res = await db.query(Tables.userTableName,
        where: "username = ? ", whereArgs: [users.username]);
    if (res.isNotEmpty) {
      return 0;
    } else {
      return db.insert(Tables.userTableName, users.toMap());
    }
  }

  Future<Users> getLoggedIn(String username) async {
    final db = await databaseHelper.initDB();
    final result = await db.query(Tables.userTableName,
        where: "username = ?", whereArgs: [username]);
    if (result.isNotEmpty) {
      return Users.fromMap(result.first);
    } else {
      throw Exception("User $username not found");
    }
  }
}
