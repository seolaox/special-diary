// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:get/get.dart';
// import 'package:secret_diary/eventupdate.dart';
// import 'package:secret_diary/model/datahandler.dart';
// import 'package:intl/intl.dart';
// import 'model/privacy.dart';

// class MemoPage extends StatefulWidget {
//   const MemoPage({super.key});

//   @override
//   State<MemoPage> createState() => _MemoPageState();
// }

// class _MemoPageState extends State<MemoPage> {
//   late ScrollController scrollController;
//   late DatabaseHandler handler;
//   String searchText = '';

//   @override
//   void initState() {
//     super.initState();
//     scrollController = ScrollController();
//     handler = DatabaseHandler();
//     handler.initializeDB();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Expanded(
//           child: Column(
//             children: [
//               TextField(
//                 decoration: InputDecoration(
//                     hintText: '검색어를 입력해주세요.', suffixIcon: Icon(Icons.search)),
//                 onChanged: (value) {
//                   setState(() {
//                     searchText = value;
//                   });
//                 },
//               ),
//               FutureBuilder(
//                   //앱을 키면 db와 연결되어 있는 상태, FutureBuilder는 또 리스트 만들어 쓰지 않고 메모리 만들어 저장된 값 가져가 쓰는거
//                   future: handler.queryPrivacy(),
//                   builder: (BuildContext context,
//                       AsyncSnapshot<List<Privacy>> snapshot) {
//                     if (snapshot.hasData) {
//                       //snapshot통해 화면구성
//                       return ListView.builder(
//                           itemCount: snapshot.data?.length, //async타입이라 ?로
//                           itemBuilder: (BuildContext context, int index) {
//                             if (searchText.isNotEmpty &&
//                                 !snapshot.data![index].memo
//                                     .toLowerCase()
//                                     .contains(searchText.toLowerCase())) {
//                               return SizedBox.shrink();
//                             }
//                             // 검색어가 없을 경우, 모든 항목 표시
//                             else {
//                               return Slidable(
//                                 //왼쪽에서 오른쪽으로 당기는것
//                                 startActionPane: ActionPane(
//                                     motion: BehindMotion(), //
//                                     children: [
//                                       SlidableAction(
//                                         //버튼 눌렀을때 action
//                                         backgroundColor: Colors.green,
//                                         icon: Icons.edit,
//                                         label: 'Edit',
//                                         onPressed: (context) {
//                                           Get.to(EventUpdate(), arguments: [
//                                             snapshot.data![index].id,
//                                             snapshot.data![index].memo,
//                                             snapshot.data![index].memoinsertdate
//                                           ])!
//                                               .then((value) => reloadData());
//                                         },
//                                       )
//                                     ]),
//                                 endActionPane: ActionPane(
//                                     motion: BehindMotion(), //
//                                     children: [
//                                       SlidableAction(
//                                         //버튼 눌렀을때 action
//                                         backgroundColor: Colors.red,
//                                         icon: Icons.delete,
//                                         label: 'Delete',
//                                         onPressed: (context) async {
//                                           await handler.deletePrivacy(
//                                               snapshot.data![index].id!);
//                                           snapshot.data!
//                                               .remove(snapshot.data![index]);
//                                           setState(() {});
//                                         },
//                                       ),
//                                     ]),
//                                 child: Card(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.elliptical(20, 20))),
//                                   child: Row(
//                                     children: [
//                                       Text(
//                                         snapshot.data![index].title,
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Text(snapshot.data![index].actiondate != null
//                                           ? DateFormat('yyyy-MM-dd').format(
//                                               snapshot.data![index].actiondate!)
//                                           : 'No Date'),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }
//                             ;
//                           });
//                     } else {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//                   }),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.add),
//       ),
//     );
//   }
//   //---Function---

//   reloadData() {
//     handler.queryPrivacy();
//     setState(() {});
//   }
// } //END
