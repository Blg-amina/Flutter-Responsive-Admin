import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? darkSecondaryColor : secondaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          /// ✅ HEADER (بدل DrawerHeader)
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

          /// ✅ CLEAN DIVIDER
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? darkDividerColor : dividerColor,
          ),

          const SizedBox(height: 10),

          /// ITEMS
          buildItem(0, "Dashboard", Icons.dashboard_outlined),
          buildItem(1, "Commandes", Icons.receipt_long_outlined),
          buildItem(2, "Produits", Icons.inventory_2_outlined),
          buildItem(3, "Catégories", Icons.category_outlined),
          buildItem(4, "Clients", Icons.people_outline),
          buildItem(5, "Livraison", Icons.local_shipping_outlined),
          buildItem(6, "Rapports", Icons.bar_chart_outlined),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),

          buildItem(7, "Paramètres", Icons.settings_outlined),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// ITEM
  Widget buildItem(int index, String title, IconData icon) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
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