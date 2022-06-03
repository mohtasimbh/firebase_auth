import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:traval/const/appstyle.dart';
import 'package:traval/ui/login.dart';
import 'package:traval/ui/nav_bar/massage.dart';
import 'package:traval/ui/nav_bar/news_feed.dart';

import 'nav_bar/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => Login()));
  }

  int currentIndex = 0;
  final List<Widget> pages = [NewsFeed(), Profile()];
  final PageStorageBucket busket = PageStorageBucket();
  Widget currentScreen = NewsFeed();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: PageStorage(
          bucket: busket,
          child: currentScreen,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //_showBottomSheet(context);
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 10,
            child: Container(
              padding: EdgeInsets.all(5),
              color: Color(0xFF22292E),
              height: 60,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: [
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              setState(() {
                                currentScreen = NewsFeed();
                                currentIndex = 0;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.newspaper,
                                    color: currentIndex == 0
                                        ? Colors.white
                                        : Colors.grey),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "News Feed",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: currentIndex == 0
                                          ? Colors.white
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width:  MediaQuery.of(context).size.width / 3,),
                          MaterialButton(
                            minWidth: 40,
                            onPressed: () {
                              setState(() {
                                currentScreen = Profile();
                                currentIndex = 1;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person,
                                    color: currentIndex == 1
                                        ? Colors.white
                                        : Colors.grey),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Profile",
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: currentIndex == 1
                                          ? Colors.white
                                          : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]),
              ]),
            )));
  }
}
