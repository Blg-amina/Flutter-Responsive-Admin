import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';

class CommandesScreen extends StatelessWidget {
  const CommandesScreen({Key? key}) : super(key: key);

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
            OrderStatsOverview(),
            SizedBox(height: defaultPadding),
            OrdersList(),
          ],
        ),
      ),
    );
  }
}

class OrderStatsOverview extends StatelessWidget {
  const OrderStatsOverview({Key? key}) : super(key: key);

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
        final stats = orderStats[index];
        return OrderStatCard(
          title: stats['title'],
          value: stats['value'],
          icon: stats['icon'],
          color: stats['color'],
          change: stats['change'],
          isDark: isDark,
        );
      },
    );
  }
}

class OrderStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String change;
  final bool isDark;

  const OrderStatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.change,
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
          SizedBox(height: 8),
          Row(
            children: [
              Icon(
                change.contains('+') ? Icons.trending_up : Icons.trending_down,
                size: 14,
                color: change.contains('+') ? successColor : errorColor,
              ),
              SizedBox(width: 4),
              Text(
                change,
                style: TextStyle(
                  color: change.contains('+') ? successColor : errorColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

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
                "Commandes Récentes",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              InkWell(
                onTap: () => _showAddOrderDialog(context, isDark),
                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                child: Container(
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
                        "Nouvelle Commande",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          ...List.generate(orders.length, (index) {
            return OrderItem(order: orders[index], isDark: isDark);
          }),
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Map<String, dynamic> order;
  final bool isDark;

  const OrderItem({
    Key? key,
    required this.order,
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
                    child: Icon(Icons.receipt_long, color: primaryColor, size: 18),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['id'],
                        style: TextStyle(
                          color: isDark ? darkTextPrimary : textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        order['date'],
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
                  color: _getStatusColor(order['status']).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                ),
                child: Text(
                  order['status'],
                  style: TextStyle(
                    color: _getStatusColor(order['status']),
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
                child: Text(
                  order['customer'],
                  style: TextStyle(
                    color: isDark ? darkTextPrimary : textPrimary,
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Text(
                '${order['total']} DA',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
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
      case 'Confirmée':
        return successColor;
      case 'Livraison':
        return infoColor;
      case 'Annulée':
        return errorColor;
      default:
        return textSecondary;
    }
  }
}

void _showAddOrderDialog(BuildContext context, bool isDark) {
  final TextEditingController clientController = TextEditingController();
  final TextEditingController totalController = TextEditingController();
  String selectedStatus = 'En attente';

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        backgroundColor: isDark ? darkSecondaryColor : secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        title: Text(
          'Nouvelle Commande',
          style: TextStyle(
            color: isDark ? darkTextPrimary : textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Client',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: clientController,
                decoration: InputDecoration(
                  hintText: 'Nom du client',
                  hintStyle: TextStyle(
                    color: isDark ? darkTextSecondary : textSecondary,
                  ),
                  filled: true,
                  fillColor: isDark ? darkBgColor : bgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  color: isDark ? darkTextPrimary : textPrimary,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Total (DA)',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: totalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    color: isDark ? darkTextSecondary : textSecondary,
                  ),
                  filled: true,
                  fillColor: isDark ? darkBgColor : bgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  color: isDark ? darkTextPrimary : textPrimary,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Statut',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: selectedStatus,
                dropdownColor: isDark ? darkSecondaryColor : secondaryColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark ? darkBgColor : bgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  color: isDark ? darkTextPrimary : textPrimary,
                ),
                items: ['En attente', 'Confirmée', 'Livraison', 'Annulée']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedStatus = value!);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: TextStyle(
                color: isDark ? darkTextSecondary : textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Commande créée avec succès'),
                  backgroundColor: successColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
              ),
            ),
            child: Text('Créer'),
          ),
        ],
      ),
    ),
  );
}

final List<Map<String, dynamic>> orderStats = [
  {
    'title': 'Total Commandes',
    'value': '1,234',
    'icon': Icons.shopping_cart,
    'color': primaryColor,
    'change': '+12.5%',
  },
  {
    'title': 'En Attente',
    'value': '45',
    'icon': Icons.pending,
    'color': warningColor,
    'change': '-5.2%',
  },
  {
    'title': 'Confirmées',
    'value': '892',
    'icon': Icons.check_circle,
    'color': successColor,
    'change': '+18.3%',
  },
  {
    'title': 'Annulées',
    'value': '23',
    'icon': Icons.cancel,
    'color': errorColor,
    'change': '-2.1%',
  },
];

final List<Map<String, dynamic>> orders = [
  {
    'id': '#CMD-001',
    'date': '15 Avr 2026',
    'customer': 'Ahmed Benali',
    'total': '2,450.00',
    'status': 'Confirmée',
  },
  {
    'id': '#CMD-002',
    'date': '15 Avr 2026',
    'customer': 'Fatima Zahra',
    'total': '1,890.50',
    'status': 'En attente',
  },
  {
    'id': '#CMD-003',
    'date': '14 Avr 2026',
    'customer': 'Mohamed Kadi',
    'total': '3,200.00',
    'status': 'Livraison',
  },
  {
    'id': '#CMD-004',
    'date': '14 Avr 2026',
    'customer': 'Amina Boudiaf',
    'total': '980.00',
    'status': 'Annulée',
  },
  {
    'id': '#CMD-005',
    'date': '13 Avr 2026',
    'customer': 'Karim Hadj',
    'total': '4,150.75',
    'status': 'Confirmée',
  },
];
