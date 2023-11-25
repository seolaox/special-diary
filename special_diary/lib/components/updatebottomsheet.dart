import 'package:flutter/material.dart';

class UpdateBottomSheet extends StatelessWidget {
  final TextEditingController memoModifyController;
  final Function onPressed;

  // 생성자에서 memoModifyController를 받아옵니다.
  const UpdateBottomSheet({
    Key? key,
    required this.memoModifyController,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 700,
      color: Theme.of(context).colorScheme.secondaryContainer,
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
              controller: memoModifyController, // memoModifyController를 사용합니다.
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
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              onPressed();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(100, 50),
              backgroundColor: Color.fromARGB(255, 146, 148, 255),
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
    );
  }
}
