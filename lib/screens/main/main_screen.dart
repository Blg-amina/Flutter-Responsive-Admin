import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: Responsive.isMobile(context) ? SideMenu() : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for desktop and tablet
            if (!Responsive.isMobile(context))
              Consumer<MenuAppController>(
                builder: (context, controller, child) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: controller.isMenuOpen
                        ? Responsive.isTablet(context) ? 240 : 280
                        : 0,
                    child: controller.isMenuOpen
                        ? SideMenu()
                        : SizedBox.shrink(),
                  );
                },
              ),
            Expanded(
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
