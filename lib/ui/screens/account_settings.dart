import 'package:chat_app/core/services/auth_services/auth_repository.dart';
import 'package:chat_app/models/user_model/user_model.dart';
import 'package:chat_app/ui/widgets/reusables/shape.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_services/logout.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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

            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                CustomListTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.email_outlined,
                  title: 'Change Email',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.phone_android,
                  title: 'Phone Number',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.security,
                  title: 'Two-Step Verification',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.location_on_outlined,
                  title: 'Manage Locations',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.language,
                  title: 'Language Preference',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.download_for_offline,
                  title: 'Download Data',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Settings',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.info_outline,
                  title: 'Terms & Conditions',
                  onTap: () {},
                ),
                CustomListTile(
                  icon: Icons.settings_backup_restore,
                  title: 'Restore Defaults',
                  onTap: () {},
                ),

                const Divider(),

                CustomListTile(
                  icon: Icons.logout,
                  title: 'Log Out',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () => controller.logout(),
                ),
                CustomListTile(
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color textColor;

  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor = Colors.black54,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -4),
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
