import 'package:admin/constants.dart';
import 'package:admin/models/grocery_models.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

class SalesStatsCard extends StatelessWidget {
  final SalesStats stats;
  final Color color;
  final IconData icon;

  const SalesStatsCard({
    Key? key,
    required this.stats,
    required this.color,
    required this.icon,
  }) : super(key: key);

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
            stats.period,
            style: TextStyle(
              color: isDark ? darkTextSecondary : textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          Flexible(
            child: Text(
              '${stats.revenue.toStringAsFixed(2)} DA',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: isDark ? darkTextPrimary : textPrimary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    fontSize: 20,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: smallPadding, vertical: 5),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 13,
                  color: color,
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '${stats.orders} cmd',
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.people_outline,
                  size: 13,
                  color: color,
                ),
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '${stats.customers}',
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatsOverview extends StatelessWidget {
  const StatsOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int crossAxisCount;
    double childAspectRatio;

    if (Responsive.isSmallMobile(context)) {
      crossAxisCount = 1;
      childAspectRatio = 1.5;
    } else if (Responsive.isMobile(context)) {
      crossAxisCount = 2;
      childAspectRatio = 1.4;
    } else if (Responsive.isTablet(context)) {
      crossAxisCount = 3;
      childAspectRatio = 1.35;
    } else {
      crossAxisCount = 3;
      childAspectRatio = 1.3;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Aperçu des Ventes",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
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
            childAspectRatio: childAspectRatio,
          ),
          itemCount: demoSalesStats.length,
          itemBuilder: (context, index) {
            final stats = demoSalesStats[index];
            Color color;
            IconData icon;

            switch (index) {
              case 0:
                color = cardColor1;
                icon = Icons.today_outlined;
                break;
              case 1:
                color = cardColor2;
                icon = Icons.date_range_outlined;
                break;
              case 2:
                color = cardColor3;
                icon = Icons.calendar_month_outlined;
                break;
              default:
                color = cardColor1;
                icon = Icons.attach_money;
            }

            return SalesStatsCard(
              stats: stats,
              color: color,
              icon: icon,
            );
          },
        ),
      ],
    );
  }
}
