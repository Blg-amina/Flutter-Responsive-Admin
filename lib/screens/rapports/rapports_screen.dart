import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';

class RapportsScreen extends StatelessWidget {
  const RapportsScreen({Key? key}) : super(key: key);

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
            ReportStatsOverview(),
            SizedBox(height: defaultPadding),
            ReportCategories(),
          ],
        ),
      ),
    );
  }
}

class ReportStatsOverview extends StatelessWidget {
  const ReportStatsOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    int crossAxisCount = Responsive.isMobile(context) ? 2 : 4;

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: 1.4,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        final stats = reportStats[index];
        return ReportStatCard(
          title: stats['title'],
          value: stats['value'],
          icon: stats['icon'],
          color: stats['color'],
          isDark: isDark,
        );
      },
    );
  }
}

class ReportStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isDark;

  const ReportStatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(smallPadding),
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withValues(alpha: 0.15),
                      color.withValues(alpha: 0.08),
                    ],
                  ),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: (isDark ? darkSurfaceColor : surfaceColor)
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                ),
                child: Icon(
                  Icons.more_horiz,
                  color: isDark ? darkTextSecondary : textSecondary,
                  size: 18,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: isDark ? darkTextSecondary : textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: isDark ? darkTextPrimary : textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
          ),
        ],
      ),
    );
  }
}

class ReportCategories extends StatelessWidget {
  const ReportCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    int crossAxisCount = Responsive.isMobile(context) ? 1 : 2;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Catégories de Rapports",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          SizedBox(height: defaultPadding),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: 2.5,
            ),
            itemCount: reportCategories.length,
            itemBuilder: (context, index) {
              return ReportCategoryCard(
                category: reportCategories[index],
                isDark: isDark,
              );
            },
          ),
        ],
      ),
    );
  }
}

class ReportCategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final bool isDark;

  const ReportCategoryCard({
    Key? key,
    required this.category,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? darkBgColor : bgColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        border: Border.all(
          color: category['color'].withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: category['color'].withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              category['icon'],
              color: category['color'],
              size: 28,
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
                  maxLines: 2,
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

final List<Map<String, dynamic>> reportStats = [
  {
    'title': 'Rapports Générés',
    'value': '156',
    'icon': Icons.description,
    'color': primaryColor,
  },
  {
    'title': 'Ce Mois',
    'value': '24',
    'icon': Icons.calendar_today,
    'color': infoColor,
  },
  {
    'title': 'Téléchargements',
    'value': '89',
    'icon': Icons.download,
    'color': successColor,
  },
  {
    'title': 'Partagés',
    'value': '34',
    'icon': Icons.share,
    'color': accentColor,
  },
];

final List<Map<String, dynamic>> reportCategories = [
  {
    'title': 'Ventes & Revenus',
    'description': 'Analyse détaillée des ventes et revenus',
    'color': primaryColor,
    'icon': Icons.attach_money,
  },
  {
    'title': 'Inventaire',
    'description': 'État des stocks et mouvements',
    'color': successColor,
    'icon': Icons.inventory_2,
  },
  {
    'title': 'Clients',
    'description': 'Analyse du comportement des clients',
    'color': infoColor,
    'icon': Icons.people,
  },
  {
    'title': 'Livraisons',
    'description': 'Performance et délais de livraison',
    'color': warningColor,
    'icon': Icons.local_shipping,
  },
  {
    'title': 'Produits',
    'description': 'Meilleures ventes et tendances',
    'color': cardColor3,
    'icon': Icons.trending_up,
  },
  {
    'title': 'Financier',
    'description': 'Rapports comptables et fiscaux',
    'color': errorColor,
    'icon': Icons.account_balance,
  },
];
