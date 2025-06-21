import 'package:chat_app/ui/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTile extends StatefulWidget {
  const ChatTile({super.key});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
      child: Column(
        children: [
          30.verticalSpace,
          //Chats screen heading
          Text('Chats', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 34),),
          //Chats screen search bar
          CustomSearchBox(),
          //All user messages to be displayed as a list tile
          ListView.separated(
            itemCount: 20,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(backgroundColor: Colors.green, radius: 30),
                title: Text('Name'),
                subtitle: Text('Message'),
                trailing: Column(
                  children: <Widget>[
                    Text('08: 36'),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('10'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
