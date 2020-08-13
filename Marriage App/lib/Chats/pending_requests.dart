import 'package:flutter/material.dart';

class PendingRequestChats extends StatefulWidget {
  @override
  _PendingRequestChatsState createState() => _PendingRequestChatsState();
}

class _PendingRequestChatsState extends State<PendingRequestChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: ListView(
        children: [
          for(int i=0; i<5; i++) getChatCard(),
        ],
      ),
    );
  }

  getChatCard() {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Samantha Smith",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              Spacer(),
              Text('26 Years | 5"4 feet '),
              GestureDetector(
                onTap: () {},
                              child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.green,
                      size: 15.0,
                    )),
              ),
                  Padding(padding: EdgeInsets.only(right: 5.0)),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Catholic Christian"),
                      Text("New York,USA"),
                      Text("UI UX Designer"),
                      Text("Computer Science")
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Image.asset("images/pic2.jpg",height: 100,width: 100,),
                        Image.asset("images/pic2.jpg",height: 100,width: 100,),
                        Image.asset("images/pic2.jpg",height: 100,width: 100,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 2,color: Colors.green)
                    ),
                    child: Center(child: Text("More Info",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),)),
                  ),
                ),
              ),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.green
                    ),
                    height: 30,
                    child: Center(child: Text("Pending Request",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),))),
              ))
            ],
          )
        ],
      ),
    );
  }
}
