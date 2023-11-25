import 'package:flutter/material.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
    late List data;
    late ScrollController scrollController;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = [];
    scrollController = ScrollController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //첫 화면은 빈화면이고 floatbutton 눌러야 보이게 하는 것이므로 삼항연산자 사용
        child: data.isEmpty
            ? Text('데이터가 없습니다.')
            : ListView.builder(
                controller: scrollController,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Row(  
                        children: [
                          
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),),
    );
  }
}