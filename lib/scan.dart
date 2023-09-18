import 'package:flutter/material.dart';
import 'identities.dart';
import 'TestingFile.dart';

//Scan ID page widget class
class ScanPage extends StatefulWidget {
  //Allowing Scan ID page to change state with a new key
  const ScanPage({super.key});
  //CreateState() function to make buttons function to change state
  @override
  State<ScanPage> createState() => ScanPageState();
}

//Main Scan ID page class
class ScanPageState extends State<ScanPage> {
  //IdentityData List
  List<Identity> identities = identityData;   //Stores Identity data

  //Build() method that builds the Scan ID page
  @override
  Widget build(BuildContext context) {
    //Gets the screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //Card scroll width and height
    double cardScrollWidth = screenWidth * 0.9;
    double cardScrollHeight = screenHeight * 0.81;    //Size: 650
    //ID card height
    double idCardHeight = screenHeight * 0.73;
    double fontHeight = screenHeight * 0.47;          //Height: 335

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    if (identities.isEmpty)
                      Container(
                        width: cardScrollWidth,             //Width of Container()
                        height: cardScrollHeight,           //Height of Container()
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 1,                     //List count
                          itemBuilder: (context, index) {   //List builder
                            return identityErrorCard(context, cardScrollWidth, idCardHeight,
                                Icons.no_accounts_outlined, 100, Colors.red, "No Identity",
                                fontHeight * 0.0597);      //Size: 20
                          }
                        ),
                      )
                    else
                      Container(
                        width: cardScrollWidth,                                 //Width of Container()  Size: 400
                        height: cardScrollHeight,                               //Height of Container() Size: 467
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,                       //ListView scroll direction
                          itemCount: identities.length,                         //List count
                          itemBuilder: (context, index) {                       //List builder
                            Identity identity = identities[index];              //Gets 1 Identity item from identities List
                            if (identity.isVerified == true){
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: InkWell(
                                  //Scan card functionality
                                  onTap:(){
                                    showTestActivityMenu(screenWidth, screenHeight, setState, context, identity, index);
                                  },
                                  child: Container(
                                    width: cardScrollWidth,                       //Width of Container()
                                    height: idCardHeight,                         //Height of Container()
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
                                      children: [
                                        //ID icon
                                        Icon(identity.icon, size: fontHeight * 0.24, color: identity.colour),    //Size: 80
                                        SizedBox(height: fontHeight * 0.024),   //Size: 8
                                        //First name and Surname in ID
                                        Text(
                                          identity.firstName + " " + identity.surName,
                                          style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.084),   //Size: 28
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            //Age in ID
                                            Text(
                                              "Age: " + identity.age.toString(),
                                              style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.072),   //Size: 24
                                            ),
                                            SizedBox(width: fontHeight * 0.015),   //Size: 5
                                            //ID verification icon
                                            Icon(identity.isVerified ? Icons.verified_outlined : Icons.pending_outlined, size: fontHeight * 0.072,
                                              color: identity.isVerified ? Colors.green : Colors.blue
                                            ),    //Size: 24
                                          ]
                                        ),
                                        SizedBox(height: fontHeight * 0.0597),   //Size: 20
                                        //Generated QR code image
                                        Icon(Icons.qr_code_2_outlined, size: fontHeight * 0.388),    //Size: 130
                                        SizedBox(height: fontHeight * 0.0597),   //Size: 20
                                        Divider(height: 1, color: Colors.grey),   //Line divider
                                        SizedBox(height: fontHeight * 0.0597),   //Size: 20
                                        SingleChildScrollView(
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children:[
                                              //Date of Birth in ID
                                              Text(
                                                "DoB: " + identity.dob,
                                                style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.072),   //Size: 24
                                              ),
                                              //ID type
                                              Text (
                                                "ID: " + identity.type,
                                                style: TextStyle(color: Colors.black, fontSize: fontHeight * 0.072),   //Size: 24
                                              ),
                                            ]
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            else {
                              return identityErrorCard(context, cardScrollWidth, idCardHeight,
                                  Icons.pending_outlined, 100, Colors.blue,"Identity is pending",
                                  idCardHeight * 0.043);   //Size: 20
                            }
                          }
                        ),
                      ),
                  ]
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}