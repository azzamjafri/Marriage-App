import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marriage/Navigation/navBar.dart';
import 'package:marriage/Registration/upload_pictures.dart';

import '../main.dart';

String gender="Select Your Gender";

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final formKey=GlobalKey<FormState>();
  String firstName = "";
  String surname;
  String dob="Enter Your DOB";
  String height;
  String caste;
  String complexion;
  String jobStatus;
  String address;
  String monthlyIncome;
  String fatherName;
  String expressYourself;
  String weight;
  String placeOfBirth;
  String educationStatus;
  String fatherOccupation;
  String annualIncomeValue;
  String personType;
  List<String> annualIncome=[
    "Less than 1 Lakh",
    "1-15 Lakhs",
    "16-30 Lakhs",
    "30-50 Lakhs",
    "Above 50 Lakhs"
  ];
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getBottom(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Tell Us About Yourself",style: TextStyle(color: Colors.black),),
      ),
      body:(loading)?CircularProgressIndicator(backgroundColor: Colors.green,):SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10,),
             getText("Hi, My First Name is"),
              getField("Enter Your First Name"),
              getText("My Surname is"),
              getField("Enter Your Surname"),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Text(
                  'I am',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              ListTile(
                title: Text(gender),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertAge();
                      }).then((value) {
                    setState(() {});
                  });
                },
                trailing: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
              getText("I am"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 40,
                  child: DropdownButton(
                    hint: Text("Select Type"),
                    value: personType,
                    onChanged: (val){
                      setState(() {
                        personType=val;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text("Unmarried"),
                        value: "unmarried",
                      ),
                      DropdownMenuItem(
                        child: Text("Divorcee"),
                        value: "divorcee",
                      )
                    ]
                  ),
                ),
              ),
              getText("My Height is"),
              getField("Enter Your Height"),
              getText("I am Born on"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {
                          return Container(
                            height: MediaQuery.of(context).copyWith().size.height / 3,
                            child: getDob(),
                          );
                        });
                  },
                  child: Container(
                    height: 30,
                    child: Center(child: Text(dob)),
                  ),
                )
              ),
              getText("I belong to"),
              getField("Enter Your Caste"),
              getText("My Complexion is"),
              getField("Enter Your Complexion"),
              getText("My Monthly Income is"),
              getField("Enter Your Income"),
              getText("My Job Status is"),
              getField("Enter Job Status"),
              getText("My Father Name is"),
              getField("Enter Your Father's Name"),
              getText("My Education is"),
              getField("Enter Education Status"),
              getText("My Place of Birth is"),
              getField("Enter Place of Birth"),
              getText("My Weight is"),
              getField("Enter Your Weight"),
              getText("My Annual Income is"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 40,
                  child: DropdownButton(
                    hint: Text("Select Annual Income Range"),
                    value: annualIncomeValue,
                    onChanged: (val){
                      setState(() {
                        annualIncomeValue=val;
                      });
                    },
                    items: annualIncome.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }
                    ).toList(),
                  ),
                ),
              ),
              getText("I Live in"),
              getField("Enter Your Address"),
              getText("My Fathers Occupation is"),
              getField("Enter Fathers Occupation"),
              getText("Express Yourself"),
              getField("Write about Yourself")

            ],
          ),
        ),
      ),
    );
  }

  getText(String field){
    return   Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 15),
      child: Text(
        field,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  getField(String data){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return ' Required';
          } else
            return null;
        },
        onChanged: (value) {
          if(data=="Enter Your First Name"){
            firstName=value;
          }
          if(data=="Enter Your Surname"){
            surname=value;
          }
          if(data=="Enter Your Height"){
            height=value;
          }
          if(data=="Enter Your Caste"){
            caste=value;
          }
          if(data=="Enter Your Complexion"){
            complexion=value;
          }if(data=="Enter Your Income"){
            monthlyIncome=value;
          }
          if(data=="Enter Job Status"){
            jobStatus=value;
          }
          if(data=="Enter Education Status"){
            educationStatus=value;
          }
          if(data=="Enter Your Weight"){
            weight=value;
          }
          if(data=="Enter Your Address"){
            address=value;
          }
          if(data=="Enter Fathers Occupation"){
            fatherOccupation=value;
          }
          if(data=="Enter Place of Birth"){
            placeOfBirth=value;
          }
          if(data=="Write about Yourself"){
            expressYourself=value;
          }
          if(data=="Enter Your Father's Name"){
            fatherName=value;
          }

        },
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
        ),
        cursorColor: Colors.green,
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: data,
            hintStyle: TextStyle(
              color: Colors.grey[300],
              fontSize: 20,
            )),
      ),
    );
  }

  getBottom() {
    return GestureDetector(
      onTap: ()async{
        uploadData();
      },
      child: Container(
        color: Colors.green,
        height: 50,
        child: Center(child: Text("Continue",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
      ),
    );
  }

  getDob() {
    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      onDateTimeChanged: (val){
        setState(() {
          dob=val.day.toString()+"/"+val.month.toString()+"/"+val.year.toString();
          print(dob);
        });
      },
    );
  }

   uploadData() async{
    if(formKey.currentState.validate()){
      //var user=await FirebaseAuth.instance.currentUser();
      var data={
        "firstName":firstName,
        "surname":surname,
        "gender":gender,
        "personType":personType,
        "height":height,
        "dob":dob,
        "caste":caste,
        "complexion":complexion,
        "monthlyIncome":monthlyIncome,
        "jobStatus":jobStatus,
        "fatherName":fatherName,
        "educationStatus":educationStatus,
        "placeOfBirth":placeOfBirth,
        "weight":weight,
        "annualIncome":annualIncomeValue,
        "fatherOccupation":fatherOccupation,
        "expressyourself":expressYourself,
      };
      Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPictures(map: data,)));

    }

   }
}

class AlertAge extends StatefulWidget {
  @override
  _AlertAgeState createState() => _AlertAgeState();
}

class _AlertAgeState extends State<AlertAge> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "I am",
        style: TextStyle(color: Colors.green),
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: MediaQuery.of(context).size.height / 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(color: Colors.black),
            RadioListTile(
              value: "Male",
              groupValue: gender,
              onChanged: (val) {
                setState(() {
                   gender= val;
                  print(gender);
                });
              },
              title: Text("Male"),
              activeColor: Colors.green,
            ),
            RadioListTile(
              activeColor: Colors.green,
              value: "Female",
              groupValue: gender,
              onChanged: (val) {
                setState(() {
                  gender = val;
                  print(gender);
                });
              },
              title: Text("Female"),
            )
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          width: 2 * MediaQuery.of(context).size.width / 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                onPressed: () {},
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              RaisedButton(
                color: Colors.green,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


}
