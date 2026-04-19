import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

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
            ClientStatsOverview(),
            SizedBox(height: defaultPadding),
            ClientsList(),
          ],
        ),
      ),
    );
  }
}

class ClientStatsOverview extends StatelessWidget {
  const ClientStatsOverview({Key? key}) : super(key: key);

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
        final stats = clientStats[index];
        return ClientStatCard(
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

class ClientStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String change;
  final bool isDark;

  const ClientStatCard({
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

class ClientsList extends StatelessWidget {
  const ClientsList({Key? key}) : super(key: key);

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
                "Clients Récents",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              InkWell(
                onTap: () => _showAddClientDialog(context, isDark),
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
                        "Nouveau Client",
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
          ...List.generate(clients.length, (index) {
            return ClientItem(client: clients[index], isDark: isDark);
          }),
        ],
      ),
    );
  }
}

class ClientItem extends StatelessWidget {
  final Map<String, dynamic> client;
  final bool isDark;

  const ClientItem({
    Key? key,
    required this.client,
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person, color: primaryColor, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  client['name'],
                  style: TextStyle(
                    color: isDark ? darkTextPrimary : textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  client['email'],
                  style: TextStyle(
                    color: isDark ? darkTextSecondary : textSecondary,
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  client['phone'],
                  style: TextStyle(
                    color: isDark ? darkTextSecondary : textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${client['orders']} commandes',
              style: TextStyle(
                color: isDark ? darkTextPrimary : textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
              SizedBox(height: 4),
              Text(
                '${client['totalSpent']} DA',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(client['status']).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                ),
                child: Text(
                  client['status'],
                  style: TextStyle(
                    color: _getStatusColor(client['status']),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
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
      case 'Actif':
        return successColor;
      case 'Inactif':
        return textSecondary;
      case 'VIP':
        return accentColor;
      case 'Bloqué':
        return errorColor;
      default:
        return textSecondary;
    }
  }
}

final List<Map<String, dynamic>> clientStats = [
  {
    'title': 'Total Clients',
    'value': '3,456',
    'icon': Icons.people,
    'color': primaryColor,
    'change': '+8.2%',
  },
  {
    'title': 'Actifs',
    'value': '2,890',
    'icon': Icons.how_to_reg,
    'color': successColor,
    'change': '+12.3%',
  },
  {
    'title': 'Nouveaux',
    'value': '234',
    'icon': Icons.person_add,
    'color': infoColor,
    'change': '+15.7%',
  },
  {
    'title': 'VIP',
    'value': '89',
    'icon': Icons.star,
    'color': accentColor,
    'change': '+5.1%',
  },
];

final List<Map<String, dynamic>> clients = [
  {
    'name': 'Ahmed Benali',
    'email': 'ahmed.benali@email.com',
    'phone': '+213 555 123 456',
    'orders': 24,
    'totalSpent': '45,230.00',
    'status': 'VIP',
  },
  {
    'name': 'Fatima Zahra',
    'email': 'fatima.zahra@email.com',
    'phone': '+213 555 234 567',
    'orders': 18,
    'totalSpent': '28,450.50',
    'status': 'Actif',
  },
  {
    'name': 'Mohamed Kadi',
    'email': 'mohamed.kadi@email.com',
    'phone': '+213 555 345 678',
    'orders': 12,
    'totalSpent': '15,890.00',
    'status': 'Actif',
  },
  {
    'name': 'Amina Boudiaf',
    'email': 'amina.boudiaf@email.com',
    'phone': '+213 555 456 789',
    'orders': 8,
    'totalSpent': '9,230.00',
    'status': 'Inactif',
  },
  {
    'name': 'Karim Hadj',
    'email': 'karim.hadj@email.com',
    'phone': '+213 555 567 890',
    'orders': 35,
    'totalSpent': '67,890.75',
    'status': 'VIP',
  },
];

void _showAddClientDialog(BuildContext context, bool isDark) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String selectedStatus = 'Actif';

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        backgroundColor: isDark ? darkSecondaryColor : secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        title: Text(
          'Nouveau Client',
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
                'Nom complet',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Ex: Ahmed Benali',
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
                'Email',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'email@exemple.com',
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
                'Téléphone',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '+213 555 123 456',
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
                items: ['Actif', 'Inactif', 'VIP', 'Bloqué']
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
                  content: Text('Client ajouté avec succès'),
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
            child: Text('Ajouter'),
          ),
        ],
      ),
    ),
  );
}
