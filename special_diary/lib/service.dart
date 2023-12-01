import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 236, 234, 234),
        title: const Text('서비스 이용 약관', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            SizedBox(height: 30,),
            Text('[개인정보 처리방침]', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('My Special Diary는 다이어리 서비스를 제공함에 있어 개인정보를 중요하게 생각하고 있습니다. 이에 회사는 이용자의 개인정보를 보호하고 이를 관리하기 위해 다음과 같은 처리방침을 둡니다'),
            SizedBox(height: 25,),
            Text('제1조 수집하는 개인정보의 항목', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Text('  1.1 회사는 서비스 제공을 위해 필요한 최소한의 개인정보를 수집합니다. \n        수집되는 개인정보의 항목은 다음과 같습니다.'),
            Text('     • 서비스 이용 기록 및 행동 정보'),
            Text('     • 기기 정보 (예: IP 주소, 기기 식별자)'),
            SizedBox(height: 20,),
            Text('제2조 개인정보의 수집 및 이용 목적', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Text('   2.1 회사는 다음과 같은 목적으로 개인정보를 수집하고 이용합니다.'),
            Text('      • 서비스 이용에 따른 사용자 편의 제공'),
            Text('      • 서비스의 원활한 운영과 개선'),
            SizedBox(height: 20,),
            Text('제3조 개인정보의 제3자 제공', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Text('   3.1 회사는 원칙적으로 이용자의 동의 없이 개인정보를 외부에 제공하지 \n         않습니다. 다만, 다음의 경우에는 예외로 합니다.'),
            Text('      • 이용자가 사전에 동의한 경우'),
            Text('      • 법령의 규정에 따라 제공이 필요한 경우'),
            SizedBox(height: 20,),
            Text('제4조 개인정보의 보유 및 파기', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Text('   4.1 회사는 이용자의 개인정보를 서비스 제공을 위한 기간 동안 보유하며, \n         목적이 달성된 경우 지체 없이 파기합니다.'),
            SizedBox(height: 20,),
            Text('제5조 이용자의 권리와 의무', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Text('   5.1 이용자는 언제든지 자신의 개인정보를 열람하고 수정할 수 있습니다.'),
            Text('   5.2 이용자는 개인정보의 오류에 대한 정정을 요청할 수 있습니다.'),
            Text('   5.3 이용자는 개인정보의 수집, 이용, 제공에 대한 동의 철회를 할 수 있습 \n  니다.'),
            SizedBox(height: 20,),
            Text('제6조 개인정보보호', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Text('회사는 회원의 개인정보를 본인의 동의 없이 타인에게 제공하지 않으며, \n 개인정보보호에 관한 법령에 따라 안전하게 관리합니다.'),
            SizedBox(height: 20,),
            Text('제7조 개인정보 처리방침 변경', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
            Text('   7.1 이 개인정보 처리방침은 법령, 정책 또는 보안기술의 변경에 따라 \n       변경될 수 있습니다. 변경 시 본 페이지를 통해 공지합니다.'),
            SizedBox(height: 50,),
            Text('     본 개인정보 처리방침은 2023년 12월 XX일부터 시행됩니다.'),
                    
                    SizedBox(height: 60,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}