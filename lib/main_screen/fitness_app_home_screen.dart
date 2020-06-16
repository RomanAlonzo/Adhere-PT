
import 'file:///C:/Adhere_Test/adhere_pt/lib/main_screen/tabIcon_data.dart';
import 'file:///C:/Adhere_Test/adhere_pt/lib/main_screen/pages/exercises_screen.dart';
import 'file:///C:/Adhere_Test/adhere_pt/lib/main_screen/pages/profile_screen.dart';
import 'file:///C:/Adhere_Test/adhere_pt/lib/main_screen/pages/progress_screen.dart';
import 'file:///C:/Adhere_Test/adhere_pt/lib/main_screen/pages/stretches_screen.dart';
import 'package:flutter/material.dart';
import 'bottom_bar_view.dart';
import 'fintness_app_theme.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FintnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = ExercisesScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FintnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      ExercisesScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      StretchesScreen(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      ProgressScreen(title: 'Progress');
                });
              });
            }
            else if (index == 3) {
            animationController.reverse().then<dynamic>((data) {
              if (!mounted) {
                return;
              }
              setState(() {
                tabBody =
                  ProfileScreen(iconAnimationController: animationController);
              });
            });
            }
          },
        ),
      ],
    );
  }
}
