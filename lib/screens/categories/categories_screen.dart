import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Catégories",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: defaultPadding),
            Center(
              child: Text(
                "Page Catégories - En construction",
                style: TextStyle(
                  fontSize: 18,
                  color: textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
