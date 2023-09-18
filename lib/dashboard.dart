import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'activities.dart';
import 'identities.dart';

//PieData class to store data required for PieChartSectionData
class PieData {
  final String name;      //PieData name
  final IconData icon;    //PieData icon
  int value;              //PieData value
  final Color colour;     //PieData section colour
  final String IDType;   //PieData IDs List

  //PieData class input
  PieData({required this.name, required this.icon, required this.value, required this.colour, required this.IDType});
}

//Main Privacy Dashboard page class
class Dashboard extends StatelessWidget {
  //Privacy Dashboard Lists
  List<Identity> identities = identityData;   //Stores Identity data
  List<Activity> activities = activityData;   //Stores Activity data
  //PieData Lists
  List<PieData> locationsData = [];           //Stores Location data for pie chart
  List<PieData> idUsage = [];                 //Stores Identity Usage data for pie chart
  List<PieData> dataShared = [];              //Stores Data Shared data for pie chart
  List<PieData> tempPieList = [];
  //Color List
  List<Color> colours = [randomColour(), randomColour()];   //Stores Used Colour data for pie chart

  //initLists() method
  //Initialises Location data, Identity Usage data and Data Shared data from Identity and Activity Lists
  void initLists(){
    //Transfer relevant data for Locations List and each data index gets a random colour
    for (int i = 0; i < activityData.length; i++){
      //Only transfer data to Locations List if Activity type is a location
      if (activityData[i].type == "Location"){
        //If a location name already exists
        int existingIndex = locationsData.indexWhere((data) => data.name == activityData[i].name);
        if (existingIndex != -1) {
          //Add the count to the already existing location in locationsData List
          locationsData[existingIndex].value += activityData[i].count;
        }
        else {
          //Add a new location in locationsData List
          locationsData.add(PieData(name: activityData[i].name, icon: getTypeIcon(activityData[i]),
              value: activityData[i].count, colour: activityData[i].colour, IDType: activityData[i].IDs[0].type)
          );
        }
      }
    }
    //Initialises Data Shared List by adding only 2 indexes to list
    //Only 2 indexes are needed
    dataShared.add(PieData(name: "Partially", icon: Icons.shield_outlined, value: 0, colour: colours[0], IDType: ""));
    dataShared.add(PieData(name: "Fully", icon: Icons.shield_outlined, value: 0, colour: colours[1], IDType: ""));
    for (int i = 0; i < identityData.length; i++) {
      //Transfer relevant data for Identity Usage List and each data index gets a random colour
      idUsage.add(PieData(name: identityData[i].idName, icon: identityData[i].icon,
          value:identityData[i].usage, colour: identityData[i].colour, IDType: identityData[i].type)
      );
      //Only transfer data to DataShared List if Identity is verified
      if (identityData[i].isVerified == true){
        //Transfer relevant data for Data Shared List
        dataShared[0].value += identities[i].partial;
        dataShared[1].value += identities[i].full;
      }
    }
  }

  //genPieChartSections() method
  //Generates Pie chart based on data from PieData List
  List<PieChartSectionData> genPieChartSections(List<PieData> data) {
    List<PieChartSectionData> sections = [];      //Stores data to be displayed in Pie chart
    for (int i = 0; i < data.length; i++) {       //Iterates through data List
      sections.add(
        PieChartSectionData(
          value: data[i].value.toDouble(),        //Data value
          color: data[i].colour,                  //Section colour
          radius: 30,                             //Radius of the Pie chart
        ),
      );
    }
    return sections;                              //Returns Pie chart
  }

  //showPieCardMenu() method
  //Shows a alertDialog Container() of the specific data displayed in the PieChart List
  //The menu shows the specific ID the PieChart List is associated with
  void showPieCardMenu(double width, double height, BuildContext context, String title, String total) {
    double fontHeight = height * 0.47;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            width: width,             //Width of Container()  Size: 300
            height: height * 0.72,    //Height of Container() Size: 370
              child: Column(
                children:[
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
                  SizedBox(height: 12),
                  //Displays Pie chart data title
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black, fontSize: fontHeight * 0.072, fontWeight: FontWeight.bold),    //Size: 24
                  ),
                  SizedBox(height: fontHeight * 0.045),    //Size: 15
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (title != "Data Shared")
                        Text(
                          title + ": " + locationsData.length.toString(),
                          style: TextStyle(
                              color: Colors.grey, fontSize: fontHeight * 0.042),    //Size: 14
                          textAlign: TextAlign.left,
                        ),
                      Expanded(
                        child: Text(
                          "Total: " + total.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: fontHeight * 0.042),    //Size: 14
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: fontHeight * 0.045),    //Size: 15
                  Divider(height: 1, color: Colors.grey),   //Line divider
                  Expanded(
                    child: SingleChildScrollView(
                      //List the data types
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: identityData.length,                                                         //List count
                        separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey),   //List divider for each item
                        itemBuilder: (context, index) {
                          tempPieList.clear();
                          final identity = identityData[index];                      //Gets 1 List item from the List
                          int quantity = 0;
                          if (title == "Locations"){
                            for (int i = 0; i < activityData.length; i++) {
                              if (activityData[i].IDs[0].type == identity.type && activityData[i].type == ActivityTypes[0]) {
                                int existingIndex = tempPieList.indexWhere((data) => data.name == activityData[i].name);
                                if (existingIndex != -1) {
                                  //Add the count to the already existing location in locationsData List
                                  tempPieList[existingIndex].value += activityData[i].count;
                                }
                                else {
                                  //Add a new location in locationsData List
                                  tempPieList.add(PieData(name: activityData[i].name, icon: getTypeIcon(activityData[i]),
                                      value: activityData[i].count, colour: activityData[i].colour, IDType: activityData[i].IDs[0].type));
                                }
                              }
                            }
                          }
                          else {
                            tempPieList.add(PieData(name: "Partially", icon: Icons.shield_outlined,
                                value: identity.partial, colour: dataShared[0].colour, IDType: identity.type));
                            tempPieList.add(PieData(name: "Fully", icon: Icons.shield_outlined,
                                value: identity.full, colour: dataShared[1].colour, IDType: identity.type));
                          }
                          if (identity.isVerified == true){
                            quantity = tempPieList.length;
                          }

                          //Data type information
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,    //Column Alignment
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 12),
                                    //Data type icon
                                    Icon(identityData[0].icon, size: fontHeight * 0.054, color: identity.colour),
                                    SizedBox(width: 8),
                                    //ID type name
                                    Text(
                                      identity.type,
                                      style: TextStyle(fontSize: fontHeight * 0.048, fontWeight: FontWeight.bold),    //Size: 16
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: 5),
                                    Icon(identity.isVerified ? Icons.verified_outlined : Icons.pending_outlined,
                                        size: fontHeight * 0.054, color: identity.isVerified ? Colors.green : Colors.blue),    //Size: 18
                                  ],
                                ),
                                SizedBox(height: 5),
                                //Data type value/occurrence
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (title != "Data Shared")
                                      Text(
                                        title + ": " + quantity.toString(),
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: fontHeight * 0.036),    //Size: 14
                                        textAlign: TextAlign.left,
                                      ),
                                    Expanded(
                                      child: Text(
                                        "Total: " + identity.usage.toString(),
                                        style: TextStyle(color: Colors.grey, fontSize: fontHeight * 0.036),    //Size: 12
                                        textAlign: TextAlign.right,
                                      ),
                                    )
                                  ],
                                ),
                                if (identity.isVerified == false)
                                  activitiesStatus(fontHeight * 0.0597, fontHeight * 0.042, "No " + title + " data")       //IconSize: 20, fontSize: 14
                                else
                                  if (title == "Locations")
                                    dataTypeList(tempPieList, fontHeight * 0.0597, width, fontHeight * 0.042, fontHeight * 0.036)    //List data in Pie chart
                                    //IconSize:Size: 20, fontSizes: 14 and 12
                                  else
                                    dataTypeList(tempPieList, fontHeight * 0.0597, width, fontHeight * 0.042, fontHeight * 0.036)    //List data in Pie chart
                                    //IconSize:Size: 20, fontSizes: 14 and 12
                              ]
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ]
              ),
            ),
            //AlertDialog() actions
            actions: [
            ],
          );
        }
    );
  }


  //dataMenu() method
  //Returns a padded Container() that displays the pie chart
  //There's a subsection that shows the specific data shown that is also colour-coded
  Padding dataMenu(double width, double height, BuildContext context, List<PieData> list, String title, String subtitle){
    double fontHeight = height * 0.47;                //Height: 335
    int totalValue = list.fold(0, (sum, data) => sum + data.value);
    return Padding(
      padding: EdgeInsets.all(8.0),                   //Padding of Container()
      child: InkWell(
        //Identity card functionality
        onTap: () {
          if (title != "ID Usage" && locationsData.isNotEmpty){
            showPieCardMenu(width, height, context, title, totalValue.toString());
          }
        },
        child: Container(
          width: width * 0.96,                          //Width of Container()
          height: (height * 0.81) * 0.98,               //Height of Container()
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,    //Column Alignment
            children: [
              SizedBox(height: 12),
              //Displays Pie chart data title
              Text(
                title,
                style: TextStyle(
                    color: Colors.black, fontSize: fontHeight * 0.072, fontWeight: FontWeight.bold),    //Size: 24
              ),
              SizedBox(height: 12),
              if (list.isEmpty || list.every((data) => data.value == 0))
                Container(                      //Size: 250
                  width: fontHeight * 0.75,     //Width of Container()
                  height: fontHeight * 0.75,    //Height of Container()
                  child: activitiesStatus(fontHeight * 0.072, fontHeight * 0.048, "No " + title + " data"),
                )                                //IconSize: 24 and fontSize: 16
              else
                //Pie chart
                Container(                      //Size: 250
                  width: fontHeight * 0.75,     //Width of Container()
                  height: fontHeight * 0.75,    //Height of Container()
                  child: PieChart(
                    PieChartData(
                      sections: genPieChartSections(list),
                    ),
                  ),
                ),
              SizedBox(height: fontHeight * 0.0896),    //Size: 30
              Divider(height: 1, color: Colors.grey),   //Line divider
              SizedBox(height: fontHeight * 0.0896),    //Size: 30
              Text(
                subtitle,
                style: TextStyle(fontSize: fontHeight * 0.0597, fontWeight: FontWeight.bold),    //Size: 20
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (title != "Data Shared")
                      Text(
                        subtitle + "s: " + list.length.toString(),
                        style: TextStyle(
                          color: Colors.grey, fontSize: fontHeight * 0.042),    //Size: 14
                        textAlign: TextAlign.left,
                      ),
                    Expanded(
                      child: Text(
                        "Total: " + totalValue.toString(),
                        style: TextStyle(color: Colors.grey, fontSize: fontHeight * 0.042),    //Size: 14
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
              if (list.isEmpty)
                activitiesStatus(fontHeight * 0.072, fontHeight * 0.048, "No " + title + " data")       //IconSize: 24, fontSize: 16
              else
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children:[
                          dataTypeList(list, fontHeight * 0.072, width, fontHeight * 0.048, fontHeight * 0.042),    //List data in Pie chart
                          //IconSize:Size: 24, fontSizes: 16 and 14
                        ]
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  //dataTypeList() method
  //Returns a Column in ListView() of the data types in the PieData List
  ListView dataTypeList(List<PieData> list, double iconSize, double width, double fontSize1, double fontSize2){
    //List the data types
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: list.length,                                                         //List count
      separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey),   //List divider for each item
      itemBuilder: (context, index) {
        final element = list[index];                      //Gets 1 List item from the List
        //Data type information
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Data type icon
              Icon(element.icon, size: iconSize, color: element.colour),
              SizedBox(width: 8),
              //Data type name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    splitActivityName(element.name, (width * 0.052).toInt()),    //Size: 23
                    style: TextStyle(fontSize: fontSize1),
                  ),
                ],
              ),
              //Data type value/occurrence
              Expanded(
                child: Text(
                  element.value.toString() + " times",
                  style: TextStyle(fontSize: fontSize2, color: Colors.grey),
                  textAlign: TextAlign.right,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //Build() method that builds the Privacy Dashboard page
  @override
  Widget build(BuildContext context) {
    //Gets the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //Card scroll width and height
    double cardScrollWidth = screenWidth * 0.9;
    double cardScrollHeight = screenHeight * 0.81;    //Size: 650
    double menuWidth = cardScrollWidth * 0.9;
    //Clear PieData Lists at start of loading Privacy Dashboard page
    locationsData.clear();
    idUsage.clear();
    dataShared.clear();
    //Initialise PieData Lists
    initLists();
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                width: cardScrollWidth,               //Width of Container()
                height: cardScrollHeight,             //Height of Container()
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,   //ListView scroll direction
                  itemCount: 3,                       //List count
                  itemBuilder: (context, index) {     //List builder
                    if (index == 0) {
                      return dataMenu(menuWidth, screenHeight, context, locationsData, "Locations", "Location");
                    }
                    else if (index == 1) {
                      return dataMenu(menuWidth, screenHeight, context, idUsage, "ID Usage", "ID");
                    }
                    else {
                      return dataMenu(menuWidth, screenHeight, context, dataShared, "Data Shared", "Data");
                    }
                  }
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}