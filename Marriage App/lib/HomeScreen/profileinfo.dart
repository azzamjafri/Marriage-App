import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  ProfileInfo({this.data});
  final DocumentSnapshot data;
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> with SingleTickerProviderStateMixin{
  TabController tabController;
  var profileInfo;
  List<dynamic> picURLS=List();
  @override
  void initState() {
    profileInfo=widget.data.data;
    for(String url in profileInfo['picURLS']){
      picURLS.add(NetworkImage(url));
    }
    tabController=TabController(length: 2,vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int currentselectedIndex = 0;
    Widget image_slider_carousel = Container(
      height: MediaQuery.of(context).size.height / 2,
      child: new Carousel(
        images:picURLS
        ),
      );

    return Scaffold(
      bottomNavigationBar: getBottom(),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              image_slider_carousel,
              Positioned(
                top: MediaQuery.of(context).size.height / 50,
                child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2.9,
                left: MediaQuery.of(context).size.width / 40,
                // child: Text("${profileInfo['firstName']} ${profileInfo['surname']}", style: TextStyle(fontSize: MediaQuery.of(context).size.height / 30,color: Colors.white, fontWeight: FontWeight.normal,),),
                child: Text("${profileInfo['firstName']}", style: TextStyle(fontSize: MediaQuery.of(context).size.height / 30,color: Colors.white, fontWeight: FontWeight.normal,),),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2.6,
                left: MediaQuery.of(context).size.width / 38,
                child: Text(
                  '${profileInfo['dob']} | ${profileInfo['height']}',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 60,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2.9,
                left: MediaQuery.of(context).size.width / 1.1,
                child: IconButton(
                    icon: Icon(
                      Icons.bookmark_border,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2,
                child: Container(
                  height: MediaQuery.of(context).size.height / 20,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[400],
                  child: TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        child: Text(
                          "Personal Info",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "More Info",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 1.8,
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      getInfo(),
                      getMoreInfo()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getBottom() {
    
    return Container(
      
            height: MediaQuery.of(context).size.height / 9,
            width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 18,
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
                onPressed: () {},
                child: Text(
                  "Connect Now",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(
                      color: Colors.green,
                    )),
                color: Colors.green),
          ),
          Container(
            
            height: MediaQuery.of(context).size.height / 18,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
            child: FlatButton(
              
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(
                      color: Colors.blueGrey,
                    )),
              onPressed: (){
                print('Tapped');
              },
              child: Text('Pay Rs. 39 and get phone number', style: TextStyle(color: Colors.green, fontSize: 16.5))),
          )
        ],
      ),
    );
  }

  getInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(profileInfo['expressyourself'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
             TableRow(
               children: [
                 getHeader("Caste"),
                 getValue(profileInfo['caste'])
               ]
             ),
              TableRow(
                  children: [
                    getHeader("Education"),
                    getValue(profileInfo['educationStatus'])
                  ]
              ),
              TableRow(
                  children: [
                    getHeader("Job Status"),
                    getValue(profileInfo['jobStatus'])
                  ]
              ),
              TableRow(
                  children: [
                    getHeader("Complexion"),
                    getValue(profileInfo['complexion'])
                  ]
              )
            ],
          ),
        )
      ],
    );
  }

  getMoreInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                  children: [
                    getHeader("Monthly Income"),
                    getValue(profileInfo['monthlyIncome'])
                  ]
              ),
              TableRow(
                  children: [
                    getHeader("Weight"),
                    getValue(profileInfo['weight'])
                  ]
              ),
              TableRow(
                  children: [
                    getHeader("Place Of Birth"),
                    getValue(profileInfo['placeOfBirth'])
                  ]
              ),
              TableRow(
                  children: [
                    getHeader("Father Name"),
                    getValue(profileInfo['fatherName'])
                  ]
              ),
              TableRow(
                  children: [
                    getHeader("Father Occupation"),
                    getValue(profileInfo['fatherOccupation'])
                  ]
              ),
              TableRow(
                  children: [
                    getHeader("Phone Number"),
                    getValue(profileInfo['phone'])
                  ]
              ),
              TableRow(
                  children: [
                    getHeader("Email ID"),
                    getValue(profileInfo['email'])
                  ]
              ),
            ],
          ),
        )
      ],
    );
  }

  getHeader(String s) {
    return Text(s,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 18),);
  }

  getValue(String s) {
    return Text(s,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 18),);
  }
}
