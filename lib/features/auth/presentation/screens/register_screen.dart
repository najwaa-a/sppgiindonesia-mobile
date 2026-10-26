import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/constants/app_constants.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';
import 'package:posmbg_mobile/core/widgets/custom_button.dart';

/// Layar Registrasi Akun Lapangan (Dapur MBG & Supplier)
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = AppConstants.roleKitchen;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pendaftaran berhasil! Silakan masuk dengan akun baru Anda.'),
          backgroundColor: AppColors.successGreen,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Akun'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Buat Akun Baru', style: AppTextStyles.headingLarge),
                const SizedBox(height: 8),
                Text(
                  'Daftarkan entitas Dapur MBG atau Supplier Anda ke dalam ekosistem SPPGIndonesia.',
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 28),

                // Pilihan Role
                Text('Tipe Akun Lapangan:', style: AppTextStyles.headingSmall),
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

                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap / Nama Entitas',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Nama wajib diisi' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Email wajib diisi' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Nomor WhatsApp / HP',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Nomor telepon wajib diisi' : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Kata Sandi',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (v) => v == null || v.length < 6 ? 'Minimal 6 karakter' : null,
                ),
                const SizedBox(height: 28),

                CustomButton(
                  label: 'Daftar Sekarang',
                  onPressed: _handleRegister,
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
