import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'home.dart';
import 'scan.dart';
import 'activity.dart';
import 'settings.dart';
import 'account.dart';

//main() method to start App UI
void main() {
  runApp(DIApp());
}

//Main DI App class
class DIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,              //Set to false to remove debug line
      title: 'DI Me',                                 //Main App title
      theme: ThemeData(
        primarySwatch: Colors.blue,                   //Colour of App bar
        scaffoldBackgroundColor: Colors.grey[100],    //Background
      ),
      home: Interface(),                              //Main start screen is basic interface of appBar and Navigation bar
    );
  }
}

//Interface widget class
class Interface extends StatefulWidget {
  //CreateState() function to make buttons function to change state
  @override
  InterfaceState createState() => InterfaceState();
}

//Interface state class
class InterfaceState extends State<Interface> {
  //Initial variables for the top appBar
  int currentIndex = 1;                               //Start page when opening the DI App
  String appBarTitle = 'My DI Cards';                 //Initialize with the start page title
  IconData appBarIcon = Icons.home_outlined;          //Initialize with the start page icon

  //Boolean variables to detect whether a icon was pressed and to make UI changes
  bool isVisible = true;                              //If the main icon is visible or not
  bool isSettingsPressed = false;                     //If the Settings icon was pressed
  bool isAccountPressed = false;                      //If the Account icon was pressed
  bool isNavPressed = true;                           //If BottomNavigationBar button was pressed
  final PageController pageControl = PageController(initialPage: 1);    //PageController variable to load each page/screen in pages[] list

  //List of widget pages/screens to load and to record each app page/screen
  final List<Widget> pages = [
    Dashboard(),
    HomePage(),
    ScanPage(),
    ActivityPage(),
    SettingsPage(),
    AccountPage(),
  ];

  //Build() method that builds the main interface UI
  //This is the top AppBar and bottomNavigationBar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(                                 //Top bar
        backgroundColor: Colors.white,                //AppBar colour
        elevation: 6,                                 //Added a shadow effect with elevation value
        //Left IconButton() in AppBar which is for Settings page
        leading: IconButton(
          icon: Icon(Icons.settings_outlined, size: 24, color: isSettingsPressed ? Colors.blue : Colors.black),    //Icon changes colour if selected
          //Settings page button functionality
          onPressed: () {
            //Settings icon button function
            setState(() {
              appBarTitle = 'Settings';               //New AppBar title
              isVisible = false;                      //Removes middle icon for Settings page
              isAccountPressed = false;               //The Account icon button wasn't pressed
              isNavPressed = false;                   //A navigation button wasn't pressed
              isSettingsPressed = true;               //Sets the Settings icon as blue colour as it was pressed
              pageControl.animateToPage(4, duration: Duration(milliseconds: 300), curve: Curves.easeOut);    //PageControl moves to selected page in pages[]
            });
          },
        ),
        //Centre icon and page title
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(                               //Makes middle icon for chosen page visible
              visible: isVisible,
              child: Icon(appBarIcon, size: 24,       //Sets middle icon for chosen page
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 8),
            Text(appBarTitle,                         //New AppBar title
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          //Right IconButton() in AppBar which is for User Account page
          IconButton(
            icon: Icon(Icons.account_circle_outlined, size: 24, color: isAccountPressed ? Colors.blue : Colors.black),   //Icon changes colour if selected
            //Account page button functionality
            onPressed: () {
              //Account icon button function
              setState(() {
                appBarTitle = 'My Account';             //New AppBar title
                isVisible = false;                      //Removes middle icon for Settings page
                isSettingsPressed = false;              //The Settings icon button wasn't pressed
                isNavPressed = false;                   //A navigation button wasn't pressed
                isAccountPressed = true;                //Sets the Account icon as blue colour as it was pressed
                pageControl.animateToPage(5, duration: Duration(milliseconds: 300), curve: Curves.ease);   //PageControl moves to selected page in pages[]
              });
            },
          ),
        ],
      ),
      //Loading the main page onto the main interface UI
      body: PageView (
        controller: pageControl,                        //PageController variable to load each page
        physics: NeverScrollableScrollPhysics(),        //Disables default horizontal swiping
        children: pages,                                //List of widget pages/screens to load in PageView()
      ),
      //bottomNavigationBar for each screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,            //Makes the navigation buttons have fixed position
        selectedItemColor: isNavPressed ? Colors.blue : Colors.black,   //Selected navigation button icon change colour
        selectedLabelStyle: TextStyle(color: isNavPressed ? Colors.blue : Colors.black, fontSize: 14),    //Selected navigation button text change colour if selected
        unselectedItemColor: Colors.black,              //Unselected navigation button icon is set to black
        unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 14),   //Unselected navigation button icon is set to black
        currentIndex: currentIndex,
        //bottomNavigationBar button UI design
        items: [                                    //Loading Navigation bar icons and text
          //Privacy Dashboard Button and text
          BottomNavigationBarItem(
            icon: Icon(Icons.shield_outlined, size: 24),
            label: 'Privacy',
          ),
          //Home Button and text
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 24),
            label: 'Home',
          ),
          //Scan ID Button and text
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded, size: 24),
            label: 'Scan',
          ),
          //User Activity Button and text
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined, size: 24),
            label: 'Activity',
          ),
        ],
        //bottomNavigationBar button functionality
        onTap: (index){
          setState(() {
            currentIndex = index;                       //current page index set to chosen page index
            isSettingsPressed = false;                  //Settings icon wasn't pressed
            isAccountPressed = false;                   //Account icon wasn't pressed
            switch (index) {
            //Privacy Dashboard page button function
              case 0:
                appBarTitle = 'My Privacy';             //New AppBar title
                isVisible = true;                       //Adds middle icon
                appBarIcon = Icons.shield_outlined;     //Middle icon design
                isNavPressed = true;                    //A navigation button was pressed
                pageControl.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.ease);   //PageControl moves to selected page in pages[]
                break;
            //Home page button function
              case 1:
                appBarTitle = 'My DI Cards';            //New AppBar title
                isVisible = true;                       //Adds middle icon
                appBarIcon = Icons.home_outlined;       //Middle icon design
                isNavPressed = true;                    //A navigation button was pressed
                pageControl.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.ease);   //PageControl moves to selected page in pages[]
                break;
            //Scan ID page button function
              case 2:
                appBarTitle = 'My ID';                  //New AppBar title
                isVisible = true;                       //Adds middle icon
                appBarIcon = Icons.person_outline_rounded;    //Middle icon design
                isNavPressed = true;                    //A navigation button was pressed
                pageControl.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.ease);   //PageControl moves to selected page in pages[]
                break;
            //Activity page button function
              case 3:
                appBarTitle = 'Activity';               //New AppBar title
                isVisible = true;                       //Adds middle icon
                appBarIcon = Icons.notifications_outlined;    //Middle icon design
                isNavPressed = true;                    //A navigation button was pressed
                pageControl.animateToPage(3, duration: Duration(milliseconds: 300), curve: Curves.ease);   //PageControl moves to selected page in pages[]
                break;
            }
          });
        },
      ),
    );
  }
}