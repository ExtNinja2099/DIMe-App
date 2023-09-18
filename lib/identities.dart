import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

//Identity class
//This holds all the variables to store information for each identity stored for the app
class Identity {
  final String idName;                                    //Identity name
  final String type;                                      //Type of Identity
  final IconData icon = Icons.account_circle_outlined;    //Icon used for Identity
  final String firstName;                                 //First name on ID
  final String surName;                                   //Surname on ID
  final int age;                                          //Age on ID
  final String phoneNum;                                  //Phone Number of User
  final String email;                                     //Email of User
  final String country;                                   //Country of residence of User
  final String language;                                  //Language of User
  final String dob;                                       //User's Date of Birth
  final DateTime expiryDate;                              //ID Expiry date
  final Color colour;                                     //Assigned Colour to ID
  bool isVerified;                                        //If ID has been verified or not
  bool consentRenewal = false;                            //Consent setting for ID
  bool secureShare = false;                               //Secure Share setting for ID
  int usage;                                              //ID Usage count
  int partial;                                            //Sharing partial ID info count
  int full;                                               //Sharing all ID info count

  Identity({required this.idName, required this.type, required this.firstName, required this.surName, required this.age,
    required this.dob, required this.expiryDate, required this.colour, required this.isVerified,
    required this.usage, required this.partial, required this.full})
    : phoneNum = "07000 000 000",
    email = "jdoe@gmail.com",
    country = 'United Kingdom',
    language = 'English (UK)'
  ;
}

//Identity Names List
//Holds the default names of a Identity card
List<String> IDNames = [
  "Driver DI",
  "Passport DI",
  "Identity DI"
];

//Identity Types List
//Holds the types of Identities the app accepts
List<String> IDTypes = [
  "Driving Licence",
  "Passport",
  "Identity Card"
];

//Identity Types List
//Holds the types of Identities the app accepts
List<String> shareTypes = [
  "Full",
  "Partial"
];

//Identity data List
//Holds initial data of user's ID that was added
List<Identity> identityData = [
  Identity(idName: IDNames[2], type: IDTypes[2], firstName: "John", surName: "Doe", age: 26, dob: "23-09-1996",
      expiryDate: DateTime.now().add(Duration(days: 7)), colour: randomColour(), isVerified: true,
      usage: 15, partial: 12, full: 3),
  Identity(idName: IDNames[0], type: IDTypes[0], firstName: "John", surName: "Doe", age: 26, dob: "23-09-1996",
      expiryDate: DateTime.now().add(Duration(days: 2555)), colour: randomColour(), isVerified: false,
      usage: 0, partial: 0, full: 0),
];

//formatExpDate() method
//This returns a String variable based on the expiry date of a ID
//The string is the date of when the identity expires
String formatExpDate(DateTime expDate) {
  String formattedDate = DateFormat('dd MMMM yyyy').format(expDate);
  return formattedDate;
}

//Color List
List<Color> usedColours = [];               //Stores Used Colour data

//randomColour() method
//Returns a random colour to be used in each Pie chart section
Color randomColour() {
  Color genColour;                              //Colour variable
  do {                                          //Iterates through colors.primaries[] List
    genColour = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    if (genColour == Colors.red){
      genColour = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    }
  } while (usedColours.contains(genColour));    //Iterates while usedColours[] List doesn't contain the randomly selected colour
  usedColours.add(genColour);                   //Adds the randomly selected colour to usedColours[] List

  // If all colors have been used, clear the usedColours[] List and start over
  if (usedColours.length == Colors.primaries.length) {
    usedColours.clear();
  }

  return genColour;                             //Returns the randomly selected colour
}

//identityErrorCard() method
//Returns a Container() to alert the user about their current identity issue
Padding identityErrorCard(BuildContext context, double width, double height, IconData icon, double iconSize, Color iconColour, String errorText, double fontSize){
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      width: width,                                 //Width of Container()
      height: height,                               //Height of Container()
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
          SizedBox(height: 50),
          //Fingerprint icon
          Icon(icon, size: iconSize, color: iconColour),
          SizedBox(height: 8),
          //Name of ID
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  errorText.split(' ').take(2).join(' '),
                  style: TextStyle(fontSize: fontSize),
                ),
                if (errorText.split(' ').length > 2)
                  Text(
                    errorText.split(' ').skip(2).join(' '),
                    style: TextStyle(fontSize: fontSize),
                  ),
              ],
            ),
          ),
          SizedBox(height: 50),
        ]
      ),
    ),
  );
}
