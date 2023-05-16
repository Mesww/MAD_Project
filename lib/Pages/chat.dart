import 'package:flutter/material.dart';
import 'package:mutu/Pages/circle.dart';
import 'package:mutu/provider/Chat.dart';
import 'package:google_fonts/google_fonts.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List chatDATA = [
    Chat_(
      name: "John Doe",
      lastMessage: "Hi there!",
      time: "12:30 PM",
      image:
          "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?cs=srgb&dl=pexels-mohamed-abdelghaffar-771742.jpg&fm=jpg",
    ),
    Chat_(
      name: "Jane Smith",
      lastMessage: "Hey, how are you?",
      time: "1:45 PM",
      image:
          "https://media.istockphoto.com/id/1400618001/photo/profile-headshot-portrait-of-a-handsome-smiling-african-american-man-with-beard-and-mustache.jpg?b=1&s=170667a&w=0&k=20&c=hvLszdWnBkWp0jC6cmyroGuxuDuHGrmJY8qK_cv5NAw=",
    ),
    Chat_(
      name: "Bob Johnson",
      lastMessage: "What's up?",
      time: "2:30 PM",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwHvEGamFasFcudDxAlTzNzd2ZsSRKsmf4Uw&usqp=CAU",
    ),
    Chat_(
      name: "Alice Williams",
      lastMessage: "I'm good. How about you?",
      time: "3:15 PM",
      image:
          "https://sb.kaleidousercontent.com/67418/3840x2200/40b6488625/individuals-org.png",
    ),
    Chat_(
      name: "Mark Davis",
      lastMessage: "Doing great. Thanks for asking!",
      time: "4:00 PM",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHDRlp-KGr_M94k_oor4Odjn2UzbAS7n1YoA&usqp=CAU",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7B8FA1),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.chat_bubble,
              color: Color(0xFFFFAD6A5),
            ),
            const SizedBox(width: 14.0),
            Text(
              'Message',
              style: TextStyle(color: const Color(0xFFFFAD6A5)),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: ListView.builder(
          itemCount: chatDATA.length,
          itemBuilder: (context, index) => _buildChatItem(context, index),
        ),
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, int index) {
    final chat = chatDATA[index];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(chat.image),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.name,
                  style: GoogleFonts.nunito(
                    color: Color(0xFFFFAD6A5),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  chat.lastMessage,
                  style: GoogleFonts.nunito(
                    color: Color(0xFFFFAD6A5),
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
