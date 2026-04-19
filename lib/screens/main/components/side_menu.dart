import 'package:admin/constants.dart';
import 'package:admin/controllers/menu_app_controller.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? darkSecondaryColor : secondaryColor,
      child: Consumer<MenuAppController>(
        builder: (context, controller, child) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [

              
              Container(
                padding: const EdgeInsets.symmetric(vertical: 28),
                color: isDark ? darkSecondaryColor : secondaryColor,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryDarkColor],
                        ),
                        borderRadius: BorderRadius.circular(largeRadius),
                        boxShadow: buttonShadow,
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        size: 36,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 14),

                    Text(
                      "FulfillMarket",
                      style: TextStyle(
                        color: isDark ? darkTextPrimary : textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Admin Dashboard",
                      style: TextStyle(
                        color: isDark ? darkTextSecondary : textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

             
              Divider(
                height: 1,
                thickness: 1,
                color: isDark ? darkDividerColor : dividerColor,
              ),

              const SizedBox(height: 10),

              /// ITEMS
              buildItem(context, controller, 0, "Dashboard", Icons.dashboard_outlined),
              buildItem(context, controller, 1, "Commandes", Icons.receipt_long_outlined),
              buildItem(context, controller, 2, "Produits", Icons.inventory_2_outlined),
              buildItem(context, controller, 3, "Catégories", Icons.category_outlined),
              buildItem(context, controller, 4, "Clients", Icons.people_outline),
              buildItem(context, controller, 5, "Livraison", Icons.local_shipping_outlined),
              buildItem(context, controller, 6, "Rapports", Icons.bar_chart_outlined),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                height: 1,
                thickness: 1,
                color: isDark ? darkDividerColor : dividerColor,
              ),
              ),

              buildItem(context, controller, 7, "Paramètres", Icons.settings_outlined),

              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  /// ITEM
  Widget buildItem(BuildContext context, MenuAppController controller, int index, String title, IconData icon) {
    final isSelected = controller.selectedIndex == index;

    return GestureDetector(
      onTap: () {
        controller.setSelectedIndex(index);
        if (Responsive.isMobile(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryDarkColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : textSecondary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}