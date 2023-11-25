
import 'package:path/path.dart';
import 'package:secret_diary/model/privacy.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'memopad.dart';



class DatabaseHandler {
  Future<Database> initializePrivacyDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'privacy.db'),
      onCreate: (database, version) async {
        await database.execute(
            "create table privacy(id integer primary key autoincrement, title text, content text, lat real, lng real, image blob, eventdate text, actiondate text)");
      },
      version: 1,
    );
  }

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

  insertPrivacy(Privacy privacy) async {
    final Database db = await initializePrivacyDB();
    await db.rawInsert(
        "insert into privacy(title, content, image, lat, lng, eventdate, actiondate) values (?,?,?,?,?,?,datetime('now', 'localtime'))",
        [
          privacy.title,
          privacy.content,
          privacy.image,
          privacy.lat,
          privacy.lng,
          privacy.eventdate,
          privacy.actiondate,
        ]);
  } // ----


  Future<List<Privacy>> queryPrivacy() async {
    final Database db = await initializePrivacyDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from privacy');
    return queryResult.map((e) => Privacy.fromMap(e)).toList();
  } // ----

  Future deletePrivacy(int id) async {
    final Database db = await initializePrivacyDB();
    await db.rawDelete('delete from privacy where id = ?', [id]);
  } // ----


  Future updatePrivacy(Privacy privacy) async {
    final Database db = await initializePrivacyDB();
    await db.rawUpdate(
        "update privacy set title = ?, content = ?, eventdate = ?, actiondate = datetime('now', 'localtime') where id = ?",
        [
          privacy.title,
          privacy.content,
          privacy.eventdate,
          privacy.id
        ]);
  } // ---

  Future updatePrivacyALL(Privacy privacy) async {
    final Database db = await initializePrivacyDB();
    await db.rawUpdate(
        "update privacy set title = ?, content = ?, image = ?, eventdate = ?, actiondate = datetime('now', 'localtime') where id = ?",
        [
          privacy.title,
          privacy.content,
          privacy.image,
          privacy.eventdate,
          privacy.id
        ]);
  } // ---

//=======================================================

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