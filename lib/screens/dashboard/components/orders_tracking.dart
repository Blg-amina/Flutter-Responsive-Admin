import 'package:admin/constants.dart';
import 'package:admin/models/grocery_models.dart';
import 'package:flutter/material.dart';

class OrdersTracking extends StatelessWidget {
  const OrdersTracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? darkSecondaryColor : secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Commandes Récentes",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Voir tout",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          ...List.generate(
            demoOrders.length,
            (index) => OrderCard(order: demoOrders[index]),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final GroceryOrder order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  Color getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'preparing':
        return Colors.purple;
      case 'onTheWay':
        return Colors.teal;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'En attente';
      case 'confirmed':
        return 'Confirmée';
      case 'preparing':
        return 'En préparation';
      case 'onTheWay':
        return 'En livraison';
      case 'delivered':
        return 'Livrée';
      case 'cancelled':
        return 'Annulée';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(bottom: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? darkBgColor : bgColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.id,
                style: TextStyle(
                  color: isDark ? Colors.white : textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding / 2,
                  vertical: defaultPadding / 4,
                ),
                decoration: BoxDecoration(
                  color: getStatusColor(order.status).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Text(
                  getStatusText(order.status),
                  style: TextStyle(
                    color: getStatusColor(order.status),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Row(
            children: [
              Icon(Icons.person, color: Colors.white54, size: 14),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  order.customerName,
                  style: TextStyle(color: isDark ? Colors.white70 : textSecondary, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.white54, size: 14),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  order.customerPhone,
                  style: TextStyle(color: isDark ? Colors.white70 : textSecondary, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${order.totalAmount.toStringAsFixed(2)} DA',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${order.items.length} articles',
                style: TextStyle(color: isDark ? Colors.white54 : textSecondary, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: defaultPadding / 2),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.white54, size: 16),
              SizedBox(width: 8),
              Text(
                _formatDate(order.orderDate),
                style: TextStyle(color: isDark ? Colors.white54 : textSecondary, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inHours < 1) {
      return 'Il y a ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours} h';
    } else {
      return '${difference.inDays} j';
    }
  }
}

class OrderStatusOverview extends StatelessWidget {
  const OrderStatusOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusCounts = {
      'pending': demoOrders.where((o) => o.status == 'pending').length,
      'confirmed': demoOrders.where((o) => o.status == 'confirmed').length,
      'preparing': demoOrders.where((o) => o.status == 'preparing').length,
      'onTheWay': demoOrders.where((o) => o.status == 'onTheWay').length,
      'delivered': demoOrders.where((o) => o.status == 'delivered').length,
      'cancelled': demoOrders.where((o) => o.status == 'cancelled').length,
    };

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Statut des Commandes",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: defaultPadding),
          _buildStatusItem(context, 'En attente', statusCounts['pending']!, Colors.orange),
          _buildStatusItem(context, 'Confirmées', statusCounts['confirmed']!, Colors.blue),
          _buildStatusItem(context, 'En préparation', statusCounts['preparing']!, Colors.purple),
          _buildStatusItem(context, 'En livraison', statusCounts['onTheWay']!, Colors.teal),
          _buildStatusItem(context, 'Livrées', statusCounts['delivered']!, Colors.green),
          _buildStatusItem(context, 'Annulées', statusCounts['cancelled']!, Colors.red),
        ],
      ),
    );
  }

  Widget _buildStatusItem(BuildContext context, String label, int count, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: defaultPadding / 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: defaultPadding / 2),
              Text(
                label,
                style: TextStyle(color: isDark ? Colors.white70 : textSecondary, fontSize: 14),
              ),
            ],
          ),
          Text(
            count.toString(),
            style: TextStyle(
              color: isDark ? Colors.white : textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
