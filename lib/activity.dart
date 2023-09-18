import 'package:flutter/material.dart';
import 'activities.dart';

//Activity page widget class
class ActivityPage extends StatefulWidget {
  //Allowing Activity page to change state with a new key
  const ActivityPage({super.key});
  //CreateState() function to make buttons function to change state
  @override
  State<ActivityPage> createState() => ActivityPageState();
}

//Main Activity page class
class ActivityPageState extends State<ActivityPage> {
  //ActivityData List
  List<Activity> activities = activityData;   //Stores Activity data

  //Build() method that builds the Activity page
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double fontHeight = screenHeight * 0.47;    //Height: 335
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Card(
              elevation: 6,   //Card shadow effect with elevation value
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //If activities List is empty
                    if (activities.isEmpty)
                      activitiesStatus(fontHeight * 0.072, fontHeight * 0.048, "No activities")   //IconSize: 24 and fontSize: 16
                    //If there's activities in activities List
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: activities.length,                                                   //List count
                        separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey),   //List divider for each index
                        itemBuilder: (context, index) {
                          final activity = activities[index];   //Gets 1 Activity item from activities List
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                              //Activity card functionality
                              onTap:(){
                                showActCardMenu(screenWidth, screenHeight, setState, context, activity, index);
                              },
                              //Activity information
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
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
                                            splitActivityName(activity.name, (screenWidth * 0.052).toInt()),    //Size: 23
                                            style: TextStyle(fontSize: fontHeight * 0.048),
                                          ),
                                        ],
                                      ),
                                      //Activity timestamp
                                      Expanded(
                                        child: Text(
                                          getTimeAgo(activity.timestamp),
                                          style: TextStyle(fontSize: fontHeight * 0.042, color: Colors.grey),
                                          textAlign: TextAlign.right,
                                        ),    //Size: 14
                                      )
                                    ]
                                  ),
                                  //Activity description text based on activity type
                                  Row(
                                    children: [
                                      SizedBox(width: 16),
                                      if (activity.type == "ID")
                                        rowText(300, "Your " + activity.IDs.first.type + " is expiring soon!",
                                            fontHeight * 0.042, Colors.grey)    //Size: 14
                                      else if (activity.type == "Request")
                                        rowText(300, activity.requestname + " is requesting access to your " + activity.IDs.first.type,
                                            fontHeight * 0.042, Colors.grey)    //Size: 14
                                      else
                                        rowText(300, "Scanned your " + activity.IDs.first.type + " at " + activity.name,
                                            fontHeight * 0.042, Colors.grey)    //Size: 14
                                    ],
                                  ),
                                ]
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}