import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';

class ProduitsScreen extends StatelessWidget {
  const ProduitsScreen({Key? key}) : super(key: key);

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
            ProductStatsOverview(),
            SizedBox(height: defaultPadding),
            ProductsGrid(),
          ],
        ),
      ),
    );
  }
}

class ProductStatsOverview extends StatelessWidget {
  const ProductStatsOverview({Key? key}) : super(key: key);

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
        final stats = productStats[index];
        return ProductStatCard(
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

class ProductStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isDark;

  const ProductStatCard({
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

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key}) : super(key: key);

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
                "Tous les Produits",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              InkWell(
                onTap: () => _showAddProductDialog(context, isDark),
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
                        "Ajouter Produit",
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
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: defaultPadding,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: 0.85,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: products[index], isDark: isDark);
            },
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final bool isDark;

  const ProductCard({
    Key? key,
    required this.product,
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
          color: isDark ? darkDividerColor : dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? darkSurfaceColor : surfaceColor,
                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                  image: product['image'] != null && product['image'].startsWith('http')
                      ? DecorationImage(
                          image: NetworkImage(product['image']),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {},
                        )
                      : null,
                ),
              ),
              if (product['isPopular'] == true)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        Icon(Icons.local_fire_department, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'Populaire',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
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
            product['name'],
            style: TextStyle(
              color: isDark ? darkTextPrimary : textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6),
          Text(
            product['category'],
            style: TextStyle(
              color: isDark ? darkTextSecondary : textSecondary,
              fontSize: 11,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${product['price']} DA',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: product['stock'] > 50 
                      ? successColor.withValues(alpha: 0.1)
                      : errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(smallRadius)),
                ),
                child: Text(
                  'Stock: ${product['stock']}',
                  style: TextStyle(
                    color: product['stock'] > 50 ? successColor : errorColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: accentColor, size: 14),
              SizedBox(width: 4),
              Text(
                '${product['rating']} (${product['reviews']})',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> productStats = [
  {
    'title': 'Total Produits',
    'value': '2,456',
    'icon': Icons.inventory_2,
    'color': primaryColor,
  },
  {
    'title': 'En Stock',
    'value': '1,890',
    'icon': Icons.checkroom,
    'color': successColor,
  },
  {
    'title': 'Stock Faible',
    'value': '234',
    'icon': Icons.warning,
    'color': warningColor,
  },
  {
    'title': 'Rupture',
    'value': '332',
    'icon': Icons.block,
    'color': errorColor,
  },
];

final List<Map<String, dynamic>> products = [
  {
    'name': 'Huile d\'Olive Extra',
    'category': 'Épicerie',
    'price': '450.00',
    'stock': 120,
    'rating': '4.8',
    'reviews': 234,
    'image': 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=400',
    'isPopular': true,
  },
  {
    'name': 'Couscous Royal',
    'category': 'Céréales',
    'price': '320.00',
    'stock': 45,
    'rating': '4.6',
    'reviews': 189,
    'image': 'https://images.unsplash.com/photo-1585937421612-70a008356fbe?w=400',
    'isPopular': true,
  },
  {
    'name': 'Thé Vert Menthe',
    'category': 'Boissons',
    'price': '180.00',
    'stock': 8,
    'rating': '4.9',
    'reviews': 312,
    'image': 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400',
    'isPopular': true,
  },
  {
    'name': 'Dattes Deglet Nour',
    'category': 'Fruits Secs',
    'price': '650.00',
    'stock': 200,
    'rating': '4.7',
    'reviews': 156,
    'image': 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=400',
    'isPopular': false,
  },
  {
    'name': 'Pain Traditionnel',
    'category': 'Boulangerie',
    'price': '25.00',
    'stock': 3,
    'rating': '4.5',
    'reviews': 445,
    'image': 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
    'isPopular': true,
  },
  {
    'name': 'Lait Frais',
    'category': 'Produits Laitiers',
    'price': '95.00',
    'stock': 85,
    'rating': '4.4',
    'reviews': 278,
    'image': 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400',
    'isPopular': false,
  },
  {
    'name': 'Fromage Traditionnel',
    'category': 'Produits Laitiers',
    'price': '520.00',
    'stock': 62,
    'rating': '4.8',
    'reviews': 167,
    'image': 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=400',
    'isPopular': true,
  },
  {
    'name': 'Miel Pur',
    'category': 'Épicerie',
    'price': '1,200.00',
    'stock': 35,
    'rating': '4.9',
    'reviews': 98,
    'image': 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400',
    'isPopular': true,
  },
];

void _showAddProductDialog(BuildContext context, bool isDark) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  String selectedCategory = 'Épicerie';
  bool isPopular = false;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        backgroundColor: isDark ? darkSecondaryColor : secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
        ),
        title: Text(
          'Ajouter Produit',
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
                'Nom du produit',
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
                  hintText: 'Ex: Huile d\'Olive',
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
                'Prix (DA)',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: priceController,
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
                'Stock',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0',
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
                'Catégorie',
                style: TextStyle(
                  color: isDark ? darkTextSecondary : textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: selectedCategory,
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
                items: ['Épicerie', 'Céréales', 'Boissons', 'Fruits Secs', 'Boulangerie', 'Produits Laitiers']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => selectedCategory = value!);
                },
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: isPopular,
                    onChanged: (value) {
                      setState(() => isPopular = value!);
                    },
                    activeColor: primaryColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Marquer comme populaire',
                    style: TextStyle(
                      color: isDark ? darkTextPrimary : textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ],
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
                  content: Text('Produit ajouté avec succès'),
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
