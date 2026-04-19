import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class ProduitsScreen extends StatelessWidget {
  const ProduitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Produits",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: defaultPadding),
            Center(
              child: Text(
                "Page Produits - En construction",
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
