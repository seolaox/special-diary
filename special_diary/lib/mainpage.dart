// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:secret_diary/eventdetail.dart';
import 'eventupdate.dart';
import 'model/datehandler.dart';
import 'model/sdiary.dart';

class MainPage extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;
  const MainPage({super.key, required this.onChangeTheme});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DatabaseHandler handler; //데이터베이스 핸들러(DatabaseHandler)를 초기화
  String searchText = ''; //검색어를 저장하는 변수를 정의

  _changeThemeMode(ThemeMode themeMode) {
    //SettingPage에서도 themeMode사용하도록 widget설정
    widget.onChangeTheme(themeMode);
  }

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeSdiaryDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
              hintText: '검색어를 입력해 주세요.', suffixIcon: Icon(Icons.search)),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
      ),
      body: FutureBuilder(
          //앱을 키면 db와 연결되어 있는 상태,
          //FutureBuilder는 또 리스트 만들어 쓰지 않고 메모리 만들어 저장된 값 가져가 쓰는거(비동기적으로 데이터 가져옴)
          future: handler.querySdiary(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Sdiary>> snapshot) {
            if (snapshot.hasData) {
              //snapshot통해 화면구성
              snapshot.data!.sort((a, b) {
                //eventdate(사용자가 선택한 날짜)를 기준으로 내림차순으로 정렬
                //a와 b의 eventdate 속성을 나타냄
                final aDate = DateTime.tryParse(a.eventdate ?? '');
                final bDate = DateTime.tryParse(b.eventdate ?? '');
                if (aDate != null && bDate != null) {
                  //두 날짜가 모두 존재하는 경우에만 정렬을 수행. 날짜가 하나라도 없다면, 정렬을 하지 않고 0을 반환
                  return bDate
                      .compareTo(aDate); //bDate와 aDate를 비교하여 결과에 따라 정렬 순서를 결정
                } else {
                  return 0; //compareTo는 비교 결과에 따라 정렬을 위한 값을 반환. 결과가 음수이면 b가 a보다 앞에 위치하게 되어 내림차순으로 정렬
                }
              });
              return (snapshot.data?.isEmpty ?? true) //데이터가 없을 경우 보여주는 문구
                  ? const Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('하단에 '),
                            Icon(Icons.event_note),
                            Text('아이콘을 클릭하여'),
                          ],
                        ),
                        Text('일정을 만들어 주세요.'),
                      ],
                    ))
                  : ListView.builder(
                      itemCount: snapshot.data?.length, //async타입이라 ?로
                      itemBuilder: (BuildContext context, int index) {
                        if (searchText
                                .isNotEmpty && ////searchText가 비어 있지 않고, 현재 아이템의 내용이 검색어를 포함하지 않으면
                            !snapshot.data![index].content
                                .toLowerCase() //문자열을 모두 소문자로 변환
                                .contains(searchText.toLowerCase())) {
                          return const SizedBox
                              .shrink(); //izedBox.shrink()를 반환하여 해당 아이템을 숨깁
                        }
                        return Slidable(
                          //왼쪽에서 오른쪽으로 당기는것
                          startActionPane: ActionPane(
                              motion: const BehindMotion(), //
                              children: [
                                SlidableAction(
                                  //버튼 눌렀을때 action
                                  backgroundColor:
                                      const Color.fromARGB(255, 190, 201, 244),
                                  icon: Icons.edit,
                                  label: 'Edit',
                                  onPressed: (context) {
                                    Get.to(
                                            () => EventUpdate(
                                                onChangeTheme:
                                                    _changeThemeMode),
                                            arguments: [
                                          snapshot.data![index].id,
                                          snapshot.data![index].title,
                                          snapshot.data![index].content,
                                          snapshot.data![index].weathericon,
                                          snapshot.data![index].image,
                                          snapshot.data![index].actiondate,
                                          snapshot.data![index].eventdate
                                        ])!
                                        .then((value) => reloadData());
                                  },
                                )
                              ]),
                          endActionPane: ActionPane(
                              motion: const BehindMotion(), //
                              children: [
                                SlidableAction(
                                  //버튼 눌렀을때 action
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 158, 151),
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  onPressed: (context) async {
                                    Get.bottomSheet(Container(
                                      width: 500,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(30.0)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                await handler.deleteSdiary(
                                                    snapshot.data![index].id!);
                                                    snapshot.data!.remove(
                                                    snapshot.data![index]);
                                                Get.back();
                                                setState(() {});
                                                Get.back();
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size(400, 60),
                                                backgroundColor: const Color.fromARGB(
                                                    255, 255, 188, 183),
                                              ),
                                              child: const Text(
                                                'DELETE',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(400, 60),
                                                  // backgroundColor: Color.fromARGB(255, 146, 148, 255),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .surface),
                                              child: const Text(
                                                'CANCEL',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)
                                              )),
                                        ],
                                      ),
                                    ));
                                  },
                                ),
                              ]),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                      () => EventDetail(
                                          onChangeTheme: _changeThemeMode),
                                      arguments: [
                                    snapshot.data![index].id,
                                    snapshot.data![index].title,
                                    snapshot.data![index].content,
                                    snapshot.data![index].weathericon,
                                    snapshot.data![index].image,
                                    snapshot.data![index].actiondate,
                                    snapshot.data![index].eventdate
                                  ])!
                                  .then((value) => reloadData());
                            },
                            child: Card(
                              child: SizedBox(
                                height: 350,
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 420, // 이미지의 고정된 너비
                                        height: 225, // 컨테이너의 높이를 꽉 채우도록 설정
                                        child: Image.memory( //메모리에 있는 이미지 데이터를 표시
                                          snapshot.data![index].image, 
                                          fit: BoxFit.cover,
                                          // width: 100,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            270, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              snapshot.data![index].eventdate ??
                                                  'No Date',
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              iconSize: 22,
                                              icon: getIconWidget(snapshot
                                                      .data![index]
                                                      .weathericon ??
                                                  ''),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        snapshot.data![index].title,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        maxLines:
                                            1, // 한 줄을 초과하면 말줄임표(ellipsis)를 표시
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        snapshot.data![index].content,
                                        style: const TextStyle(fontSize: 17),
                                        maxLines:
                                            1, // 한 줄을 초과하면 말줄임표(ellipsis)를 표시
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  //---Function---

  reloadData() {
    handler.querySdiary();
    setState(() {});
  }

// 문자열 iconString을 입력으로 받아 해당하는 아이콘을 생성하는 Flutter 위젯을 반환
    getIconWidget(String iconString) {
    switch (iconString.toLowerCase()) {
      case 'sunny':
        return Icon(
          Icons.sunny,
          color: Colors.amber[400],
        );
      case 'waterdrop':
        return Icon(Icons.water_drop, color: Colors.blue[300]);
      case 'cloud':
        return Icon(
          Icons.cloud,
          color: Colors.grey[400],
        );
      case 'air':
        return Icon(
          Icons.air,
          color: Colors.blueGrey[200],
        );
      case 'acunit':
        return Icon(
          Icons.ac_unit,
          color: Colors.blue[100],
        );
      default:
        return const Icon(Icons.error);
    }
  }
}
