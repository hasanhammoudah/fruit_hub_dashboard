import 'package:flutter/material.dart';
import 'package:fruit_hub_dashboard/core/helper_functions/on_generate_routes.dart';
import 'package:fruit_hub_dashboard/features/dashboard/views/dashboard_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: DashboardView.routeName,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
