import 'package:chat_app/core/services/fetch_user_contoller.dart';
import 'package:chat_app/ui/screens/chats/chats_view.dart';
import 'package:chat_app/ui/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatTile extends StatefulWidget {
  const ChatTile({super.key});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    final contoller = Get.put(FetchUserContoller());
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
                itemCount: contoller.users.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 5);
                },
                itemBuilder: (context, index) {
                  final user = contoller.users[index];
                  return GestureDetector(
                    onTap: () => Get.to(() => ChatsView(user: user)),
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
                        child: Text(
                          user.firstName![0],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text('${user.firstName!} ${user.lastName!} '),
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
