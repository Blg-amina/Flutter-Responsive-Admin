import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:admin/responsive.dart';
import '../../../constants.dart';

class SalesChart extends StatelessWidget {
  const SalesChart({Key? key}) : super(key: key);

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
              Text(
                "Ventes Hebdomadaires",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      size: 16,
                      color: primaryColor,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "+12.5%",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            height: 280,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1000,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: isDark 
                          ? darkDividerColor.withValues(alpha: 0.3)
                          : dividerColor.withValues(alpha: 0.5),
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
                        if (value.toInt() >= 0 && value.toInt() < days.length) {
                          return Text(
                            days[value.toInt()],
                            style: TextStyle(
                              color: isDark ? darkTextSecondary : textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }
                        return Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1000,
                      reservedSize: 45,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${(value / 1000).toStringAsFixed(0)}k',
                          style: TextStyle(
                            color: isDark ? darkTextSecondary : textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 5000,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 2500),
                      FlSpot(1, 3200),
                      FlSpot(2, 2800),
                      FlSpot(3, 4100),
                      FlSpot(4, 3500),
                      FlSpot(5, 4800),
                      FlSpot(6, 4200),
                    ],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        primaryDarkColor,
                        primaryColor,
                        primaryLightColor,
                      ],
                    ),
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 5,
                          color: primaryColor,
                          strokeWidth: 3,
                          strokeColor: isDark ? darkSecondaryColor : secondaryColor,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          primaryColor.withValues(alpha: 0.4),
                          primaryLightColor.withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RevenuePieChart extends StatelessWidget {
  const RevenuePieChart({Key? key}) : super(key: key);

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
          Text(
            "Revenus par Catégorie",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            height: Responsive.isSmallMobile(context) ? 180 : 220,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: Responsive.isSmallMobile(context) ? 40 : 55,
                    sections: [
                      PieChartSectionData(
                        color: cardColor1,
                        value: 35,
                        showTitle: false,
                        radius: Responsive.isSmallMobile(context) ? 20 : 28,
                      ),
                      PieChartSectionData(
                        color: cardColor2,
                        value: 25,
                        showTitle: false,
                        radius: Responsive.isSmallMobile(context) ? 18 : 25,
                      ),
                      PieChartSectionData(
                        color: cardColor3,
                        value: 20,
                        showTitle: false,
                        radius: Responsive.isSmallMobile(context) ? 16 : 22,
                      ),
                      PieChartSectionData(
                        color: infoColor,
                        value: 15,
                        showTitle: false,
                        radius: Responsive.isSmallMobile(context) ? 14 : 19,
                      ),
                      PieChartSectionData(
                        color: Colors.cyan,
                        value: 5,
                        showTitle: false,
                        radius: Responsive.isSmallMobile(context) ? 12 : 16,
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "100%",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: isDark ? darkTextPrimary : textPrimary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                              fontSize: Responsive.isSmallMobile(context) ? 18 : null,
                            ),
                      ),
                      Text(
                        "Total",
                        style: TextStyle(
                          color: isDark ? darkTextSecondary : textSecondary,
                          fontSize: Responsive.isSmallMobile(context) ? 10 : 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: defaultPadding),
          _buildLegend(context, 'Légumes', cardColor1, '35%', isDark),
          _buildLegend(context, 'Fruits', cardColor2, '25%', isDark),
          _buildLegend(context, 'Viandes', cardColor3, '20%', isDark),
          _buildLegend(context, 'Laitiers', infoColor, '15%', isDark),
          _buildLegend(context, 'Autres', Colors.cyan, '5%', isDark),
        ],
      ),
    );
  }

  Widget _buildLegend(BuildContext context, String label, Color color, String percentage, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: Responsive.isSmallMobile(context) ? 12 : 14,
            height: Responsive.isSmallMobile(context) ? 12 : 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isDark ? darkTextSecondary : textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: Responsive.isSmallMobile(context) ? 11 : 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            percentage,
            style: TextStyle(
              color: isDark ? darkTextPrimary : textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: Responsive.isSmallMobile(context) ? 11 : 13,
            ),
          ),
        ],
      ),
    );
  }
}
