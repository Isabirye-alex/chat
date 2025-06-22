import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:chat_app/core/services/auth_services/logout.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:chat_app/ui/widgets/reusables/shape.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _authRepo = AuthRepository();
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _authRepo.getCurrentUserDetails();
    if (mounted) {
      setState(() {
        _user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LogoutController());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shape(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  leading: const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/icon.png'),
                  ),
                  title: Text(
                    "Name: ${_user?.firstName ?? 'Loading...'} ${_user?.lastName ?? ''}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Email: ${_user?.email ?? 'Loading...'}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      // Implement edit profile functionality here
                    },
                    child: const Icon(
                      Icons.edit_note_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          _buildSettingsSection([
            _tile(Icons.person_outline, 'Account'),
            _tile(Icons.chat_bubble_outline, 'Chats'),
            _tile(Icons.notifications_none, 'Notifications'),
            _tile(Icons.lock_outline, 'Privacy'),
            _tile(Icons.storage_outlined, 'Data & Storage'),
          ]),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'More Options',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          _buildSettingsSection([
            _tile(Icons.language, 'Language'),
            _tile(Icons.palette_outlined, 'Theme'),
            _tile(Icons.group, 'Invite Friends'),
            _tile(Icons.backup_outlined, 'Chat Backup'),
            _tile(Icons.verified_user_outlined, 'Security'),
            _tile(Icons.block, 'Blocked Users'),
            _tile(Icons.feedback_outlined, 'Send Feedback'),
            _tile(Icons.star_rate_outlined, 'Rate Us'),
            _tile(Icons.bug_report_outlined, 'Report a Bug'),
          ]),

          Divider(),

          _tile(
            Icons.logout,
            'Log Out',
            iconColor: Colors.red,
            textColor: Colors.red,
            callBackAction: ()=>controller.logout(),
            
          ),
          _tile(
            Icons.delete_outline,
            'Delete My Account',
            iconColor: Colors.red,
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _tile(
    IconData icon,
    String title, {
    Color iconColor = Colors.black54,
    Color textColor = Colors.black,
    VoidCallback? callBackAction,
  }) {
    return ListTile(
      minVerticalPadding: 0,
      visualDensity: VisualDensity(vertical: -4),
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: callBackAction,
    );
  }

  Widget _buildSettingsSection(List<Widget> tiles) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: tiles,
    );
  }
}
