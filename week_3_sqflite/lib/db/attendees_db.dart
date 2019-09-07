import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:week_3_sqflite/db/model/attendees_model.dart';

class AttendeesDataBaseHelper {
  /// Here we create the instance of the class at the time of declaring the static data member,
  /// so instance of the class is created at the time of classloading.
  /// It represents Singleton Design pattern of Early instantiation
  static final AttendeesDataBaseHelper _dataBaseHelperInstance =
      new AttendeesDataBaseHelper.internal();

  ///Private constructor, it will prevent to instantiate the Singleton class from outside the class.

  /// Using private constructor we can ensure that no more than one object can be created at a time.
  /// By providing a private constructor you prevent class instances from being created in any place other than this very class.
  AttendeesDataBaseHelper.internal();

  /// Use the factory keyword when implementing a constructor that doesn't always create a new instance of its class.
  /// For example, a factory constructor might return an instance from a cache, or it might return an instance of a subtype.
  factory AttendeesDataBaseHelper() => _dataBaseHelperInstance;

  /// Database table name and it should be final and it should not be changed. That's why we declared as final
  final String attendeesTable = 'Attendees';

  /// Base class of Database from Sqflite plugin. It's an abstract class to send SQL commands for CRUD Operations
  static Database _attendeesDatabase;

  /// To perform asynchronous operations in Dart, you can use the Future class and the async and await keywords.
  ///
  /// refer to this link for better understanding of the Future, async and await keywords
  /// https://dart.dev/codelabs/async-await
  ///
  /// A future (lower case “f”) is an instance of the Future (capitalized “F”) class.
  /// A future represents the result of an asynchronous operation, and can have two states: uncompleted or completed.
  Future<Database> get db async {
    if (_attendeesDatabase != null) {
      return _attendeesDatabase;
    }
    _attendeesDatabase = await initDb();

    return _attendeesDatabase;
  }

  /// For async keyword, please refer to the below link
  /// https://dart.dev/guides/language/language-tour#asynchrony-support
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'attendees.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  /// Method to create the DB with Database variable and Dbversion
  void _onCreate(Database db, int dbVersion) async {
    await db.execute(
        "CREATE TABLE $attendeesTable(id INTEGER PRIMARY KEY, firstName TEXT, "
        "lastName TEXT, password TEXT, reEnterPassword TEXT, mobileNumber TEXT, "
        "emailId TEXT, gender INTEGER, city TEXT, state TEXT, address TEXT)");
  }

  /// Method to insert the data into DB with insert query by passing table name and model data
  Future<int> saveAttendeesDetails(Attendees attendees) async {
    var dbClient = await db;
    int result = await dbClient.insert(attendeesTable, attendees.toMap());
    return result;
  }

  /// Method to fetch all the user information from the Database using rawQuery
  Future<List<Attendees>> getUser() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Attendees');
    List<Attendees> employees = new List();
    for (int i = 0; i < list.length; i++) {
      var user = new Attendees(
        firstName: list[i]["firstName"],
        lastName: list[i]["lastName"],
        state: list[i]["state"],
        mobileNumber: list[i]["mobileNumber"],
        gender: list[i]["gender"],
        city: list[i]["city"],
        address: list[i]["address"],
        emailId: list[i]["emailId"],
        password: list[i]["password"],
        reEnterPassword: list[i]["reEnterPassword"],
      );
      user.setUserId(list[i]["id"]);
      employees.add(user);
    }
    print("DB data.... " + employees.toString());
    return employees;
  }

  /// Method to fetch all the user information from the Database using rawQuery
  Future<int> deleteUsers(Attendees attendees) async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM Attendees WHERE id = ?', [attendees.id]);
    return res;
  }

  /// Method to delete all the user information from the Database using rawDelete
  Future<int> deleteAllUsers() async {
    var dbClient = await db;
    int res = await dbClient
        .rawDelete('DELETE FROM Attendees');
    return res;
  }

  /// Method to update the attendees information using update query.
  Future<bool> update(Attendees attendees) async {
    print(attendees.toMap());
    var dbClient = await db;
    int res = await dbClient.update("Attendees", attendees.toMap(),
        where: "id = ?", whereArgs: <int>[attendees.id]);
    print(res);
    return res > 0 ? true : false;
  }

}
