import 'package:chat_app/core/services/fetch_user_contoller.dart';
import 'package:chat_app/models/message_model/message_model.dart';
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
  late MessageModel message;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FetchUserController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.grey,
        title: Text(
          'Chats',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 34,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSearchBox(),
            16.verticalSpace,
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.error.value.isNotEmpty) {
                return Center(
                  child: Text(
                    'Error: ${controller.error.value}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              final usersToDisplay = controller.filteredUsers.isNotEmpty
                  ? controller.filteredUsers
                  : controller.users;

              if (usersToDisplay.isEmpty) {
                return const Center(child: Text('No users found'));
              }

              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: usersToDisplay.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  itemBuilder: (context, index) {
                    final user = usersToDisplay[index];
                    return Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: GestureDetector(
                        onTap: () => Get.to(
                          () => ChatsView(
                            user: user,
                            // current tapped user
                            receiver: user,
                            // tapped user is the receiver
                            sender: controller
                                .currentUser
                                .value!, // your app's current logged-in user
                          ),
                        ),

                        child: ListTile(
                          contentPadding: const EdgeInsets.only(
                            right: 8,
                            left: 8,
                          ),
                          splashColor: Colors.amber,
                          minLeadingWidth: 0,
                          horizontalTitleGap: 10,
                          hoverColor: Colors.blue,
                          visualDensity: const VisualDensity(
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
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Text(
                            message.lastMessage ?? '',
                            style: TextStyle(color: Colors.green),
                          ),
                          trailing: Column(
                            children: [
                              Text('08:50 AM'),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(child: Text('10')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
