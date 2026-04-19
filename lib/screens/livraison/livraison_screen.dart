import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';

class LivraisonScreen extends StatelessWidget {
  const LivraisonScreen({Key? key}) : super(key: key);

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
            DeliveryStatsOverview(),
            SizedBox(height: defaultPadding),
            DeliveriesList(),
          ],
        ),
      ),
    );
  }
}

class DeliveryStatsOverview extends StatelessWidget {
  const DeliveryStatsOverview({Key? key}) : super(key: key);

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
        final stats = deliveryStats[index];
        return DeliveryStatCard(
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

class DeliveryStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isDark;

  const DeliveryStatCard({
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

class DeliveriesList extends StatelessWidget {
  const DeliveriesList({Key? key}) : super(key: key);

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
                "Livraisons en Cours",
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
                      "Nouvelle Livraison",
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
          ...List.generate(deliveries.length, (index) {
            return DeliveryItem(delivery: deliveries[index], isDark: isDark);
          }),
        ],
      ),
    );
  }
}

class DeliveryItem extends StatelessWidget {
  final Map<String, dynamic> delivery;
  final bool isDark;

  const DeliveryItem({
    Key? key,
    required this.delivery,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? darkBgColor : bgColor,
        borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        border: Border.all(
          color: isDark ? darkDividerColor : dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                    ),
                    child: Icon(Icons.local_shipping, color: primaryColor, size: 18),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        delivery['id'],
                        style: TextStyle(
                          color: isDark ? darkTextPrimary : textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        delivery['date'],
                        style: TextStyle(
                          color: isDark ? darkTextSecondary : textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(delivery['status']).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                ),
                child: Text(
                  delivery['status'],
                  style: TextStyle(
                    color: _getStatusColor(delivery['status']),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: isDark ? darkDividerColor : dividerColor),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Livreur',
                      style: TextStyle(
                        color: isDark ? darkTextSecondary : textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      delivery['driver'],
                      style: TextStyle(
                        color: isDark ? darkTextPrimary : textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Destination',
                      style: TextStyle(
                        color: isDark ? darkTextSecondary : textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      delivery['destination'],
                      style: TextStyle(
                        color: isDark ? darkTextPrimary : textPrimary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Frais',
                    style: TextStyle(
                      color: isDark ? darkTextSecondary : textSecondary,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '${delivery['fee']} DA',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'En attente':
        return warningColor;
      case 'En cours':
        return infoColor;
      case 'Livré':
        return successColor;
      case 'Retardé':
        return errorColor;
      default:
        return textSecondary;
    }
  }
}

final List<Map<String, dynamic>> deliveryStats = [
  {
    'title': 'Total Livraisons',
    'value': '892',
    'icon': Icons.local_shipping,
    'color': primaryColor,
  },
  {
    'title': 'En Cours',
    'value': '45',
    'icon': Icons.delivery_dining,
    'color': infoColor,
  },
  {
    'title': 'Livrées',
    'value': '823',
    'icon': Icons.check_circle,
    'color': successColor,
  },
  {
    'title': 'Retardées',
    'value': '24',
    'icon': Icons.access_time,
    'color': errorColor,
  },
];

final List<Map<String, dynamic>> deliveries = [
  {
    'id': '#LIV-001',
    'date': '15 Avr 2026',
    'driver': 'Yacine Brahimi',
    'destination': 'Alger Centre',
    'fee': '250.00',
    'status': 'En cours',
  },
  {
    'id': '#LIV-002',
    'date': '15 Avr 2026',
    'driver': 'Samira Hadji',
    'destination': 'Oran',
    'fee': '450.00',
    'status': 'En attente',
  },
  {
    'id': '#LIV-003',
    'date': '14 Avr 2026',
    'driver': 'Khaled Slimani',
    'destination': 'Constantine',
    'fee': '380.00',
    'status': 'Livré',
  },
  {
    'id': '#LIV-004',
    'date': '14 Avr 2026',
    'driver': 'Nadia Belkacem',
    'destination': 'Annaba',
    'fee': '320.00',
    'status': 'Retardé',
  },
  {
    'id': '#LIV-005',
    'date': '13 Avr 2026',
    'driver': 'Karim Mesbah',
    'destination': 'Blida',
    'fee': '180.00',
    'status': 'Livré',
  },
];
