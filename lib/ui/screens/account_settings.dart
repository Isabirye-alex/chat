import 'package:flutter/material.dart';


class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
    );
  }
}
