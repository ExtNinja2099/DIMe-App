import 'package:flutter/material.dart';
import 'identities.dart';

//Main Account page class
class AccountPage extends StatelessWidget {
  //IdentityData List
  List<Identity> identities = identityData;   //Stores Identity data

  //inputTitle() method
  //Returns a Row() of the title text
  Row inputTitle(double width, String text, double fontSize){
    return Row(
      children: [
        SizedBox(width: width),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
        ),
      ]
    );
  }

  //inputCard() method
  //Returns a card Container() that holds inputted text by the user
  Card inputCard(double shadow, double width, String input, double fontSize){
    return Card(
      elevation: shadow,              //Card shadow effect with elevation value
      margin: EdgeInsets.all(8),
      child: Container(
        width: width,                 //Width of Container()
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            //Input card information
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    input,
                    style: TextStyle(fontSize: fontSize),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Build() method that builds the Account page
  @override
  Widget build(BuildContext context) {
    //Gets the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //Card width and height
    double cardWidth = screenWidth * 0.86;
    double cardHeight = (screenHeight * 0.8) * 0.986;
    double fontHeight = screenHeight * 0.47;    //Height: 335

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (identities.isEmpty)
                      Container(
                        width: cardWidth,                   //Width of Container()  Size: 400
                        height: cardHeight,                 //Height of Container() Size: 500
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 1,                     //List count
                          itemBuilder: (context, index) {   //List builder
                            return identityErrorCard(context, cardWidth, cardHeight * 0.969,
                                Icons.no_accounts_outlined, 100, Colors.red, "No identity",
                                fontHeight * 0.0597);   //Size: 20
                          }
                        ),
                      )
                    else
                      Container(
                        width: cardWidth,                             //Width of Container()  Size: 400
                        height: cardHeight,                           //Height of Container() Size: 500
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
                        //Account Info section information
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 15),
                                //Account icon
                                Icon(identities[0].icon, size: fontHeight * 0.24, color: Colors.black),    //Size: 80
                                SizedBox(height: fontHeight * 0.024),   //Size: 8
                                //First name and Surname of user
                                Text(
                                  identities[0].firstName + " " + identities[0].surName,
                                  style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.0597),   //Size: 20
                                ),
                                SizedBox(height: fontHeight * 0.024),   //Size: 8
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Age in ID
                                    Text(
                                      "Age: " + identities[0].age.toString(),
                                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.0597),   //Size: 20
                                    ),
                                    SizedBox(width: fontHeight * 0.015),   //Size: 5
                                    //ID verification icon
                                    Icon(identities[0].isVerified ? Icons.verified_outlined : Icons.pending_outlined, size: cardHeight * 0.048,
                                      color: identities[0].isVerified ? Colors.green : Colors.blue,
                                    ),    //Size: 24
                                  ]
                                ),
                                SizedBox(height: fontHeight * 0.0298),    //Size: 10
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Date of Birth in ID
                                    Text(
                                      "DoB: " + identities[0].dob,
                                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.0597),   //Size: 20
                                    ),
                                  ]
                                ),
                                SizedBox(height: fontHeight * 0.0298),    //Size: 10
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Date of Birth in ID
                                    Text(
                                      "Phone: " + identities[0].phoneNum,
                                      style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.0597),   //Size: 20
                                    ),
                                  ]
                                ),
                                //Email input section
                                SizedBox(height: fontHeight * 0.0597),    //Size: 20
                                inputTitle(90, 'Email:', fontHeight * 0.048),      //Size: 16
                                inputCard(6, cardWidth * 0.61, identities[0].email, fontHeight * 0.048),       //Size: 16
                                //Country input section
                                SizedBox(height: fontHeight * 0.0597),    //Size: 20
                                inputTitle(90, 'Country:', cardHeight * 0.0278),    //Size: 16
                                inputCard(6, cardWidth * 0.61, identities[0].country, fontHeight * 0.048),     //Size: 16
                                //Language input section
                                SizedBox(height: fontHeight * 0.0597),    //Size: 20
                                inputTitle(90, 'Language:', cardHeight * 0.0278),   //Size: 16
                                inputCard(6, cardWidth * 0.61, identities[0].language, fontHeight * 0.048),    //Size: 16
                                SizedBox(height: fontHeight * 0.0597),    //Size: 20
                              ]
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}