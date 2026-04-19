import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class LivraisonScreen extends StatelessWidget {
  const LivraisonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Livraison",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: defaultPadding),
            Center(
              child: Text(
                "Page Livraison - En construction",
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
