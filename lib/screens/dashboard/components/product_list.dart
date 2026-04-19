import 'package:admin/constants.dart';
import 'package:admin/models/grocery_models.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

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
          Text(
            "Produits Populaires",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: defaultPadding),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                demoProducts.length,
                (index) => ProductCard(product: demoProducts[index]),
              ),
            ),
          ),
          SizedBox(height: defaultPadding),
          Text(
            "Catégories",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: defaultPadding),
          Responsive(
            mobile: CategoryGridView(crossAxisCount: 2),
            tablet: CategoryGridView(crossAxisCount: 4),
            desktop: CategoryGridView(crossAxisCount: 4),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final GroceryProduct product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 180,
      margin: EdgeInsets.only(right: defaultPadding),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? darkBgColor : bgColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Icon(
              Icons.shopping_basket,
              color: primaryColor,
              size: 40,
            ),
          ),
          SizedBox(height: 8),
          Text(
            product.name,
            style: TextStyle(
              color: isDark ? Colors.white : textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            product.category,
            style: TextStyle(
              color: isDark ? Colors.white54 : textSecondary,
              fontSize: 11,
            ),
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${product.price.toStringAsFixed(2)} DA',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: accentColor, size: 12),
                  SizedBox(width: 2),
                  Text(
                    product.rating.toString(),
                    style: TextStyle(
                      color: isDark ? Colors.white70 : textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            'Stock: ${product.stock}',
            style: TextStyle(
              color: product.stock < 50 ? Colors.red : (isDark ? Colors.white70 : textSecondary),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryGridView extends StatelessWidget {
  final int crossAxisCount;

  const CategoryGridView({
    Key? key,
    this.crossAxisCount = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: 1.2,
      ),
      itemCount: demoCategories.length,
      itemBuilder: (context, index) => CategoryCard(
        category: demoCategories[index],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final GroceryCategory category;

  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: isDark ? darkBgColor : bgColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: category.color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: category.color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.category,
              color: category.color,
              size: 24,
            ),
          ),
          SizedBox(height: defaultPadding / 2),
          Text(
            category.name,
            style: TextStyle(
              color: isDark ? Colors.white : textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            '${category.productCount} produits',
            style: TextStyle(
              color: isDark ? Colors.white54 : textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
