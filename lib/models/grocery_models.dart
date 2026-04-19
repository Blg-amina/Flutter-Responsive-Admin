import 'package:flutter/material.dart';

class GroceryCategory {
  final String id;
  final String name;
  final String icon;
  final int productCount;
  final Color color;

  GroceryCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.productCount,
    required this.color,
  });
}

class GroceryProduct {
  final String id;
  final String name;
  final String category;
  final double price;
  final String image;
  final int stock;
  final double rating;
  final int soldCount;

  GroceryProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.stock,
    required this.rating,
    required this.soldCount,
  });
}

class GroceryOrder {
  final String id;
  final String customerName;
  final String customerPhone;
  final double totalAmount;
  final String status;
  final DateTime orderDate;
  final List<OrderItem> items;
  final String deliveryAddress;

  GroceryOrder({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    required this.items,
    required this.deliveryAddress,
  });
}

class OrderItem {
  final String productName;
  final int quantity;
  final double price;

  OrderItem({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}

class SalesStats {
  final String period;
  final double revenue;
  final int orders;
  final int customers;
  final double averageOrderValue;

  SalesStats({
    required this.period,
    required this.revenue,
    required this.orders,
    required this.customers,
    required this.averageOrderValue,
  });
}

class GroceryUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int totalOrders;
  final double totalSpent;
  final DateTime joinDate;

  GroceryUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.totalOrders,
    required this.totalSpent,
    required this.joinDate,
  });
}

// Demo Data
List<GroceryCategory> demoCategories = [
  GroceryCategory(
    id: '1',
    name: 'Légumes',
    icon: 'assets/icons/vegetables.svg',
    productCount: 45,
    color: Color(0xFF4CAF50),
  ),
  GroceryCategory(
    id: '2',
    name: 'Fruits',
    icon: 'assets/icons/fruits.svg',
    productCount: 38,
    color: Color(0xFFFF9800),
  ),
  GroceryCategory(
    id: '3',
    name: 'Viandes',
    icon: 'assets/icons/meat.svg',
    productCount: 25,
    color: Color(0xFFF44336),
  ),
  GroceryCategory(
    id: '4',
    name: 'Produits Laitiers',
    icon: 'assets/icons/dairy.svg',
    productCount: 32,
    color: Color(0xFF2196F3),
  ),
  GroceryCategory(
    id: '5',
    name: 'Boulangerie',
    icon: 'assets/icons/bakery.svg',
    productCount: 28,
    color: Color(0xFF795548),
  ),
  GroceryCategory(
    id: '6',
    name: 'Boissons',
    icon: 'assets/icons/drinks.svg',
    productCount: 52,
    color: Color(0xFF9C27B0),
  ),
  GroceryCategory(
    id: '7',
    name: 'Snacks',
    icon: 'assets/icons/snacks.svg',
    productCount: 41,
    color: Color(0xFFFFEB3B),
  ),
  GroceryCategory(
    id: '8',
    name: 'Surgelés',
    icon: 'assets/icons/frozen.svg',
    productCount: 35,
    color: Color(0xFF00BCD4),
  ),
];

List<GroceryProduct> demoProducts = [
  GroceryProduct(
    id: '1',
    name: 'Tomates Fraîches',
    category: 'Légumes',
    price: 2.50,
    image: 'assets/images/tomato.png',
    stock: 150,
    rating: 4.5,
    soldCount: 320,
  ),
  GroceryProduct(
    id: '2',
    name: 'Pommes Golden',
    category: 'Fruits',
    price: 3.20,
    image: 'assets/images/apple.png',
    stock: 200,
    rating: 4.8,
    soldCount: 450,
  ),
  GroceryProduct(
    id: '3',
    name: 'Poulet Fermier',
    category: 'Viandes',
    price: 12.00,
    image: 'assets/images/chicken.png',
    stock: 80,
    rating: 4.6,
    soldCount: 180,
  ),
  GroceryProduct(
    id: '4',
    name: 'Lait Frais 1L',
    category: 'Produits Laitiers',
    price: 1.80,
    image: 'assets/images/milk.png',
    stock: 300,
    rating: 4.7,
    soldCount: 520,
  ),
  GroceryProduct(
    id: '5',
    name: 'Pain Complet',
    category: 'Boulangerie',
    price: 2.00,
    image: 'assets/images/bread.png',
    stock: 100,
    rating: 4.4,
    soldCount: 380,
  ),
];

List<GroceryOrder> demoOrders = [
  GroceryOrder(
    id: 'ORD-001',
    customerName: 'Ahmed Benali',
    customerPhone: '+213 555 123 456',
    totalAmount: 45.50,
    status: 'pending',
    orderDate: DateTime.now().subtract(Duration(hours: 2)),
    items: [
      OrderItem(productName: 'Tomates Fraîches', quantity: 2, price: 2.50),
      OrderItem(productName: 'Pommes Golden', quantity: 3, price: 3.20),
      OrderItem(productName: 'Lait Frais 1L', quantity: 4, price: 1.80),
    ],
    deliveryAddress: 'Sidi Bel Abbès, Rue 1er Novembre',
  ),
  GroceryOrder(
    id: 'ORD-002',
    customerName: 'Fatima Zahra',
    customerPhone: '+213 555 789 012',
    totalAmount: 78.20,
    status: 'confirmed',
    orderDate: DateTime.now().subtract(Duration(hours: 5)),
    items: [
      OrderItem(productName: 'Poulet Fermier', quantity: 2, price: 12.00),
      OrderItem(productName: 'Pain Complet', quantity: 5, price: 2.00),
    ],
    deliveryAddress: 'Sidi Bel Abbès, Cité 1200 Logements',
  ),
  GroceryOrder(
    id: 'ORD-003',
    customerName: 'Mohamed Khaled',
    customerPhone: '+213 555 345 678',
    totalAmount: 32.00,
    status: 'preparing',
    orderDate: DateTime.now().subtract(Duration(hours: 8)),
    items: [
      OrderItem(productName: 'Lait Frais 1L', quantity: 10, price: 1.80),
      OrderItem(productName: 'Pain Complet', quantity: 7, price: 2.00),
    ],
    deliveryAddress: 'Sidi Bel Abbès, Quartier El Bassatine',
  ),
  GroceryOrder(
    id: 'ORD-004',
    customerName: 'Amina Boudiaf',
    customerPhone: '+213 555 901 234',
    totalAmount: 156.80,
    status: 'onTheWay',
    orderDate: DateTime.now().subtract(Duration(hours: 12)),
    items: [
      OrderItem(productName: 'Poulet Fermier', quantity: 5, price: 12.00),
      OrderItem(productName: 'Tomates Fraîches', quantity: 8, price: 2.50),
      OrderItem(productName: 'Pommes Golden', quantity: 10, price: 3.20),
    ],
    deliveryAddress: 'Sidi Bel Abbès, Route de Tlemcen',
  ),
  GroceryOrder(
    id: 'ORD-005',
    customerName: 'Karim Slimani',
    customerPhone: '+213 555 567 890',
    totalAmount: 28.50,
    status: 'delivered',
    orderDate: DateTime.now().subtract(Duration(days: 1)),
    items: [
      OrderItem(productName: 'Lait Frais 1L', quantity: 5, price: 1.80),
      OrderItem(productName: 'Tomates Fraîches', quantity: 5, price: 2.50),
    ],
    deliveryAddress: 'Sidi Bel Abbès, Centre Ville',
  ),
];

List<SalesStats> demoSalesStats = [
  SalesStats(
    period: 'Aujourd\'hui',
    revenue: 1250.50,
    orders: 45,
    customers: 38,
    averageOrderValue: 27.79,
  ),
  SalesStats(
    period: 'Cette Semaine',
    revenue: 8750.00,
    orders: 312,
    customers: 245,
    averageOrderValue: 28.05,
  ),
  SalesStats(
    period: 'Ce Mois',
    revenue: 32500.00,
    orders: 1150,
    customers: 890,
    averageOrderValue: 28.26,
  ),
];

List<GroceryUser> demoUsers = [
  GroceryUser(
    id: '1',
    name: 'Ahmed Benali',
    email: 'ahmed@email.com',
    phone: '+213 555 123 456',
    totalOrders: 15,
    totalSpent: 425.50,
    joinDate: DateTime.now().subtract(Duration(days: 60)),
  ),
  GroceryUser(
    id: '2',
    name: 'Fatima Zahra',
    email: 'fatima@email.com',
    phone: '+213 555 789 012',
    totalOrders: 23,
    totalSpent: 680.20,
    joinDate: DateTime.now().subtract(Duration(days: 90)),
  ),
  GroceryUser(
    id: '3',
    name: 'Mohamed Khaled',
    email: 'mohamed@email.com',
    phone: '+213 555 345 678',
    totalOrders: 8,
    totalSpent: 245.00,
    joinDate: DateTime.now().subtract(Duration(days: 30)),
  ),
];
