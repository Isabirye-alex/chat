import 'package:chat_app/core/services/fetch_user_contoller.dart';
import 'package:chat_app/ui/screens/chats/chats_view.dart';
import 'package:chat_app/ui/widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FetchUserController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            40.verticalSpace,
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 34,
              ),
            ),
            8.verticalSpace,
            CustomSearchBox(),
            16.verticalSpace,
            Obx(
              () => controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : controller.error.value.isNotEmpty
                  ? Center(
                      child: Text(
                        'Error: ${controller.error.value}',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : controller.users.isEmpty
                  ? Center(child: Text('No users found'))
                  : Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: controller.users.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 5),
                        itemBuilder: (context, index) {
                          final user = controller.users[index];
                          return GestureDetector(
                            onTap: () => Get.to(() => ChatsView(user: user)),
                            child: ListTile(
                              contentPadding: EdgeInsets.only(
                                right: 8,
                                left: 8,
                              ),
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
                                  user.firstName?[0].toUpperCase() ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                '${user.firstName ?? ''} ${user.lastName ?? ''}',
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              subtitle: Text('Message'),
                              trailing: Column(
                                children: [
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
            ),
          ],
        ),
      ),
    );
  }
}
