import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';
import 'components/sales_stats_card.dart';
import 'components/sales_chart.dart';
import 'components/product_list.dart';
import 'components/orders_tracking.dart';

// Placeholder for RevenuePieChart and OrderStatusOverview
class RevenuePieChart extends StatelessWidget {
  const RevenuePieChart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Container();
}

class OrderStatusOverview extends StatelessWidget {
  const OrderStatusOverview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Container();
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = Responsive.isSmallMobile(context) 
        ? smallPadding 
        : Responsive.isMobile(context) 
            ? defaultPadding 
            : defaultPadding;
    
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(padding),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - padding * 2,
          ),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              StatsOverview(),
              SizedBox(height: defaultPadding),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (Responsive.isMobile(context)) {
                    return Column(
                      children: [
                        SalesChart(),
                        SizedBox(height: defaultPadding),
                        ProductList(),
                        SizedBox(height: defaultPadding),
                        OrdersTracking(),
                        SizedBox(height: defaultPadding),
                        RevenuePieChart(),
                      ],
                    );
                  } else {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: Responsive.isTablet(context) ? 2 : 5,
                          child: Column(
                            children: [
                              SalesChart(),
                              SizedBox(height: defaultPadding),
                              ProductList(),
                              SizedBox(height: defaultPadding),
                              OrdersTracking(),
                            ],
                          ),
                        ),
                        SizedBox(width: defaultPadding),
                        Flexible(
                          flex: Responsive.isTablet(context) ? 1 : 2,
                          child: Column(
                            children: [
                              RevenuePieChart(),
                              SizedBox(height: defaultPadding),
                              OrderStatusOverview(),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
