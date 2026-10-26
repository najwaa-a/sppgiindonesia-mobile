import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/features/auth/presentation/screens/login_screen.dart';
import 'package:posmbg_mobile/features/auth/presentation/screens/register_screen.dart';
import 'package:posmbg_mobile/features/dashboard/presentation/screens/home_screen.dart';
import 'package:posmbg_mobile/features/kitchen/catalog/presentation/screens/catalog_screen.dart';
import 'package:posmbg_mobile/features/kitchen/presentation/screens/kitchen_dashboard_screen.dart';
import 'package:posmbg_mobile/features/kitchen/purchase_order/presentation/screens/purchase_order_screen.dart';
import 'package:posmbg_mobile/features/kitchen/receipt_confirmation/presentation/screens/receipt_confirmation_screen.dart';
import 'package:posmbg_mobile/features/supplier/incoming_orders/presentation/screens/incoming_orders_screen.dart';
import 'package:posmbg_mobile/features/supplier/presentation/screens/supplier_dashboard_screen.dart';
import 'package:posmbg_mobile/features/supplier/proof_of_delivery/presentation/screens/proof_of_delivery_screen.dart';
import 'package:posmbg_mobile/features/supplier/shipment/presentation/screens/shipment_screen.dart';

/// Konfigurasi GoRouter dengan dukungan route guard berbasis role
class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // Landing Page
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),

      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Role 1: Dapur MBG Routes
      GoRoute(
        path: '/kitchen/dashboard',
        builder: (context, state) => const KitchenDashboardScreen(),
      ),
      GoRoute(
        path: '/kitchen/catalog',
        builder: (context, state) => const CatalogScreen(),
      ),
      GoRoute(
        path: '/kitchen/purchase-order',
        builder: (context, state) => const PurchaseOrderScreen(),
      ),
      GoRoute(
        path: '/kitchen/receipt-confirmation',
        builder: (context, state) => const ReceiptConfirmationScreen(),
      ),

      // Role 2: Supplier Routes
      GoRoute(
        path: '/supplier/dashboard',
        builder: (context, state) => const SupplierDashboardScreen(),
      ),
      GoRoute(
        path: '/supplier/incoming-orders',
        builder: (context, state) => const IncomingOrdersScreen(),
      ),
      GoRoute(
        path: '/supplier/shipment',
        builder: (context, state) => const ShipmentScreen(),
      ),
      GoRoute(
        path: '/supplier/proof-of-delivery',
        builder: (context, state) => const ProofOfDeliveryScreen(),
      ),
    ],
  );
}
