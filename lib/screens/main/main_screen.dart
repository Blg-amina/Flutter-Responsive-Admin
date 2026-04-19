import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/categories/categories_screen.dart';
import 'package:admin/screens/clients/clients_screen.dart';
import 'package:admin/screens/commandes/commandes_screen.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/livraison/livraison_screen.dart';
import 'package:admin/screens/parametres/parametres_screen.dart';
import 'package:admin/screens/produits/produits_screen.dart';
import 'package:admin/screens/rapports/rapports_screen.dart';
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
              child: Consumer<MenuAppController>(
                builder: (context, controller, child) {
                  Widget selectedScreen;
                  switch (controller.selectedIndex) {
                    case 0:
                      selectedScreen = DashboardScreen();
                      break;
                    case 1:
                      selectedScreen = CommandesScreen();
                      break;
                    case 2:
                      selectedScreen = ProduitsScreen();
                      break;
                    case 3:
                      selectedScreen = CategoriesScreen();
                      break;
                    case 4:
                      selectedScreen = ClientsScreen();
                      break;
                    case 5:
                      selectedScreen = LivraisonScreen();
                      break;
                    case 6:
                      selectedScreen = RapportsScreen();
                      break;
                    case 7:
                      selectedScreen = ParametresScreen();
                      break;
                    default:
                      selectedScreen = DashboardScreen();
                  }
                  return selectedScreen;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
