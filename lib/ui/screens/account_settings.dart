import 'package:chat_app/ui/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        // padding: EdgeInsets.symmetric(horizontal: 1.sw * 0.05, vertical: 10.h),
        child: Column(
          children: [
            30.verticalSpace,
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
            CustomSearchBox(),
            //All user messages to be displayed as a list tile
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: 20,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    // minTileHeight: 20,
                    visualDensity: VisualDensity(vertical: -4),
                    leading: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 50,
                      child: Text('A', style: TextStyle(color: Colors.white),),
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
