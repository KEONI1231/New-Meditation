import 'package:flutter/material.dart';

import '../Constant/color.dart';
import '../Constant/user.dart';
import 'DonggukContainer/timer_screen.dart';
import 'home_screen.dart';
import 'meditation_screen.dart';


class MainScreen extends StatefulWidget {
  loginUser user;
  MainScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: BRIGHT_COLOR,
          body: TabBarView(
            children: [
              HomeScreen(user: widget.user),
              TimerWidget(user: widget.user),
              MeditaionScreen(user: widget.user) //바꿔
            ],
          ),
          extendBodyBehindAppBar: true, // add this line
          bottomNavigationBar: Container(
            color: BRIGHT_COLOR, //색상
            child: Container(
              height: 60,
              padding: EdgeInsets.only(bottom: 10, top: 3),
              child: const TabBar(
                //tab 하단 indicator size -> .label = label의 길이
                //tab 하단 indicator size -> .tab = tab의 길이
                indicatorSize: TabBarIndicatorSize.label,
                //tab 하단 indicator color
                indicatorColor: Colors.black,
                //tab 하단 indicator weight
                indicatorWeight: 2,
                //label color
                labelColor: Colors.black,
                //unselected label color
                unselectedLabelColor: Colors.black38,
                labelStyle: TextStyle(
                  fontSize: 13,
                ),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.home,
                      size: 16,
                    ),
                    text: '홈',
                  ),
                  Tab(
                      icon: Icon(
                        Icons.timer_outlined,
                        size: 16,
                      ),
                      text: '타이머'),
                  Tab(
                    icon: Icon(
                      Icons.movie_outlined,
                      size: 16,
                    ),
                    text: '명상 영상',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
