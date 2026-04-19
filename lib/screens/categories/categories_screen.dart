import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

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
            CategoryStatsOverview(),
            SizedBox(height: defaultPadding),
            CategoriesGrid(),
          ],
        ),
      ),
    );
  }
}

class CategoryStatsOverview extends StatelessWidget {
  const CategoryStatsOverview({Key? key}) : super(key: key);

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
        final stats = categoryStats[index];
        return CategoryStatCard(
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

class CategoryStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isDark;

  const CategoryStatCard({
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

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    int crossAxisCount = Responsive.isMobile(context) ? 2 : (Responsive.isTablet(context) ? 3 : 4);

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
              Text(
                "Toutes les Catégories",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryDarkColor],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                  boxShadow: buttonShadow,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text(
                      "Ajouter Catégorie",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: 1.1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: categories[index], isDark: isDark);
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Map<String, dynamic> category;
  final bool isDark;

  const CategoryCard({
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: category['color'].withValues(alpha: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                  image: category['image'] != null && category['image'].startsWith('http')
                      ? DecorationImage(
                          image: NetworkImage(category['image']),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {},
                        )
                      : null,
                ),
                child: category['image'] == null || !category['image'].startsWith('http')
                    ? Center(
                        child: Icon(
                          category['icon'],
                          color: category['color'],
                          size: 32,
                        ),
                      )
                    : null,
              ),
              if (category['isPopular'] == true)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [accentColor, Colors.orange],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                      boxShadow: buttonShadow,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.local_fire_department, color: Colors.white, size: 10),
                        SizedBox(width: 3),
                        Text(
                          'Pop',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            category['name'],
            style: TextStyle(
              color: isDark ? darkTextPrimary : textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          Text(
            '${category['productCount']} produits',
            style: TextStyle(
              color: isDark ? darkTextSecondary : textSecondary,
              fontSize: 11,
            ),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: category['color'].withValues(alpha: 0.1),
              borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
            ),
            child: Text(
              'Actif',
              style: TextStyle(
                color: category['color'],
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> categoryStats = [
  {
    'title': 'Total Catégories',
    'value': '24',
    'icon': Icons.category,
    'color': primaryColor,
  },
  {
    'title': 'Actives',
    'value': '20',
    'icon': Icons.check_circle,
    'color': successColor,
  },
  {
    'title': 'Inactives',
    'value': '4',
    'icon': Icons.pause_circle,
    'color': warningColor,
  },
  {
    'title': 'Vides',
    'value': '2',
    'icon': Icons.remove_circle,
    'color': errorColor,
  },
];

final List<Map<String, dynamic>> categories = [
  {
    'name': 'Épicerie',
    'productCount': 456,
    'color': primaryColor,
    'icon': Icons.storefront,
    'image': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400',
    'isPopular': true,
  },
  {
    'name': 'Produits Laitiers',
    'productCount': 234,
    'color': successColor,
    'icon': Icons.egg,
    'image': 'https://images.unsplash.com/photo-1628088062854-d1870b4553da?w=400',
    'isPopular': false,
  },
  {
    'name': 'Boulangerie',
    'productCount': 189,
    'color': accentColor,
    'icon': Icons.bakery_dining,
    'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
    'isPopular': true,
  },
  {
    'name': 'Fruits & Légumes',
    'productCount': 312,
    'color': cardColor3,
    'icon': Icons.eco,
    'image': 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=400',
    'isPopular': true,
  },
  {
    'name': 'Viandes',
    'productCount': 156,
    'color': errorColor,
    'icon': Icons.set_meal,
    'image': 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=400',
    'isPopular': false,
  },
  {
    'name': 'Boissons',
    'productCount': 278,
    'color': infoColor,
    'icon': Icons.local_drink,
    'image': 'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=400',
    'isPopular': true,
  },
  {
    'name': 'Fruits Secs',
    'productCount': 145,
    'color': warningColor,
    'icon': Icons.restaurant,
    'image': 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=400',
    'isPopular': false,
  },
  {
    'name': 'Céréales',
    'productCount': 98,
    'color': cardColor2,
    'icon': Icons.grain,
    'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400',
    'isPopular': true,
  },
];
