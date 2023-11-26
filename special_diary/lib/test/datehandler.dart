import 'memopad.dart';
import 'sdiary.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeSdiaryDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'sdiary.db'),
      onCreate: (database, version) async {
        await database.execute(
            "create table sdiary(id integer primary key autoincrement, title text, content text, weathericon text, lat real, lng real, image blob, actiondate text)");
      },
      version: 1,
    );
  } // ----

    Future<Database> initializeMemoPadDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'memopad.db'),
      onCreate: (database, version) async {
        await database.execute(
            "create table memopad(id integer primary key autoincrement, memo text, memoinsertdate text)");
      },
      version: 1,
    );
  }

  insertSdiary(Sdiary sdiary) async {
    final Database db = await initializeSdiaryDB();
    await db.rawInsert(
        "insert into sdiary(title, content, weathericon, lat, lng, image, actiondate) values (?,?,?,?,?,?,datetime('now', 'localtime'))",
        [
          sdiary.title,
          sdiary.content,
          sdiary.weathericon,
          sdiary.lat,
          sdiary.lng,
          sdiary.image
        ]);
  } // ----

  Future<List<Sdiary>> querySdiary() async {
    final Database db = await initializeSdiaryDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from sdiary');
    return queryResult.map((e) => Sdiary.fromMap(e)).toList();
  } // ----

  Future deleteSdiary(int id) async {
    final Database db = await initializeSdiaryDB();
    await db.rawDelete('delete from sdiary where id = ?', [id]);
  } // ----

  Future updateSdiary(Sdiary sdiary) async {
    final Database db = await initializeSdiaryDB();
    await db.rawUpdate(
        "update sdiary set title = ?, content = ?, weathericon =?, lat = ?, lng = ?, actiondate = datetime('now', 'localtime') where id = ?",
        [
          sdiary.title,
          sdiary.content,
          sdiary.weathericon,
          sdiary.lat,
          sdiary.lng,
          sdiary.id
        ]);
  } // ---

  Future updateSdiaryAll(Sdiary sdiary) async {
    final Database db = await initializeSdiaryDB();
    await db.rawUpdate(
        "update sdiary set title = ?, content = ?, weathericon = ?, lat = ?, lng = ?, image = ?, actiondate = datetime('now', 'localtime') where id = ?",
        [
          sdiary.title,
          sdiary.content,
          sdiary.weathericon,
          sdiary.lat,
          sdiary.lng,
          sdiary.image,
          sdiary.id
        ]);
  } // ---

//-------------------------------------



  // Memolist 추가
  insertMemoPad(MemoPad memopad) async {
    final Database db = await initializeMemoPadDB();
    await db.rawInsert(
        "insert into memopad(memo, memoinsertdate) values (?,datetime('now', 'localtime'))",
        [memopad.memo]);
  }

  // Memolist 조회
  Future<List<MemoPad>> queryMemoPad() async {
    final Database db = await initializeMemoPadDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from memopad');
    return queryResult.map((e) => MemoPad.fromMap(e)).toList();
  }

  // Memolist 삭제
  Future deleteMemoPad(int id) async {
    final Database db = await initializeMemoPadDB();
    await db.rawDelete('delete from memopad where id = ?', [id]);
  }

  // Memolist 업데이트
  Future updateMemoPad(MemoPad memopad) async {
    final Database db = await initializeMemoPadDB();
    await db.rawUpdate(
        "update memopad set memo = ? , memoinsertdate = datetime('now', 'localtime') where id = ?",
        [
          memopad.memo,
          memopad.id
          ]);
  }
} // DatabaseHandler