import 'dart:math';
import 'package:di_me_app/identities.dart';
import 'package:flutter/material.dart';
import 'activities.dart';

List<String> randomPlaces = [
  "Smoking Goose",
  "Birmingham International Airport",
  "Cosmic Casino",
  "The Rusty Tavern",
  "TechZone Mall",
  "The Enchanted Forest Bar",
  "Epic Eats Diner",
  "Starlight Theatre",
  "Sugarhouse",
  "Neon Nights Nightclub",
  "Quantum Quasar Cafe",
  "Interstellar Inn",
  "Red Dragon Restaurant",
  "The Time Bender Club",
  "Stardust Saloon",
];

//getRandomActivity() method
//Generates a new activity by choosing a random name from randomPlaces List
//It automatically sets the name, the type to Location, the timestamp, the count, partial, full Lists and IDs List
Activity getRandomActivity(Identity id) {
  String shareStat = "";
  int randomIndex = Random().nextInt(randomPlaces.length);
  if (id.isVerified == true){
    if (id.secureShare == false){
      shareStat = "Full";
    }
    else {
      shareStat = "Partial";
    }
  }
  Activity genAct =  Activity(name:randomPlaces[randomIndex], type: "Location",
      timestamp: DateTime.now().millisecondsSinceEpoch, colour: randomColour(), requestname: "",
      count: 0, shareStat: shareStat, partial: [0], full: [0], IDs: []);
  if (activityData.isNotEmpty){
    int actExists = activityData.indexWhere((element) => element.name == randomPlaces[randomIndex]);
    int actColourExists = activityData.indexWhere((element) => element.colour == genAct.colour);
    if (actExists == -1 && actColourExists == -1){
      return genAct;
    }
    else if (actExists != -1 && actColourExists == -1){
      return Activity(name:randomPlaces[randomIndex], type: "Location",
          timestamp: DateTime.now().millisecondsSinceEpoch, colour: activityData[actExists].colour, requestname: "",
          count: 0, shareStat: shareStat, partial: [0], full: [0], IDs: []);
    }
    else {
      return getRandomActivity(id);
    }
  }
  else {
    return genAct;
  }
}

//getRandomIdentity() method
//Generates a new identity by choosing a random name from IDNames List
//And choosing a random type from IDTypes List
//The method also checks if the ID already exists as only 1 can exist
//2 IDs of the same type can exist if one is not verified
Identity getRandomIdentity() {
  int randomNum = Random().nextInt(2001) + 2000;
  int randomIndex = Random().nextInt(IDNames.length);
  //Generated ID
  Identity genID = Identity(idName: IDNames[randomIndex], type: IDTypes[randomIndex],
      firstName: "John", surName: "Doe", age: 26, dob: "23-09-1996",
      expiryDate: DateTime.now().add(Duration(days: randomNum)), colour: randomColour(), isVerified: true,
      usage: 0, partial: 0,full: 0);
  if (identityData.isNotEmpty){
    int idCount = identityData.where((identity) => identity.type == genID.type).length;
    for (Identity identity in identityData){
      if (identity.type == genID.type && identity.isVerified == false && idCount < 2 && identity.colour != genID.colour){
        return genID;
      }
    }
    int idExistsIndex = identityData.indexWhere((identity) => identity.type == genID.type);
    int idColourExists = identityData.indexWhere((identity) => identity.colour == genID.colour);
    if (idExistsIndex == -1 && idColourExists == -1){
      return genID;
    }
    else if (idExistsIndex == -1 && idColourExists != -1){
      return Identity(idName: IDNames[randomIndex], type: IDTypes[randomIndex],
          firstName: "John", surName: "Doe", age: 26, dob: "23-09-1996",
          expiryDate: DateTime.now().add(Duration(days: randomNum)), colour: randomColour(), isVerified: true,
          usage: 0, partial: 0,full: 0);
    }
    else {
      return Identity(idName: IDNames[randomIndex], type: IDTypes[randomIndex],
          firstName: "0", surName: "0", age: 0, dob: "0",
          expiryDate: DateTime.now().add(Duration(days: 0)), colour: randomColour(), isVerified: false,
          usage: 0, partial: 0,full: 0);
    }

  }
  else {
    return genID;
  }
}

//Returns index of identity in activity IDs List
int searchID(Activity act, Identity id){
  return act.IDs.indexWhere((element) => element == id);
}

//showTestActivityMenu() method
//Shows a alertDialog Container() when a user is at a location and is having their ID scanned
//The menu shows a alert to the user to whether to approve or deny access to their ID
//The location will be added to the activities List
void showTestActivityMenu(double width, double height, Function setStateCallback, BuildContext context, Identity identity, int index){
  double fontHeight = height * 0.47;
  Activity activity = getRandomActivity(identity);
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
              Icon(getTypeIcon(activity), size: fontHeight * 0.299, color:identity.colour),
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
                style: TextStyle(fontSize: fontHeight * 0.042, color: Colors.grey),   //Size: 14
              ),
              //Displays text for each row based on Activity type
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    width: width,
                    child: Text(activity.name + " is requesting access to your " + identity.type,
                      style: TextStyle(fontSize: fontHeight * 0.048, color: Colors.black), textAlign: TextAlign.center
                    ),    //Size: 16
                  ),
                ),
              ),
            ],
          ),
        ),
        //AlertDialog() actions
        actions: [
          //Displays Approve and Deny buttons
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
                        //If
                        int IDindex = 0;
                        IDindex = searchID(activity, identity);
                        setStateCallback(() {
                          //Increase partial or full int value and usage value
                          if (IDindex > 0){
                            if (identity.secureShare == true) {
                              activity.partial[IDindex]++;
                              identity.partial++;
                            }
                            else {
                              activity.full[IDindex]++;
                              identity.full++;
                            }
                          }
                          else {
                            IDindex = 0;
                            if (identity.secureShare == true) {
                              activity.partial[IDindex]++;
                              identity.partial++;
                            }
                            else {
                              activity.full[IDindex]++;
                              identity.full++;
                            }
                          }
                          identity.usage++;
                          activity.IDs.add(identity);
                          activity.count++;

                          //Adds new activity to the top of activityData List for display
                          List<Activity> tempList = activityData.reversed.toList();
                          tempList.add(activity);
                          activityData = tempList.reversed.toList();
                          //Pops out of context menu
                          Navigator.pop(context);
                        });
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
                        style: TextStyle(fontSize: fontHeight * 0.048, color: Colors.white),
                      ),    //Size: 16
                      //Textbutton() functionality
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]
            ),
          )
        ],
      );
    },
  );
}

//addIdentityCard() method
//Returns a Container() to allow the user to add a generated Identity
Padding addIdentityCard(double width, double height, double cardWidth, double cardHeight, VoidCallback refresh, BuildContext context, IconData icon, double iconSize, Color iconColour, String errorText, double fontSize, bool home){
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      width: cardWidth,                             //Width of Container()  Size: 150
      height: cardHeight,                           //Height of Container() Size: 335
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,                  //Shape of the Container
        color: Colors.white,                        //Colour of the Container
        borderRadius: BorderRadius.circular(8),     //Rounded corners to the Container
        boxShadow: [                                //Container box shadow
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),    //Colour of the shadow
            spreadRadius: 2,                        //Spread radius of the shadow
            blurRadius: 5,                          //blur radius of the shadow
            offset: Offset(0, 2),                   //The offset of the shadow, for horizontal and vertical
          ),
        ],
      ),
      //Identity card information
      child: InkWell(
        //Identity card functionality based on make Tap boolean value
        onTap: () {
          if (home == true){
            showTestIdentityMenu(width, height, refresh, context);
          }
          else {
            showTestIdentityMenu(width, height, refresh, context);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            //Fingerprint icon
            Icon(icon, size: iconSize, color: iconColour),
            SizedBox(height: 8),
            //Name of ID
            Text(errorText,
              style: TextStyle(color: Colors.black, fontSize: fontSize),
              textAlign: TextAlign.center,),
            SizedBox(height: 50),
          ],
        ),
      ),
    ),
  );
}

//showTestIdentityMenu() method
//Shows a alertDialog Container() when a user is adding a new ID
//This ID will be randomly generated for testing
//The menu shows a alert to the user to whether to approve or deny to add the new ID
//The new ID will be added to the identities List
//This method also displays an error if the maximum amount of IDs has been reached
//1 verified ID Type each or 2 if one ID for that ID Type is not verified
Future<void> showTestIdentityMenu(double width, double height, VoidCallback refresh, BuildContext context) async {
  double fontHeight = height * 0.47;
  Identity identity = getRandomIdentity();
  showDialog<void>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          //If the maximum amount for the ID Type has not been reached
          if (identity.age != 0) {
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
                    Text(
                      identity.idName,
                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.0597),   //Size: 20
                    ),
                    SizedBox(height: fontHeight * 0.024),   //Size: 8
                    //Fingerprint icon
                    Icon(Icons.fingerprint, size: fontHeight * 0.298, color: identity.colour),   //Size: 100
                    SizedBox(height: fontHeight * 0.024),   //Size: 8
                    //First name and Surname in ID
                    Text(
                      identity.firstName + " " + identity.surName,
                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.048),   //Size: 16
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Age in ID
                        Text(
                          "Age: " + identity.age.toString(),
                          style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.048),   //Size: 16
                        ),
                        //ID verification icon
                        SizedBox(width: 5), // Add some spacing between the icon and the text
                        Icon(identity.isVerified ? Icons.verified_outlined : Icons.pending_outlined, size: fontHeight * 0.0597,
                          color: identity.isVerified ? Colors.green : Colors.blue
                        ),    //Size: 20
                      ]
                    ),
                    //Date of Birth in ID
                    SizedBox(height: fontHeight * 0.024),   //Size: 8
                    Text(
                      "DoB: " + identity.dob,
                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.048),   //Size: 16
                    ),
                    //ID type
                    Text (
                      "ID: " + identity.type,
                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.048),   //Size: 16
                    ),
                    //ID expiry date
                    Text(
                      "Expires: " + formatExpDate(identity.expiryDate),
                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.048),   //Size: 16
                    ),
                    SizedBox(height: fontHeight * 0.0895),    //Size: 30
                    SizedBox(height: fontHeight * 0.0299),    //Size: 10
                    Divider(height: 1, color: Colors.grey),   //Line divider
                  ],
                ),
              ),
              //AlertDialog() actions
              actions: [
                //Displays Approve and Deny buttons
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Approve button Container()
                      Container(
                        width: fontHeight * 0.298,                  //Width of Container()  Size: 100
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
                            identityData.add(identity);
                            //Pops out of context menu
                            Navigator.pop(context);
                            refresh();
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
                            style: TextStyle(fontSize: fontHeight * 0.048, color: Colors.white),
                          ),    //Size: 16
                          //Textbutton() functionality
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ]
                  ),
                )
              ],
            );
          }
          //If the maximum amount for the ID Type has been reached
          else {
            return AlertDialog(
              content: Container(
                width: width,             //Width of Container()  Size: 300
                height: height * 0.72,    //Height of Container() Size: 370
                child: Column(
                  children: [
                    //Back button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.blue,),
                        //IconButton() functionality
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(height: 50),
                    //Reached maxmimum number of IDs
                    Text("Reached Max \nAmount!",
                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.0597, fontWeight: FontWeight.bold), textAlign: TextAlign.center,   //Size: 20
                    ),
                    SizedBox(height: fontHeight * 0.024),   //Size: 8
                    Icon(Icons.error_outline_outlined, size: fontHeight * 0.298, color: Colors.red),   //Size: 100
                    SizedBox(height: fontHeight * 0.024),   //Size: 8
                    SizedBox(height: fontHeight * 0.024),   //Size: 8
                    //ID Type
                    Text("Identity Type: ",
                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.048, fontWeight: FontWeight.bold),   //Size: 20
                    ),
                    SizedBox(height: fontHeight * 0.024),   //Size: 8
                    Text(identity.type.toString(),
                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.048),   //Size: 16
                    ),
                    SizedBox(height: fontHeight * 0.024),   //Size: 8
                    //ID already exists
                    Text("Exists!",
                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.048),   //Size: 16
                    ),
                  ]
                ),
              ),
              //AlertDialog() actions
              actions: [
              ],
            );
          }
        }
      );
    },
  );
}