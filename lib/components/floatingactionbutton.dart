import 'package:flutter/material.dart';
import 'package:datastructure/pages/chatbotpage.dart';

class MyActionButton extends StatelessWidget {
  const MyActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Color(0xFF0C8159),
        child: Center(
          child: Image(
              width: 30,
              height: 30,
              image:
              NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/4712/4712109.png'
              )
          ),
        ),
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ChatBotPage(),
            ),
          );
        },
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),)
    );
  }
}
