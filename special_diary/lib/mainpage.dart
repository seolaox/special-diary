import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:secret_diary/maplocalview.dart';
import 'eventupdate.dart';
import 'model/datahandler.dart';
import 'model/privacy.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    late DatabaseHandler handler;


  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializePrivacyDB();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: FutureBuilder( //앱을 키면 db와 연결되어 있는 상태, FutureBuilder는 또 리스트 만들어 쓰지 않고 메모리 만들어 저장된 값 가져가 쓰는거
        future: handler.queryPrivacy(), 
        builder: (BuildContext context, AsyncSnapshot<List<Privacy>> snapshot){
          if(snapshot.hasData){
            //snapshot통해 화면구성
            return ListView.builder(
              itemCount: snapshot.data?.length, //async타입이라 ?로 
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                      //왼쪽에서 오른쪽으로 당기는것
                      startActionPane: ActionPane(
                          motion: BehindMotion(), //
                          children: [
                            SlidableAction(
                              //버튼 눌렀을때 action
                              backgroundColor: Colors.green,
                              icon: Icons.edit,
                              label: 'Edit',
                              onPressed: (context) {
                                Get.to(EventUpdate(),
                                arguments: [
                                  snapshot.data![index].id,
                                  snapshot.data![index].title,
                                  snapshot.data![index].content,
                                  snapshot.data![index].eventdate,
                                  snapshot.data![index].image,
                                  snapshot.data![index].actiondate
                                ]
                                )!.then((value) => reloadData());
                              },
                            )
                          ]),
                      endActionPane: ActionPane(
                          motion: BehindMotion(), //
                          children: [
                            SlidableAction(
                              //버튼 눌렀을때 action
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Delete',
                              onPressed: (context)async {
                              
                                await handler
                              .deletePrivacy(snapshot.data![index].id!);
                              snapshot.data!.remove(snapshot.data![index]);
                              setState(() {
                                
                              });
                            
                          
                              },
                            ),
                          ]),


                  child: GestureDetector(
                    onLongPress: () {
                      Get.to(MapLocationView(),
                      arguments: [
                                  snapshot.data![index].id,
                                  snapshot.data![index].title,
                                  snapshot.data![index].lat,
                                  snapshot.data![index].lng,
                                ]
                                )!.then((value) => reloadData());
                              },
                    child: Card(
                      child: Container(
                        height: 100,
                        child: Row(
                          
                          children: [
                            //snapshot이 메모리에 있는데이터 불러오는거
                            Container(
                              width: 100, // 이미지의 고정된 너비
                              height: double.infinity, // 컨테이너의 높이를 꽉 채우도록 설정
                              child: Image.memory(
                                snapshot.data![index].image,
                                fit: BoxFit.cover,
                                width: 100,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text(snapshot.data![index].title, 
                                    style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                                  ],
                                ),
                                // Text(snapshot.data![index].actiondate != null
                                //         ? DateFormat('yyyy-MM-dd').format(snapshot.data![index].actiondate!)
                                //         : 'No Date'),
                                        
                              ],
                            ),
                            Text(snapshot.data![index].actiondate != null
                            ? DateFormat('yyyy-MM-dd').format(snapshot.data![index].actiondate!)
                            : 'No Date'),
                          ],

                  
                        ),
                      ),
                    ),
                  ),
                );
              },);

          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
    );
  }
  //---Function---


  reloadData(){
    handler.queryPrivacy();
    
    setState(() {});
    
    
  }

}//END