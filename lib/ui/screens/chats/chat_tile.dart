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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            40.verticalSpace,
            //Chats screen heading
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 34,
              ),
            ),
            //Chats screen search bar
            8.verticalSpace,
            CustomSearchBox(),
            8.verticalSpace,
            //All user messages to be displayed as a list tile
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,

                scrollDirection: Axis.vertical,
                itemCount: 20,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 5);
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: ListTile(
                      contentPadding: EdgeInsets.only(right: 8, left: 0),
                      splashColor: Colors.amber,
                      minLeadingWidth: 0,
                      horizontalTitleGap: 10,
                      hoverColor: Colors.blue,
                      visualDensity: VisualDensity(
                        vertical: -4,
                        horizontal: -4,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 30,
                        child: Text('A', style: TextStyle(color: Colors.white)),
                      ),
                      title: Text('Name'),
                      subtitle: Text('Message'),
                      trailing: Column(
                        children: <Widget>[
                          Text('08:36AM'),
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: Text('10')),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
