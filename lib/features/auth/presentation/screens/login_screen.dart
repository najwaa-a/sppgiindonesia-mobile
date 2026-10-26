import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/constants/app_constants.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/widgets/custom_button.dart';

/// Layar Login dengan deteksi role (Dapur MBG / Supplier)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = AppConstants.roleKitchen;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // Simulasi routing berdasarkan role
      if (_selectedRole == AppConstants.roleKitchen) {
        context.go('/kitchen/dashboard');
      } else {
        context.go('/supplier/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masuk ke Akun'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Text('Selamat Datang', style: AppTextStyles.headingLarge),
                const SizedBox(height: 8),
                Text(
                  'Masuk ke portal operasional SPPGIndonesia untuk memantau pesanan dan pengiriman bahan baku.',
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 32),

                // Pemilihan Role
                Text('Pilih Role Anda:', style: AppTextStyles.headingSmall),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildRoleSelector(
                        title: 'Dapur MBG',
                        icon: Icons.restaurant,
                        role: AppConstants.roleKitchen,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildRoleSelector(
                        title: 'Supplier',
                        icon: Icons.local_shipping,
                        role: AppConstants.roleSupplier,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Input Email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Input Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata sandi wajib diisi';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28),

                CustomButton(
                  label: 'Masuk Sebagai ${_selectedRole == AppConstants.roleKitchen ? "Dapur MBG" : "Supplier"}',
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun? '),
                    GestureDetector(
                      onTap: () => context.push('/register'),
                      child: const Text(
                        'Daftar Sekarang',
                        style: TextStyle(
                          color: AppColors.primaryNavy,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleSelector({
    required String title,
    required IconData icon,
    required String role,
  }) {
    final isSelected = _selectedRole == role;
    return InkWell(
      onTap: () => setState(() => _selectedRole = role),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryNavy.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryNavy : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.primaryNavy : AppColors.textSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primaryNavy : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
