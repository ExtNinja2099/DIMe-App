import 'package:flutter/material.dart';

List<bool> toggleList = List.generate(8, (index) => false);

//Toggle functionality
//buildToggleSetting() method
//This returns a toggle widget based on the parameter variables
//The toggle should change based the boolean value and the setState() function
Widget buildToggleSetting(String title, double fontSize1, String subtitle, double fontSize2, bool value, Function(bool) onChanged) {
  return ListTile(
    title: Text(title, style: TextStyle(fontSize: fontSize1)),
    subtitle: Text(subtitle, style: TextStyle(fontSize: fontSize2)),
    trailing: Switch(
      value: value,
      onChanged: onChanged,
    ),
  );
}

//Advanced Arrow menu Toggle
//buildAdvancedSettingTile() method
//This returns a arrow widget based on the parameter variables
Widget buildAdvancedSettingTile(String title, double fontSize1, String description, double fontSize2) {
  return ListTile(
    title: Text(title, style: TextStyle(fontSize: fontSize1)),
    subtitle: Text(description, style: TextStyle(fontSize: fontSize2)),
    trailing: Icon(Icons.arrow_forward_ios),
  );
}

