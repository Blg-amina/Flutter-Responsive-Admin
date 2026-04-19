import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';

class ParametresScreen extends StatelessWidget {
  const ParametresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            ProfileSection(),
            SizedBox(height: defaultPadding),
            SettingsSections(),
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? darkSecondaryColor : secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        boxShadow: cardShadow,
        border: Border.all(
          color: isDark ? darkDividerColor : dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              "assets/images/profile_pic.jpg",
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hossam Kerroumi",
                  style: TextStyle(
                    color: isDark ? darkTextPrimary : textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Administrateur Principal",
                  style: TextStyle(
                    color: isDark ? darkTextSecondary : textSecondary,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primaryColor, primaryDarkColor],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                      ),
                      child: Text(
                        "Admin",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: successColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, color: successColor, size: 12),
                          SizedBox(width: 4),
                          Text(
                            "Vérifié",
                            style: TextStyle(
                              color: successColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (isDark ? darkSurfaceColor : surfaceColor)
                  .withValues(alpha: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
            ),
            child: Icon(
              Icons.edit,
              color: isDark ? darkTextPrimary : textPrimary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsSections extends StatelessWidget {
  const SettingsSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    int crossAxisCount = Responsive.isMobile(context) ? 1 : 2;

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: 2.2,
      ),
      itemCount: settingsCategories.length,
      itemBuilder: (context, index) {
        return SettingCategoryCard(
          category: settingsCategories[index],
          isDark: isDark,
        );
      },
    );
  }
}

class SettingCategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final bool isDark;

  const SettingCategoryCard({
    Key? key,
    required this.category,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? darkSecondaryColor : secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        boxShadow: cardShadow,
        border: Border.all(
          color: isDark ? darkDividerColor : dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: category['color'].withValues(alpha: 0.12),
              borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  category['color'].withValues(alpha: 0.15),
                  category['color'].withValues(alpha: 0.08),
                ],
              ),
            ),
            child: Icon(
              category['icon'],
              color: category['color'],
              size: 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category['title'],
                  style: TextStyle(
                    color: isDark ? darkTextPrimary : textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  category['description'],
                  style: TextStyle(
                    color: isDark ? darkTextSecondary : textSecondary,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: isDark ? darkTextSecondary : textSecondary,
            size: 16,
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> settingsCategories = [
  {
    'title': 'Compte',
    'description': 'Informations personnelles et sécurité',
    'color': primaryColor,
    'icon': Icons.person,
  },
  {
    'title': 'Notifications',
    'description': 'Préférences de notifications',
    'color': infoColor,
    'icon': Icons.notifications,
  },
  {
    'title': 'Apparence',
    'description': 'Thème et personnalisation',
    'color': cardColor3,
    'icon': Icons.palette,
  },
  {
    'title': 'Langue',
    'description': 'Choisir la langue de l\'interface',
    'color': accentColor,
    'icon': Icons.language,
  },
  {
    'title': 'Confidentialité',
    'description': 'Paramètres de confidentialité',
    'color': warningColor,
    'icon': Icons.security,
  },
  {
    'title': 'Aide & Support',
    'description': 'Centre d\'aide et contact',
    'color': successColor,
    'icon': Icons.help,
  },
  {
    'title': 'Sauvegarde',
    'description': 'Exporter et importer des données',
    'color': cardColor2,
    'icon': Icons.cloud_upload,
  },
  {
    'title': 'À Propos',
    'description': 'Informations sur l\'application',
    'color': textSecondary,
    'icon': Icons.info,
  },
];
