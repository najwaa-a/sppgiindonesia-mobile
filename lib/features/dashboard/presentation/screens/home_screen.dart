import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:posmbg_mobile/core/constants/app_constants.dart';
import 'package:posmbg_mobile/core/theme/app_colors.dart';
import 'package:posmbg_mobile/core/theme/app_text_styles.dart';

/// Halaman Home / Welcoming Onboarding SPPGIndonesia Mobile
/// Terdiri dari 3 halaman swipeable:
/// - Slide 1: Welcome & Overview Ekosistem MBG
/// - Slide 2: Sinergi 2 Aktor Lapangan (Dapur MBG & Supplier)
/// - Slide 3: Form Login Langsung dengan tautan ke pendaftaran (Sign Up)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Form state untuk Slide 3 (Form Login)
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = AppConstants.roleKitchen;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // Simulasi delay login
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
      setState(() => _isLoading = false);

      if (_selectedRole == AppConstants.roleKitchen) {
        context.go('/kitchen/dashboard');
      } else {
        context.go('/supplier/dashboard');
      }
    }
  }

  void _fillDemoAccount(String role) {
    setState(() {
      _selectedRole = role;
      if (role == AppConstants.roleKitchen) {
        _emailController.text = 'dapur.sentra@sppg.id';
        _passwordController.text = 'password123';
      } else {
        _emailController.text = 'supplier.berkah@sppg.id';
        _passwordController.text = 'password123';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildTopBar(),
      body: SafeArea(
        child: Column(
          children: [
            // PageView Swipeable 3 Halaman
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: [
                  _buildSlide1Welcome(),
                  _buildSlide2Features(),
                  _buildSlide3Login(),
                ],
              ),
            ),

            // Indikator & Kontrol Navigasi Bawah (Hanya untuk Slide 0 & 1)
            if (_currentPage < 2) _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  // --- HEADER APP BAR ---
  PreferredSizeWidget _buildTopBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 20,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.hub_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SPPGIndonesia',
                style: TextStyle(
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'Logistik Pangan MBG',
                style: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (_currentPage < 2)
          TextButton.icon(
            onPressed: () => _goToPage(2),
            label: const Text(
              'Lewati',
              style: TextStyle(
                color: AppColors.secondaryNavy,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13,
              color: AppColors.secondaryNavy,
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: List.generate(3, (index) => _buildDot(index, small: true)),
            ),
          ),
        const SizedBox(width: 8),
      ],
    );
  }

  // ==========================================
  // SLIDE 1: WELCOME & OVERVIEW MBG
  // ==========================================
  Widget _buildSlide1Welcome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          _buildBadge('PROGRAM MAKAN BERGIZI GRATIS', Icons.eco_rounded, Colors.green),
          const SizedBox(height: 16),
          Text(
            'Pengadaan & Distribusi\nPangan Terintegrasi',
            textAlign: TextAlign.center,
            style: AppTextStyles.headingLarge.copyWith(
              fontSize: 26,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Solusi digital terpadu untuk Dapur MBG dan Supplier dalam menjamin ketepatan pasokan bahan baku makanan anak sekolah.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Kartu Visual Hero
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppColors.heroGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryNavy.withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.restaurant_menu_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Cepat • Rapi • Transparan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Mulai dari pembuatan PO takaran porsi hingga serah terima timbangan lapangan terverifikasi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildPillTag('⚡ Real-time Tracking'),
                    _buildPillTag('⚖️ Cek Timbangan'),
                    _buildPillTag('📸 Bukti Fisik'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ==========================================
  // SLIDE 2: SINERGI 2 ROLE LAPANGAN
  // ==========================================
  Widget _buildSlide2Features() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          _buildBadge('KOLABORASI DUA AKTOR', Icons.handshake_rounded, AppColors.accentAmber),
          const SizedBox(height: 16),
          Text(
            'Dapur MBG & Supplier\nDalam Satu Sistem',
            textAlign: TextAlign.center,
            style: AppTextStyles.headingLarge.copyWith(
              fontSize: 26,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Hubungan transparan antara tim sentra memasak dan mitra penyedia bahan pangan tanpa risiko selisih stok.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Kartu Role Dapur MBG
          _buildRoleFeatureCard(
            title: 'Dapur MBG (Penerima)',
            badge: 'Sentra Memasak',
            icon: Icons.restaurant_rounded,
            accentColor: AppColors.primaryNavy,
            items: [
              'Katalog bahan pangan segar dan harga terkontrol',
              'Buat Purchase Order (PO) sesuai kuota porsi harian',
              'Konfirmasi penerimaan dengan foto timbangan fisik',
            ],
          ),
          const SizedBox(height: 14),

          // Kartu Role Supplier
          _buildRoleFeatureCard(
            title: 'Supplier (Penyedia)',
            badge: 'Mitra Bahan Baku',
            icon: Icons.local_shipping_rounded,
            accentColor: AppColors.accentAmber,
            items: [
              'Notifikasi instan pesanan masuk dari pihak dapur',
              'Kunci kuantitas kemasan dan cetak Surat Jalan digital',
              'Lacak pengantaran armada dan unggah bukti serah terima',
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ==========================================
  // SLIDE 3: FORM LOGIN LANGSUNG & SIGN UP LINK
  // ==========================================
  Widget _buildSlide3Login() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.center,
              child: _buildBadge('PORTAL OPERASIONAL', Icons.lock_outline_rounded, AppColors.primaryNavy),
            ),
            const SizedBox(height: 14),
            Text(
              'Masuk ke Akun Anda',
              textAlign: TextAlign.center,
              style: AppTextStyles.headingLarge.copyWith(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Pilih peran Anda dan masukkan email serta kata sandi untuk mengakses dashboard.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),

            // Pemilihan Role (Dapur MBG / Supplier)
            Text(
              'Pilih Peran Lapangan:',
              style: AppTextStyles.headingSmall.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildRoleSelectorCard(
                    title: 'Dapur MBG',
                    subtitle: 'Penerima Bahan',
                    icon: Icons.restaurant_rounded,
                    role: AppConstants.roleKitchen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRoleSelectorCard(
                    title: 'Supplier',
                    subtitle: 'Penyedia Bahan',
                    icon: Icons.local_shipping_rounded,
                    role: AppConstants.roleSupplier,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Input Email
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Akun',
                hintText: 'nama@sppg.id',
                prefixIcon: const Icon(Icons.email_outlined, color: AppColors.primaryNavy),
                filled: true,
                fillColor: AppColors.surfaceSecondary.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primaryNavy, width: 2),
                ),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Email wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),

            // Input Password
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Kata Sandi',
                hintText: 'Minimal 6 karakter',
                prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.primaryNavy),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
                filled: true,
                fillColor: AppColors.surfaceSecondary.withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.divider),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primaryNavy, width: 2),
                ),
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Kata sandi wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 22),

            // Tombol Utama Masuk
            SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _handleLogin,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Icon(Icons.login_rounded, color: Colors.white, size: 20),
                label: Text(
                  _isLoading
                      ? 'Memproses...'
                      : 'Masuk sebagai ${_selectedRole == AppConstants.roleKitchen ? "Dapur MBG" : "Supplier"}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryNavy,
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tombol Kecil Menuju Sign Up (Daftar Akun)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Belum memiliki akun?',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton(
                  onPressed: () => context.push('/register'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    visualDensity: VisualDensity.compact,
                  ),
                  child: const Text(
                    'Daftar Sekarang',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Helper Akun Demo untuk Pengujian Cepat
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.tips_and_updates_outlined, size: 15, color: Colors.amber.shade800),
                      const SizedBox(width: 6),
                      Text(
                        'Akses Demo Pengujian:',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => _fillDemoAccount(AppConstants.roleKitchen),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primaryNavy.withValues(alpha: 0.3)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.restaurant, size: 14, color: AppColors.primaryNavy),
                              SizedBox(width: 4),
                              Text(
                                'Akun Dapur',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryNavy,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => _fillDemoAccount(AppConstants.roleSupplier),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.accentAmber.withValues(alpha: 0.5)),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.local_shipping, size: 14, color: AppColors.accentAmber),
                              SizedBox(width: 4),
                              Text(
                                'Akun Supplier',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentAmber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: PILIHAN ROLE PADA FORM LOGIN ---
  Widget _buildRoleSelectorCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String role,
  }) {
    final isSelected = _selectedRole == role;
    return InkWell(
      onTap: () => setState(() => _selectedRole = role),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryNavy.withValues(alpha: 0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryNavy : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryNavy.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected ? AppColors.primaryNavy : AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: isSelected ? AppColors.primaryNavy : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.secondaryNavy : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER: KARTU ROLE FITUR PADA SLIDE 2 ---
  Widget _buildRoleFeatureCard({
    required String title,
    required String badge,
    required IconData icon,
    required Color accentColor,
    required List<String> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      badge,
                      style: TextStyle(
                        fontSize: 11,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_rounded, size: 16, color: accentColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: BADGE HEADER KATEGORI ---
  Widget _buildBadge(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: PILL TAG ---
  Widget _buildPillTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // --- WIDGET HELPER: NAVIGASI BAWAH (SLIDE 0 & 1) ---
  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 3 Dots Indicator
          Row(
            children: List.generate(3, (index) => _buildDot(index)),
          ),

          // Tombol Lanjut
          ElevatedButton(
            onPressed: () => _goToPage(_currentPage + 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryNavy,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _currentPage == 0 ? 'Lanjut' : 'Ke Form Login',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER: DOT INDIKATOR HALAMAN ---
  Widget _buildDot(int index, {bool small = false}) {
    final isActive = _currentPage == index;
    return GestureDetector(
      onTap: () => _goToPage(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: isActive ? (small ? 14 : 22) : (small ? 6 : 8),
        height: small ? 6 : 8,
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryNavy
              : AppColors.divider,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
