import './controller/root_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'pages/home/home.dart';
import 'pages/history/history.dart';
import 'pages/setting/setting.dart';

class Root extends GetView<RootController> {
  Root({super.key});

  final _navigatorKeys = {
    '0': GlobalKey<NavigatorState>(),
    '1': GlobalKey<NavigatorState>(),
    '2': GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[controller.rootPageIndex.value.toString()]!
                .currentState!
                .maybePop();

        if (isFirstRouteInCurrentTab) {
          if (controller.rootPageIndex.value != 0) {
            controller.changeRootPageIndex(0);
            return false;
          }
        }

        /// 네비게이션 바의 첫번째 스크린인 경우, 앱 종료
        return isFirstRouteInCurrentTab;
      },
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.rootPageIndex.value,
            children: [
              Navigator(
                key: _navigatorKeys['0'],
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const Home(),
                  );
                },
              ),
              Navigator(
                key: _navigatorKeys['2'],
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const History(),
                  );
                },
              ),
              Navigator(
                key: _navigatorKeys['1'],
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const Setting(),
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.rootPageIndex.value,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: controller.changeRootPageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                label: 'home',
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  color: Colors.grey,
                ),
                label: 'history',
                activeIcon: Icon(
                  Icons.history,
                  color: Colors.blue,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                label: 'setting',
                activeIcon: Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
