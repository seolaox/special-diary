import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'model/datehandler.dart';
import 'model/memopad.dart';

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
            snapshot.data!.sort((a, b) {
              // memoinsertdate를 기준으로 내림차순으로 정렬
              final aDate = a.memoinsertdate;
              final bDate = b.memoinsertdate;

              if (aDate != null && bDate != null) {
                return bDate.compareTo(aDate);
              } else {
                return 0;
              }
            });

            return ListView.builder(
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
                            backgroundColor: Color.fromARGB(255, 190, 201, 244),
                            icon: Icons.edit,
                            label: 'Edit',
                            onPressed: (context) {
                              updateBottomSheet(snapshot.data![index]);
                            },
                          )
                        ]),
                    endActionPane: ActionPane(
                        motion: BehindMotion(), //
                        children: [
                          SlidableAction(
                            //버튼 눌렀을때 action
                            backgroundColor:
                                const Color.fromARGB(255, 255, 158, 151),
                            icon: Icons.delete,
                            label: 'Delete',
                            onPressed: (context) async {
                              await handler
                                  .deleteMemoPad(snapshot.data![index].id!);
                              snapshot.data!.remove(snapshot.data![index]);
                              setState(() {});
                            },
                          ),
                        ]),
                    child: GestureDetector(
                      onTap: () {
                        updateBottomSheet(snapshot.data![index]);
                      },
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
                                      : 'No Date',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
                                child: Text(
                                  snapshot.data![index].memo,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1, // 한 줄을 초과하면 말줄임표(ellipsis)를 표시
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
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
          insertBottomSheet();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  //---Function---

  reloadData() {
    handler.queryMemoPad();
    setState(() {});
  }

  insertBottomSheet() {
    Get.bottomSheet(Container(
      width: 500,
      height: 700,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '- MEMO -',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextField(
              controller: memoController,
              maxLength: 200,
              decoration: const InputDecoration(
                hintText: '내용을 입력해 주세요. ',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 13,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              insertAction()!.then((value) => reloadData());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 50),
              backgroundColor: Color.fromARGB(255, 151, 161, 252),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "입력",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 234, 234, 236),
              ),
            ),
          ),
        ],
      ),
    ));
    memoController.clear();
  }

  insertAction() async {
    //순서가 필요할때 무조건 async
    String memo = memoController.text;

    var memoInsert = MemoPad(memo: memo, memoinsertdate: DateTime.now());

    await handler.insertMemoPad(memoInsert);
    Get.back();
    Get.back();
  }

  updateBottomSheet(MemoPad memo) {
    memoModifyController.text = memo.memo;
    Get.bottomSheet(Container(
      width: 500,
      height: 700,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '- MEMO -',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextField(
              controller: memoModifyController,
              maxLength: 200,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 13,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              updateAction(memo.id!)!.then((value) => reloadData());
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 50),
              backgroundColor: Color.fromARGB(255, 151, 161, 252),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "수정",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 234, 234, 236),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  updateAction(int memoId) async {
    //순서가 필요할때 무조건 async
    String memo = memoModifyController.text;
    var memoUpdate =
        MemoPad(id: memoId, memo: memo, memoinsertdate: DateTime.now());
    await handler.updateMemoPad(memoUpdate);
    Get.back();
    Get.back();
  }
} //END