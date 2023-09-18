import 'package:flutter/material.dart';
import 'toggle.dart';

//Settings page widget class
class SettingsPage extends StatefulWidget {
  //Allowing Settings screen to change state with a new key
  const SettingsPage({super.key});
  //CreateState() function to make buttons function to change state
  @override
  State<SettingsPage> createState() => SettingsPageState();
}

//Main Settings page class
class SettingsPageState extends State<SettingsPage> {
  //Boolean List for each Settings toggle
  List<bool> settingsList = toggleList;

  //Build() method that builds the Settings page
  @override
  Widget build(BuildContext context) {
    //Gets the screen width and height
    double screenHeight = MediaQuery.of(context).size.height;
    //Card width and height
    double fontHeight = screenHeight * 0.47;    //Height: 335

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            //Settings menu text and toggles
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Security Settings section
              SizedBox(height: 20),
              Card(
                elevation: 6,   //Card shadow effect with elevation value
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Security',
                          style: TextStyle(fontSize: fontHeight * 0.0597,
                              fontWeight: FontWeight.bold),   //Size: 20
                        ),
                      ),
                      SizedBox(height: fontHeight * 0.0299),    //Size: 10
                      //Security Settings section settings and toggles
                      buildToggleSetting(
                        'Location Share',
                        fontHeight * 0.048,     //Size: 16
                        'Allow location data to be added with ID for verification',
                        fontHeight * 0.042,     //Size: 14
                        settingsList[0],
                            (value) {
                          setState(() {
                            settingsList[0] = value;
                          });
                        },
                      ),
                      buildToggleSetting(
                        'Sync Cloud Data',
                        fontHeight * 0.048,     //Size: 16
                        'Sync your data with your cloud account',
                        fontHeight * 0.042,     //Size: 14
                        settingsList[1],
                            (value) {
                          setState(() {
                            settingsList[1] = value;
                          });
                        },
                      ),
                      buildToggleSetting(
                        'Two-Step Verification',
                        fontHeight * 0.048,     //Size: 16
                        'Add another layer of security to your account to secure your DIs',
                        fontHeight * 0.042,     //Size: 14
                        settingsList[2],
                            (value) {
                          setState(() {
                            settingsList[2] = value;
                          });
                        },
                      ),
                      buildToggleSetting(
                        'Send Read Receipts',
                        fontHeight * 0.048,     //Size: 16
                        'Let service providers have a record of your Digital ID certification',
                        fontHeight * 0.042,     //Size: 14
                        settingsList[3],
                            (value) {
                          setState(() {
                            settingsList[3] = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              //Optional Settings section
              SizedBox(height: 20),
              Card(
                elevation: 6,   //Card shadow effect with elevation value
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Optional',
                          style: TextStyle(fontSize: fontHeight * 0.0597,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: fontHeight * 0.0299),    //Size: 10
                      //Optional section settings and toggles
                      buildToggleSetting(
                        'Notifications',
                        fontHeight * 0.048,     //Size: 16
                        'Enable notifications for updates and recommendations',
                        fontHeight * 0.042,     //Size: 14
                        settingsList[4],
                            (value) {
                          setState(() {
                            settingsList[4] = value;
                          });
                        },
                      ),
                      buildToggleSetting(
                        'Automatic App Updates',
                        fontHeight * 0.048,     //Size: 16
                        'Allow system updates to be installed for performance and bug fixes',
                        fontHeight * 0.042,     //Size: 14
                        settingsList[5],
                            (value) {
                          setState(() {
                            settingsList[5] = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              //Advanced Settings section
              SizedBox(height: 20),
              Card(
                elevation: 6,   //Card shadow effect with elevation value
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Advanced',
                          style: TextStyle(fontSize: fontHeight * 0.0597,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: fontHeight * 0.0299),    //Size: 10
                      //Advanced Settings section settings and toggles
                      buildToggleSetting(
                        'Turn on App lock',
                        fontHeight * 0.048,     //Size: 16
                        'Secure app with a lock when opening the app',
                        fontHeight * 0.042,     //Size: 14
                        settingsList[6],
                            (value) {
                          setState(() {
                            settingsList[6] = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              //Help & Support section
              SizedBox(height: 20),
              Card(
                elevation: 6,   //Card shadow effect with elevation value
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Help & Support',
                          style: TextStyle(fontSize: fontHeight * 0.0597,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: fontHeight * 0.0299),    //Size: 10
                      //Help & Support section settings and toggles
                      buildToggleSetting(
                        'Send System Logs',
                        fontHeight * 0.048,     //Size: 16
                        'Allow error logs to be sent for better performance and stability',
                        fontHeight * 0.042,     //Size: 14
                        settingsList[7],
                            (value) {
                          setState(() {
                            settingsList[7] = value;
                          });
                        },
                      ),
                      buildAdvancedSettingTile(
                        'Contact Support',
                        fontHeight * 0.048,     //Size: 16
                        'If you have any concerns, please reach out to our support team immediately',
                        fontHeight * 0.042,     //Size: 14
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 50,
                child: Center(
                  child: Text(
                    '© 2023 DIMe',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}