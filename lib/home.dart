import 'package:flutter/material.dart';
import 'activities.dart';
import 'identities.dart';
import 'toggle.dart';
import 'TestingFile.dart';

//Home page widget class
class HomePage extends StatefulWidget {
  //Allowing Home page to change state with a new key
  const HomePage({super.key});
  //CreateState() function to make buttons function to change state
  @override
  State<HomePage> createState() => HomePageState();
}

//Main Home page class
class HomePageState extends State<HomePage> {
  //Home page Lists
  List<Identity> identities = identityData;   //Stores Identity data
  List<Activity> activities = activityData;   //Stores Activity data

  //addIdentityButton() method
  //Returns a padded circle Container() button to add a new identity
  Padding addIdentityButton(double width, double height, VoidCallback refresh, BuildContext context){
    double fontHeight = height * 0.47;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: fontHeight * 0.18,                     //Width of Container()
        decoration: BoxDecoration(
          shape: BoxShape.circle,                     //Shape of the Container
          color: Colors.white,                        //Colour of the Container
          boxShadow: [                                //Container box shadow
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),    //Colour of the shadow
              spreadRadius: 2,                        //Spread radius of the shadow
              blurRadius: 5,                          //blur radius of the shadow
              offset: Offset(0, 2),                   //The offset of the shadow, for horizontal and vertical
            ),
          ],
        ),
        //Plus IconButton to add a new identity
        child: IconButton(
          alignment: Alignment.center,
          icon: Icon(Icons.add, size: fontHeight * 0.12, color: Colors.black),
          //IconButton() functionality
          onPressed: () {
            showTestIdentityMenu(width, height, refresh, context);
          },
        ),
      ),
    );
  }

  //showIDCardMenu() method
  //Shows a alertDialog Container() when an identity card is pressed
  //More information about the specific user identity in the identities list
  Future<void> showIDCardMenu(double width, double height, Identity identity, int index, VoidCallback refresh) async {
    double fontHeight = height * 0.47;
    showDialog<void>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Container(
                width: width,             //Width of Container()  Size: 300
                height: height * 0.72,   //Height of Container() Size: 410
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
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
                        SizedBox(width: width * 0.06),
                        //Identity card title
                        Align(
                          alignment: Alignment.center,
                          child: Text(identity.idName,  style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.0597),
                            textAlign: TextAlign.center),   //Size: 20
                        ),
                        SizedBox(width: width * 0.06),
                        //Delete button
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: Icon(Icons.delete_outline_outlined,  color: Colors.grey),
                            //IconButton() functionality
                            onPressed: () {
                              //Used deleteIdentity() method from activities.dart to delete a identity
                              deleteIdentity(setState, context, identities, index);
                              //Refreshes Home page state
                              refresh();
                            },
                          ),
                        ),
                      ]
                    ),
                    SizedBox(height: 10), //Size: 10
                    Container(
                      width: width * 0.96,                          //Width of Container() Size: 270
                      height: (height* 0.713) * 0.9,                //Height of Container() Size: 360
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,                  //Shape of the identity cards
                        color: Colors.white,                        //Colour of the identity cards
                        borderRadius: BorderRadius.circular(8),     //Rounded corners to the identity cards
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
                      child:Column(
                        children:[
                          SizedBox(height: fontHeight * 0.0895),    //Size: 30
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
                                color: identity.isVerified ? Colors.green : Colors.blue,
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
                          SizedBox(height: fontHeight * 0.0299),    //Size: 10
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                //Setting toggles for this ID
                                //Consent Renewal feature information and toggle
                                buildToggleSetting(
                                  'Consent Renewal',
                                  fontHeight * 0.048,     //Size: 16
                                  'Certification consent will need to be renewed',
                                  fontHeight * 0.042,     //Size: 14
                                  identity.consentRenewal,
                                      (value) {
                                    setState(() {
                                      identity.consentRenewal = value;
                                    });
                                  },
                                ),
                                SizedBox(height: fontHeight * 0.015),   //Size: 5
                                //Secure Share feature information and toggle
                                buildToggleSetting(
                                  'Secure Share',
                                  fontHeight * 0.048,     //Size: 16
                                  'Only share verification of your Digital ID',
                                  fontHeight * 0.042,     //Size: 14
                                  identity.secureShare,
                                      (value) {
                                    setState(() {
                                      identity.secureShare = value;
                                    });
                                  },
                                ),
                              ]
                            ),
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              ),
              //AlertDialog() actions
              actions: [
              ],
              //Text('Your ID is expiring in 7 days or less. Please renew it.'),
            );
          }
        );
      },
    );
  }

  //showActCardMenu() method
  //Shows a alertDialog Container() when an activity is pressed
  //More information about the specific user activity in the activities list
  //Displays action buttons based on activity type
  Future<void> showActCardMenu(double width, double height, VoidCallback refresh, BuildContext context, Activity activity, int index) async {
    double fontHeight = height * 0.47;
    showDialog<void>(
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
                            deleteActivity(setState, context, activityData, index);
                            //Refreshes Home page state
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
                            style: TextStyle(fontSize: fontHeight * 0.048, color: Colors.white),    //Size: 16
                          ),    //Size: 16
                          //Textbutton() functionality
                          onPressed: () {
                            //Delete the specific activity from activities List
                            deleteActivity(setState, context, activityData, index);
                            //Refreshes Home page state
                            refresh();
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
                          deleteActivity(setState, context, activityData, index);
                          //Refreshes Home page state
                          refresh();
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

  //activityCardMenu() method
  //Returns a Card() that contains a summary of the activities to the user
  //This contains a ListView() of each activity including the icon, name and timestamp
  Card activityCardMenu(double width, double height, VoidCallback refresh){
    double fontHeight = height * 0.47;
    return Card(
      elevation: 6,                                         //Card shadow effect with elevation value
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Activity card title
            Text(
              'Recent Activity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            //If activities List is empty
            if (activities.isEmpty)
              activitiesStatus(fontHeight * 0.072, fontHeight * 0.048, "No activities")   //IconSize: 24 and fontSize: 16
            //If there's activities in activities List
            else
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: activities.length > 5 ? 5 : activities.length,                       //List count
                separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey),   //List divider for each list item
                itemBuilder: (context, index) {
                  final activity = activities[index];   //Gets 1 Activity item from activities List
                  //Activity information
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: InkWell(
                      //Activity card functionality
                      onTap:(){
                        showActCardMenu(width, height, refresh, context, activity, index);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Activity icon
                          if (activity.type == "Request")
                            Icon(getTypeIcon(activity), size: fontHeight * 0.072, color: activity.colour)    //Size: 24
                          else
                            Icon(getTypeIcon(activity), size: fontHeight * 0.072, color: activity.IDs[0].colour),    //Size: 24
                          SizedBox(width: 8),
                          //Activity name
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                splitActivityName(activity.name, (width * 0.052).toInt()),    //Size: 23
                                style: TextStyle(fontSize: fontHeight * 0.048),
                              ),
                            ],
                          ),
                          //Activity timestamp
                          Expanded(
                            child: Text(
                              getTimeAgo(activity.timestamp),
                              style: TextStyle(fontSize: fontHeight * 0.042, color: Colors.grey),   //Size 14
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  //Build() method that builds the Home page
  @override
  Widget build(BuildContext context) {
    //Gets the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double cardScrollWidth = screenWidth * 0.6;
    double cardScrollHeight = screenHeight * 0.47;    //Height: 335

    return Scaffold(
      body: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            //Horizontal scroll of identity cards
            Container(
              width: cardScrollWidth,               //Width of Container()  Size: 600
              height: cardScrollHeight,             //Height of Container() Size: 335
              child: ListView.builder(
                scrollDirection: Axis.horizontal,   //ListView scroll direction
                itemCount: identities.length + 1,   //List count
                itemBuilder: (context, index) {     //List builder
                  if (identities.isEmpty){
                    return addIdentityCard(screenWidth, screenHeight, cardScrollWidth, cardScrollHeight, () {setState(() {});}, context,
                        Icons.fingerprint, 100, Colors.red, "Add a identity",
                        cardScrollHeight * 0.0597, true);   //IconSize: 100 and fontSize: 18
                  }
                  else if (index == identities.length) {
                    //Displays add button as the last item in the list to add a new Identity
                    return addIdentityButton(screenWidth, screenHeight, () {setState(() {});}, context);
                  }
                  else {
                    //Display the current Identities in identities List as cards
                    Identity identity = identities[index];    //Gets 1 Identity element from identities List
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        //Identity card functionality
                        onTap: () {
                          showIDCardMenu(screenWidth, screenHeight, identity, index, () {setState(() {});});
                        },
                        child: Container(
                          width: cardScrollWidth * 0.65,                //Width of Container()  Size: 150
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: cardScrollHeight * 0.15),    //Size: 50
                              //Fingerprint icon
                              Icon(Icons.fingerprint, size: cardScrollHeight * 0.298, color: identity.colour),   //Size: 100
                              SizedBox(height: cardScrollHeight * 0.027),   //Size: 8
                              //Name of ID
                              Text(identity.idName,
                                style: TextStyle(color: Colors.black, fontSize: cardScrollHeight * 0.054),    //Size:18
                                textAlign: TextAlign.center,),
                              SizedBox(height: cardScrollHeight * 0.15),    //Size: 50
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //ID type
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      identity.type,
                                      style: TextStyle(color: Colors.black, fontSize: cardScrollHeight * 0.042),  //Size: 14
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: screenHeight * 0.015),    //Size: 5
                                  //ID verification icon
                                  Padding(
                                    padding: EdgeInsets.only(right: 0),
                                    child: Icon(identity.isVerified ? Icons.verified_outlined : Icons.pending_outlined,
                                      size: cardScrollHeight * 0.06, color: identity.isVerified ? Colors.green : Colors.blue),
                                  ),    //Size: 20
                                  //ID verification
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      identity.isVerified ? 'Verified' : 'Pending',
                                      style: TextStyle(color: Colors.black, fontSize: cardScrollHeight * 0.042),     //Size: 14
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  //ID QR code icon
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.qr_code_2_outlined,
                                        size: cardScrollHeight * 0.09, color: Colors.black),     //Size: 30
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            //Activity Card menu
            activityCardMenu(screenWidth, screenHeight, () {setState(() {});}),
          ],
        ),
      ),
    );
  }
}