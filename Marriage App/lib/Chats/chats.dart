import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marriage/Chats/accepted_chats.dart';
import 'package:marriage/Chats/pending_requests.dart';
import 'package:marriage/Chats/requested_chats.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        
        child: getTabBar(),
      ),
      body: getBody(),
    );
  }

  getTabBar() {
    return Column(
      children: [
        // SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, right: 10.0, left: 8.0, bottom: 4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Chats', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: 1.1, 
                fontSize: 24.0)),
              ),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon( Icons.search,  color: Colors.black,))
            ],
          ),
        ),
        Container(
          color: Colors.grey[200],
          child: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.green,
            tabs: [
              new Tab(
                child: Text(
                  'Accepted',
                ),
              ),
              new Tab(
                child: Text('New Request'),
              ),
              new Tab(
                child: Text('Pending'),
              ),
            ],
            controller: tabController,
            indicatorColor: Colors.green,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
      ],
    );
  }

  getBody() {
    return TabBarView(
      controller: tabController,
      children: [
        new AcceptedChats(),
        new RequestedChats(),
        new PendingRequestChats(),
      ],
    );
  }
}
