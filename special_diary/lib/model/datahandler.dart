
// import 'package:path/path.dart';
// import 'package:secret_diary/model/specialdiary.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

// import 'memopad.dart';



// class DatabaseHandler {
//   Future<Database> initializeSpecialDiaryDB() async {
//     String path = await getDatabasesPath();
//     return openDatabase(
//       join(path, 'specialdiary.db'),
//       onCreate: (database, version) async {
//         await database.execute(
//             "create table specialdiary(id integer primary key autoincrement, title text, content text, lat real, lng real, image blob, eventdate text, actiondate text)");
//       },
//       version: 1,
//     );
//   }

//   Future<Database> initializeMemoPadDB() async {
//     String path = await getDatabasesPath();
//     return openDatabase(
//       join(path, 'memopad.db'),
//       onCreate: (database, version) async {
//         await database.execute(
//             "create table memopad(id integer primary key autoincrement, memo text, memoinsertdate text)");
//       },
//       version: 1,
//     );
//   }

//   insertSpecialDiary(SpecialDiary specialdiary) async {
//     final Database db = await initializeSpecialDiaryDB();
//     await db.rawInsert(
//         "insert into specialdiary(title, content, image, lat, lng, eventdate, actiondate) values (?,?,?,?,?,?,datetime('now', 'localtime'))",
//         [
//           specialdiary.title,
//           specialdiary.content,
//           specialdiary.image,
//           specialdiary.lat,
//           specialdiary.lng,
//           specialdiary.eventdate,
//           specialdiary.actiondate,
//         ]);
//   } // ----


//   Future<List<SpecialDiary>> querySpecialDiary() async {
//     final Database db = await initializeSpecialDiaryDB();
//     final List<Map<String, Object?>> queryResult =
//         await db.rawQuery('select * from specialdiary');
//     return queryResult.map((e) => SpecialDiary.fromMap(e)).toList();
//   } // ----

//   Future deleteSpecialDiary(int id) async {
//     final Database db = await initializeSpecialDiaryDB();
//     await db.rawDelete('delete from specialdiary where id = ?', [id]);
//   } // ----


//   Future updateSpecialDiary(SpecialDiary specialdiary) async {
//     final Database db = await initializeSpecialDiaryDB();
//     await db.rawUpdate(
//         "update specialdiary set title = ?, content = ?, eventdate = ?, actiondate = datetime('now', 'localtime') where id = ?",
//         [
//           specialdiary.title,
//           specialdiary.content,
//           specialdiary.eventdate,
//           specialdiary.id
//         ]);
//   } // ---

//   Future updateSpecialDiaryALL(SpecialDiary specialdiary) async {
//     final Database db = await initializeSpecialDiaryDB();
//     await db.rawUpdate(
//         "update specialdiary set title = ?, content = ?, image = ?, eventdate = ?, actiondate = datetime('now', 'localtime') where id = ?",
//         [
//           specialdiary.title,
//           specialdiary.content,
//           specialdiary.image,
//           specialdiary.eventdate,
//           specialdiary.id
//         ]);
//   } // ---

// //=======================================================

//   // Memolist 추가
//   insertMemoPad(MemoPad memopad) async {
//     final Database db = await initializeMemoPadDB();
//     await db.rawInsert(
//         "insert into memopad(memo, memoinsertdate) values (?,datetime('now', 'localtime'))",
//         [memopad.memo]);
//   }

//   // Memolist 조회
//   Future<List<MemoPad>> queryMemoPad() async {
//     final Database db = await initializeMemoPadDB();
//     final List<Map<String, Object?>> queryResult =
//         await db.rawQuery('select * from memopad');
//     return queryResult.map((e) => MemoPad.fromMap(e)).toList();
//   }

//   // Memolist 삭제
//   Future deleteMemoPad(int id) async {
//     final Database db = await initializeMemoPadDB();
//     await db.rawDelete('delete from memopad where id = ?', [id]);
//   }

//   // Memolist 업데이트
//   Future updateMemoPad(MemoPad memopad) async {
//     final Database db = await initializeMemoPadDB();
//     await db.rawUpdate(
//         "update memopad set memo = ? , memoinsertdate = datetime('now', 'localtime') where id = ?",
//         [
//           memopad.memo,
//           memopad.id
//           ]);
//   }
// } // DatabaseHandler