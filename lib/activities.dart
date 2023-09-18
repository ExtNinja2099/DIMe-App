import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'identities.dart';

//Activity class
//This holds all the variables to store information for each activity stored for the app
class Activity {
  final String name;          //Activity name
  final String type;          //Type of Activity
  final int timestamp;        //Timestamp of Activity
  final Color colour;         //Assigned colour to Activity
  final String requestname;   //Request Activity name
  int count;                  //Activity Occurrence
  final String shareStat;     //Status of ID share partially or fully
  final List<int> partial;    //List for Sharing partial ID info count
  final List<int> full;       //List for Sharing all ID info count
  final List<Identity> IDs;   //List for Identity used for Activity
  //Strings for Activity content and description texts
  final String content1;      //String to inform user of verification process
  final String concern;       //String to inform user if ID wasn't scanned by the user
  //String for request Activity type
  final String requestStr1 = "\nPlease review the access request and decide whether to approve or deny the access to your data";
  //String for ID Activity Type
  final String reminder = "\nPlease make sure to renew your ID before it expires to continue enjoying uninterrupted access to our services.";
  //End String for all Activity description texts
  final String endquote = "\nThank you for trusting DIMe. \n\nBest regards, \nThe DIMe Team";

  Activity({required this.name, required this.type, required this.timestamp, required this.colour, required this.requestname, required this.count, required this.shareStat, required this.partial, required this.full, required this.IDs})
      : content1 = "\nWe want to inform you that your digital identity has been scanned. This is a standard procedure for age verification purposes",
        concern = "\nIf you did not visit $name recently or have any concerns, please reach out to our support team immediately."
  ;
}

//Activity Types List
//Holds the types of Activities in the app
List<String> ActivityTypes = [
  "Location",
  "ID",
  "Request"
];

//Activity data List
//Holds initial data of user's activity
List<Activity> activityList = [
  Activity(name:"Birmingham International Airport", type: ActivityTypes[0], timestamp: DateTime.now().subtract(Duration(days: 14)).millisecondsSinceEpoch, colour: randomColour(), requestname: "", count: 2, shareStat: shareTypes[0], partial: [2], full: [0], IDs: [identityData[0]]),
  Activity(name:"Sugarhouse", type: ActivityTypes[0], timestamp: DateTime.now().subtract(Duration(days: 7)).millisecondsSinceEpoch, colour: randomColour(), requestname: "", count: 8, shareStat: shareTypes[1], partial: [6], full: [2], IDs: [identityData[0]]),
  Activity(name:"Identity Card", type: ActivityTypes[1], timestamp: DateTime.now().subtract(Duration(days: 5)).millisecondsSinceEpoch, colour: randomColour(), requestname: "", count: 0, shareStat: "", partial: [0], full: [0], IDs: [identityData[0]]),
  Activity(name:"Smoking Goose", type: ActivityTypes[0], timestamp: DateTime.now().subtract(Duration(days: 1)).millisecondsSinceEpoch, colour: randomColour(), requestname: "", count: 5, shareStat: shareTypes[1], partial: [4], full: [1], IDs: [identityData[0]]),
  Activity(name: "Access Request", type: ActivityTypes[2], timestamp: DateTime.now().subtract(Duration(hours: 1)).millisecondsSinceEpoch, colour: Colors.red, requestname: "Smoking Goose", count: 0, shareStat: "", partial: [0], full: [0], IDs: [identityData[0]]),
];
List<Activity> activityData = activityList.reversed.toList();

//getTimeAgo() method
//This returns a String variable based on the timestamp of a activity
//The string is how recent the specific activity occurred
String getTimeAgo(int timestamp) {
  // Calculate the time difference between the current date and the timestamp
  final now = DateTime.now();
  final difference = now.millisecondsSinceEpoch - timestamp;

  if (difference < Duration.millisecondsPerMinute) {
    return 'Just now';
  }
  else if (difference < Duration.millisecondsPerHour) {
    final minutes = difference ~/ Duration.millisecondsPerMinute;
    return '$minutes min${minutes == 1 ? '' : 's'} ago';
  }
  else if (difference < Duration.millisecondsPerDay) {
    final hours = difference ~/ Duration.millisecondsPerHour;
    return '$hours hour${hours == 1 ? '' : 's'} ago';
  }
  else if (difference < 2 * Duration.millisecondsPerDay) {
    return 'Yesterday';
  }
  else {
    final days = difference ~/ Duration.millisecondsPerDay;
    return '$days days ago';
  }
}

//getDate() method
//This returns a String variable based on the timestamp of a activity
//The string is the date of when the specific activity occurred
String getDate(int timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
  String formattedDate = DateFormat('dd MMMM yyyy').format(dateTime);
  return formattedDate;
}

//getTypeIcon() method
//This returns the associated IconData variable based on the activity type variable
IconData getTypeIcon(Activity activity){
  IconData icon;
  if (activity.type == ActivityTypes[1]) {
    icon = Icons.privacy_tip_outlined;
  }
  else if (activity.type == ActivityTypes[2]) {
    icon = Icons.warning_outlined;
  }
  else {
    icon = Icons.location_on_outlined;
  }
  return icon;
}

//activitiesStatus() method
//Returns a Row() that contains a text about the status of the activities List
//This text will be displayed in the pages where activities is displayed
Padding activitiesStatus(double iconSize, double fontSize, String status){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row (
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Icon(Icons.error_outline_outlined, size: iconSize),
           SizedBox(width: 8),
           Text(
             status.split(' ').take(3).join(' '),
             style: TextStyle(fontSize: fontSize),
             textAlign: TextAlign.center,
           ),
         ]
        ),
        if (status.split(' ').length > 3)
          Text(
            status.split(' ').skip(3).join(' '),
            style: TextStyle(fontSize: fontSize),
            textAlign: TextAlign.center,
          ),
      ]
    ),
  );
}

//deleteIdentity() method
//This deletes the chosen item from a Identity List based on the index location in the current state
void deleteIdentity(Function setStateCallback, BuildContext context, List<Identity> list, int index){
  //Sets current state of the list
  setStateCallback(() {
    //Removes activity from the activityData list based on identity
    activityData.removeWhere((activity) => activity.IDs.remove(list[index]));
    //Removes specific Identity from List
    list.removeAt(index);
    //Pops out of context menu
    Navigator.pop(context);
  });
}

//deleteActivity() method
//This deletes the chosen item from a Activity List based on the index location in the current state
void deleteActivity(Function setStateCallback, BuildContext context, List<Activity> list, int index){
  //Sets current state of the list
  setStateCallback(() {
    if (list[index].type == ActivityTypes[0]){
      for (Identity identity in identityData){
        if (list[index].IDs.contains(identity)){
          int idIndex = list[index].IDs.indexOf(identity);
          identity.usage -= list[index].count;
          identity.partial -= list[index].partial[idIndex];
          identity.full -= list[index].full[idIndex];
        }
      }
    }
    //Removes specific Activity from List
    list.removeAt(index);
    //Pops out of context menu
    Navigator.pop(context);
  });
}

//splitActivityName() method
//This splits the name string into separate lines based on the maximum length for the text
//Ensures that long Activity names can be displayed evenly
String splitActivityName(String name, int maxLength) {
  //Checks length of the name String
  if (name.length <= maxLength) {
    //Returns name as is due to being less or equal to maximum length
    return name;
  }
  //Splits name String due to length being longer
  else {
    //Splits name String
    int middleIndex = name.lastIndexOf(' ', maxLength);
    //If there's no space found within the first 23 characters, return the whole name
    if (middleIndex == -1) {
      return name;
    }
    //Return the split string with a new line with the other word
    else {
      return name.substring(0, middleIndex) + '\n' + name.substring(middleIndex + 1);
    }
  }
}

//rowText() method
//Returns a Expanded Container() that uses a scroll view of activity description
Expanded rowText(double width, String text, double fontSize, Color colour){
  return Expanded(
    child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        width: width,
        child: Text(text, style: TextStyle(fontSize: fontSize, color: colour)),
      ),
    ),
  );
}

//showActCardMenu() method
//Shows a alertDialog Container() when an activity is pressed
//More information about the specific user activity in the activities list
//Displays action buttons based on activity type
void showActCardMenu(double width, double height, Function setStateCallback, BuildContext context, Activity activity, int index){
  double fontHeight = height * 0.47;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
          width: width,             //Width of Container()  Size: 300
          height: height * 0.65,    //Height of Container() Size: 370
          child: Column(
            children: [
              //Back button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.blue),
                  //IconButton() functionality
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: 10),
              //Activity icon
              if (activity.type == "Request")
                Icon(getTypeIcon(activity), size: fontHeight * 0.299, color: activity.colour)    //Size: 100
              else
                Icon(getTypeIcon(activity), size: fontHeight * 0.299, color: activity.IDs[0].colour),    //Size: 100
              //Activity name
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(activity.name,  style: TextStyle(color: Colors.black,
                      fontSize: fontHeight * 0.0597), textAlign: TextAlign.center
                  ),    //Size: 20
                ]
              ),
              SizedBox(height: fontHeight * 0.024),   //Size: 8
              //Activity date
              Text(
                getDate(activity.timestamp),
                style: TextStyle(fontSize: fontHeight * 0.042, color: Colors.grey),    //Size: 14
              ),
              SizedBox(height: fontHeight * 0.024),   //Size: 8
              //Activity share status
              if (activity.shareStat.isNotEmpty)
                Text(
                  "Share Status: " + activity.shareStat,
                  style: TextStyle(fontSize: fontHeight * 0.042, color: Colors.grey),    //Size: 14
                ),
              //Displays text for each row based on Activity type
              if (activity.type == ActivityTypes[2])
                rowText(width, activity.requestname + " is requesting access to your " + activity.IDs.first.type + "\n" + activity.requestStr1 + "\n" + activity.endquote,
                    fontHeight * 0.042, Colors.black)   //Size: 16
              else if (activity.type == ActivityTypes[1])
                rowText(width, "Your " + activity.IDs.first.type + " is expiring soon!" + "\n" + activity.reminder + "\n" + activity.endquote,
                    fontHeight * 0.042, Colors.black)   //Size: 16
              else
                rowText(width, "Scanned your " + activity.IDs.first.type + " at " + activity.name + "\n" + activity.content1 + "\n" + activity.concern + "\n" + activity.endquote,
                    fontHeight * 0.042, Colors.black)   //Size: 16
            ],
          ),
        ),
        //AlertDialog() actions
        actions: [
          //Displays buttons based on Activity type
          if (activity.type == ActivityTypes[2])
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Approve button Container()
                  Container(
                    width: fontHeight * 0.298,                  //Width of Container() Size: 100
                    height: fontHeight * 0.15,                  //Height of Container() Size: 50
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,                //Shape of the Container
                      color: Colors.green,                      //Colour of the Container
                      borderRadius: BorderRadius.circular(8),   //Rounded corners to the Container
                    ),
                    //Approve text button
                    child: TextButton(
                      child: Text("Approve",
                        style: TextStyle(fontSize: fontHeight * 0.048, color: Colors.white),
                      ),    //Size: 16
                      //Textbutton() functionality
                      onPressed: () {
                        //Delete the specific activity from activities List
                        deleteActivity(setStateCallback, context, activityData, index);
                      },
                    ),
                  ),
                  SizedBox(width: fontHeight * 0.045),          //Size: 15
                  //Deny button Container()
                  Container(
                    width: fontHeight * 0.298,                  //Width of Container()  Size: 100
                    height: fontHeight * 0.15,                  //Height of Container() Size: 50
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,                //Shape of the Container
                      color: Colors.red,                        //Colour of the Container
                      borderRadius: BorderRadius.circular(8),   //Rounded corners to the Container
                    ),
                    //Deny text button
                    child: TextButton(
                      child: Text("Deny",                       //Deny text button
                        style: TextStyle(fontSize: fontHeight * 0.048, color: Colors.white),    //Size: 16
                      ),    //Size: 16
                      //Textbutton() functionality
                      onPressed: () {
                        deleteActivity(setStateCallback, context, activityData, index);
                      },
                    ),
                  ),
                ]
              ),
            )
          else
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Delete button
                  IconButton(
                    icon: Icon(Icons.delete_outline_outlined, size: fontHeight * 0.072, color: Colors.grey),   //Size: 24
                    //IconButton() functionality
                    onPressed: () {
                      //Delete the specific activity from activities List
                      deleteActivity(setStateCallback, context, activityData, index);
                    },
                  ),
                  SizedBox(width: fontHeight * 0.045),    //Size: 15
                  //Displays add identity button for ID Activity type
                  if (activity.type == ActivityTypes[1])
                  //Add new identity button
                    IconButton(
                      icon: Icon(Icons.add_box_outlined, size: fontHeight * 0.072, color: Colors.grey),   //Size: 24
                      //IconButton() functionality
                      onPressed: () {
                      },
                    )
                  else
                    SizedBox(width: fontHeight * 0.13),   //Size: 45
                  SizedBox(width: fontHeight * 0.045),    //Size: 15
                  //Share button
                  IconButton(
                    icon: Icon(Icons.share_outlined, size: fontHeight * 0.072, color: Colors.grey),   //Size: 24
                    //IconButton() functionality
                    onPressed: () {
                    },
                  ),
                ]
              ),
            ),
          SizedBox(height: fontHeight * 0.045),    //Size: 45
        ],
      );
    },
  );
}