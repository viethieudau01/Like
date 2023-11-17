import 'package:example/random_words.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';


class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text('Common'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.email),
                  title: Text('Email'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: false,
                  leading: Icon(Icons.dark_mode),
                  title: Text('Dark Mode'),
                ),
                SettingsTile.navigation(
                  leading: Icon(Icons.phone),
                  title: Text('Phone Number'),
                ),
                SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  value: Text('English'),
                ),
                SettingsTile.navigation(
                  leading: Icon(Icons.privacy_tip),
                  title: Text('Privacy'),
                ),SettingsTile.navigation(
                  leading: Icon(Icons.alarm),
                  title: Text('Alam'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: true,
                  leading: Icon(Icons.format_paint),
                  title: Text('Enable custom theme'),
                ),
              ],
            ),
          ],
        ),
    );}

}

