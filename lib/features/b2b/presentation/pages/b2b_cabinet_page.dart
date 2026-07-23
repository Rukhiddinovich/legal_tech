import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/global_button.dart';
import '../../../../core/widgets/global_text.dart';

/// 07 — B2B Kabinet (Segmented tab boshqaruvi, theme-mos dizayn).
class B2BCabinetPage extends StatefulWidget {
  const B2BCabinetPage({super.key});

  @override
  State<B2BCabinetPage> createState() => _B2BCabinetPageState();
}

class _B2BCabinetPageState extends State<B2BCabinetPage> {
  bool _isSubscribed = true;
  int _activeSegment = 0; // 0: Tarif, 1: Xodimlar, 2: To'lovlar
  final List<String> _employees = ['Sardor Aliyev (Direktor)', 'Gulnoza Karimova (HR)', 'Shavkat Mamatov (Buxgalter)'];
  final _employeeController = TextEditingController();

  @override
  void dispose() {
    _employeeController.dispose();
    super.dispose();
  }

  void _addEmployee() {
    final text = _employeeController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _employees.add(text);
    });
    _employeeController.clear();
  }

  void _removeEmployee(int index) {
    setState(() {
      _employees.removeAt(index);
    });
  }

  void _showTariffsComparison() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TariffsModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    if (!_isSubscribed) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(CupertinoIcons.briefcase_fill, size: 54, color: AppColors.gold),
                ),
                const SizedBox(height: 24),
                GlobalText(
                  text: 'LegalTech Biznes (B2B)',
                  fontFamily: 'Newsreader',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: onSurface,
                ),
                const SizedBox(height: 12),
                GlobalText(
                  text: 'Kompaniyangiz uchun to\'liq huquqiy himoya. Hujjat generatori cheksiz limiti, B2B advokatlar ko\'magi va xodimlar uchun alohida ruxsatnomalar.',
                  fontSize: 13,
                  color: AppColors.textMuted,
                  textAlign: TextAlign.center,
                  height: 1.5,
                ),
                const SizedBox(height: 36),
                GlobalButton(
                  onTap: () {
                    setState(() {
                      _isSubscribed = true;
                    });
                  },
                  title: 'Tariflarni ko\'rish',
                  color: isDark ? AppColors.darkTextPrimary : AppColors.navy,
                  textColor: isDark ? AppColors.black : AppColors.white,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom premium header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GlobalText(
                          text: 'B2B Kabinet',
                          fontFamily: 'Newsreader',
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: onSurface,
                        ),
                        const SizedBox(height: 2),
                        const GlobalText(
                          text: 'Biznes Standart tarif rejasi',
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.online.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(CupertinoIcons.checkmark_seal_fill, color: AppColors.online, size: 12),
                        SizedBox(width: 4),
                        GlobalText(
                          text: 'Faol',
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.online,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Segmented Control
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<int>(
                  groupValue: _activeSegment,
                  backgroundColor: isDark ? Colors.grey[900]! : Colors.grey[200]!,
                  thumbColor: isDark ? Colors.grey[800]! : Colors.white,
                  children: const {
                    0: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Tarif & Limit', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold))),
                    1: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('Xodimlar', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold))),
                    2: Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('To\'lovlar', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold))),
                  },
                  onValueChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _activeSegment = val;
                      });
                    }
                  },
                ),
              ),
            ),

            // Content Panel
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  if (_activeSegment == 0) _buildTarifTab(),
                  if (_activeSegment == 1) _buildEmployeesTab(),
                  if (_activeSegment == 2) _buildPaymentsTab(),
                  const SizedBox(height: 24),
                  
                  // Cancel sub link
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSubscribed = false;
                        });
                      },
                      child: const GlobalText(
                        text: 'B2B Obunani bekor qilish',
                        fontSize: 11.5,
                        color: AppColors.danger,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: TARIF & LIMITLAR ---
  Widget _buildTarifTab() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          color: isDark ? Theme.of(context).cardColor : AppColors.navy,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlobalText(
                        text: 'Joriy tarif rejasi',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.white.withValues(alpha: 0.55),
                      ),
                      const SizedBox(height: 2),
                      GlobalText(
                        text: 'Biznes Standart',
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.white,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: _showTariffsComparison,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.gold.withValues(alpha: 0.18),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const GlobalText(
                      text: 'Taqqoslash',
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.gold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Divider(color: isDark ? AppColors.darkBorder : AppColors.white.withValues(alpha: 0.15)),
              const SizedBox(height: 12),
              _limitRow('Hujjatlar generatori', '8 ta ishlatildi (15 tadan)', 8 / 15),
              const SizedBox(height: 16),
              _limitRow('Konsultatsiyalar', '2 ta seans (5 tadan)', 2 / 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _limitRow(String label, String value, double percent) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txtColor = isDark ? AppColors.darkTextPrimary : AppColors.white;
    final descColor = isDark ? AppColors.darkTextSecondary : AppColors.white.withValues(alpha: 0.6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GlobalText(text: label, fontSize: 12, color: descColor, fontWeight: FontWeight.w600),
            GlobalText(text: value, fontSize: 11.5, fontWeight: FontWeight.w700, color: txtColor),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percent,
            backgroundColor: isDark ? Colors.grey[800] : AppColors.white.withValues(alpha: 0.15),
            color: AppColors.gold,
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  // --- TAB 2: XODIMLAR BOSHQARUVI ---
  Widget _buildEmployeesTab() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const GlobalText(text: 'Xodimlar ro\'yxati', fontSize: 14, fontWeight: FontWeight.w700),
            GlobalText(text: '${_employees.length} / 5 ta', fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.gold),
          ],
        ),
        const SizedBox(height: 10),
        
        // Add Input Row
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _employeeController,
                  decoration: const InputDecoration(
                    hintText: 'Xodim F.I.SH. kiriting...',
                    hintStyle: TextStyle(fontSize: 12.5, color: AppColors.textHint),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 13, color: onSurface),
                ),
              ),
              IconButton(
                onPressed: _addEmployee,
                icon: const Icon(CupertinoIcons.plus_circle_fill, color: AppColors.online, size: 22),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // List
        if (_employees.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: GlobalText(text: 'Xodimlar qo\'shilmagan', color: AppColors.textMuted)),
          )
        else
          ...List.generate(_employees.length, (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (isDark ? Colors.grey[800] : Colors.grey[100])!,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(CupertinoIcons.person_crop_circle_badge_checkmark, size: 16, color: isDark ? AppColors.white : AppColors.navy),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GlobalText(
                      text: _employees[index],
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _removeEmployee(index),
                    child: const Icon(CupertinoIcons.trash, size: 16, color: AppColors.danger),
                  ),
                ],
              ),
            ),
          )),
      ],
    );
  }

  // --- TAB 3: TO'LOVLAR (BILLING) ---
  Widget _buildPaymentsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const GlobalText(text: 'To\'lovlar tarixi & Cheklar', fontSize: 14, fontWeight: FontWeight.w700),
        const SizedBox(height: 10),
        _invoiceItem('Obuna to\'lovi — 2026 Iyul', '450 000 so\'m', 'Bugun, 10:14'),
        const SizedBox(height: 8),
        _invoiceItem('Obuna to\'lovi — 2026 Iyun', '450 000 so\'m', '23-Iyun'),
      ],
    );
  }

  Widget _invoiceItem(String title, String amount, String date) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.online.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(CupertinoIcons.doc_text_fill, size: 16, color: AppColors.online),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalText(text: title, fontSize: 13, fontWeight: FontWeight.w700),
                const SizedBox(height: 2),
                GlobalText(text: '$amount · $date', fontSize: 11.5, color: AppColors.textMuted),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.fillColored,
                title: const Text('Fiskal chek yuklab olindi (PDF)'),
                autoCloseDuration: const Duration(seconds: 3),
              );
            },
            icon: Icon(CupertinoIcons.cloud_download, size: 18, color: isDark ? AppColors.white : AppColors.navy),
          ),
        ],
      ),
    );
  }
}

// --- TARIFF COMPARISON SHEET (Fully theme compatible) ---
class _TariffsModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderStrong,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          GlobalText(
            text: 'Tarif rejalarini solishtirish',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: onSurface,
          ),
          const SizedBox(height: 20),
          _tariffRow(context, 'Xususiyatlar', 'Standart', 'Premium', isHeader: true),
          const Divider(),
          _tariffRow(context, 'Oylik to\'lov', '450 000 UZS', '990 000 UZS'),
          const Divider(),
          _tariffRow(context, 'Hujjat generatori', '15 ta / oy', 'Cheksiz'),
          const Divider(),
          _tariffRow(context, 'Advokat seansi', '5 ta / oy', '12 ta / oy'),
          const Divider(),
          _tariffRow(context, 'Xodimlar limiti', '5 tagacha', '20 tagacha'),
          const SizedBox(height: 24),
          GlobalButton(
            onTap: () => Navigator.pop(context),
            title: 'Tushunarli',
            color: isDark ? AppColors.darkTextPrimary : AppColors.navy,
            textColor: isDark ? AppColors.black : AppColors.white,
          ),
        ],
      ),
    );
  }

  Widget _tariffRow(BuildContext context, String feature, String standard, String premium, {bool isHeader = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txtColor = Theme.of(context).colorScheme.onSurface;
    final standardColor = isDark ? Colors.grey[300] : AppColors.navyText;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: GlobalText(
              text: feature,
              fontSize: 12.5,
              fontWeight: isHeader ? FontWeight.w700 : FontWeight.w600,
              color: isHeader ? AppColors.textMuted : txtColor,
            ),
          ),
          Expanded(
            child: GlobalText(
              text: standard,
              fontSize: 12,
              fontWeight: isHeader ? FontWeight.w700 : FontWeight.w600,
              color: isHeader ? AppColors.textMuted : standardColor,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: GlobalText(
              text: premium,
              fontSize: 12,
              fontWeight: isHeader ? FontWeight.w700 : FontWeight.w700,
              color: isHeader ? AppColors.textMuted : AppColors.gold,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
