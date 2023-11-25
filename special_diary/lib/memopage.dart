import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:secret_diary/eventupdate.dart';
import 'package:secret_diary/model/datahandler.dart';
import 'package:intl/intl.dart';
import 'package:secret_diary/model/memopad.dart';
import 'components/insertbottomsheet.dart';
import 'components/updatebottomsheet.dart';
import 'model/privacy.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  late TextEditingController memoController;
  late TextEditingController memoModifyController;
  late ScrollController scrollController;
  late DatabaseHandler handler;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    memoController = TextEditingController();
    memoModifyController = TextEditingController(); 
    handler = DatabaseHandler();
    handler.initializeMemoPadDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
              hintText: '검색어를 입력해 주세요.', suffixIcon: Icon(Icons.search)),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
      ),
      body: FutureBuilder(
        future: handler.queryMemoPad(),
        builder: (BuildContext context, AsyncSnapshot<List<MemoPad>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              // reverse: true, // 역순으로 정렬

              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                if (searchText.isNotEmpty &&
                    !snapshot.data![index].memo
                        .toLowerCase()
                        .contains(searchText.toLowerCase())) {
                  return SizedBox.shrink();
                } else {
                  return Slidable(
                    startActionPane: ActionPane(
                        motion: BehindMotion(), //
                        children: [
                          SlidableAction(
                            //버튼 눌렀을때 action
                            backgroundColor: Colors.green,
                            icon: Icons.edit,
                            label: 'Edit',
                            onPressed: (context) {
                              Get.bottomSheet(
                                UpdateBottomSheet(
                                  memoModifyController: memoModifyController,
                                  onPressed: () {
                                    updateAction()!
                                        .then((value) => reloadData());
                                  },
                                ),
                              );
                            },
                          )
                        ]),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.elliptical(20, 20))),
                      child: Container(
                        height: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                              child: Text(
                                  snapshot.data![index].memoinsertdate != null
                                      ? DateFormat('yyyy-MM-dd').format(
                                          snapshot.data![index].memoinsertdate!)
                                      : 'No Date'),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                              child: Text(
                                snapshot.data![index].memo,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            return CircularProgressIndicator(); // 혹은 다른 로딩 인디케이터를 여기에 추가할 수 있습니다.
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            InsertBottomSheet(
              memoController: memoController,
              onPressed: () {
                insertAction()!.then((value) => reloadData());
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //---Function---

  reloadData() {
    handler.queryPrivacy();
    setState(() {});
  }

  insertAction() async {
    //순서가 필요할때 무조건 async
    String memo = memoController.text;

    var memoInsert = MemoPad(memo: memo, memoinsertdate: DateTime.now());

    await handler.insertMemoPad(memoInsert);
    _showInsertDialog();
  }

  _showInsertDialog() {
    Get.defaultDialog(
        title: '입력결과',
        middleText: '입력이 완료되었습니다.',
        barrierDismissible: false,
        backgroundColor: Colors.pink[100],
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text('OK'))
        ]);
  }

  updateAction() async {
    //순서가 필요할때 무조건 async
    String memo = memoModifyController.text;

    var memoUpdate = MemoPad(memo: memo, memoinsertdate: DateTime.now());

    await handler.updateMemoPad(memoUpdate);
    _showUpdateDialog();
  }

  _showUpdateDialog() {
    Get.defaultDialog(
        title: '수정결과',
        middleText: '수정이 완료되었습니다.',
        barrierDismissible: false,
        backgroundColor: Color.fromARGB(255, 173, 181, 227),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text('OK'))
        ]);
  }
} //END
