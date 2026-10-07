import 'package:flutter/material.dart';

void main() {
  runApp(const FinoteApp());
}

// ============================================================
// FINOTE APP
// ============================================================

class FinoteApp extends StatelessWidget {
  const FinoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FINOTE',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF1A237E), // Navy
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

// ============================================================
// MODEL TRANSAKSI
// ============================================================

class TransactionItem {
  final String title;
  final int amount;
  final bool isIncome;
  final DateTime date;

  TransactionItem({
    required this.title,
    required this.amount,
    required this.isIncome,
    DateTime? date,
  }) : date = date ?? DateTime.now();
}

// ============================================================
// DASHBOARD
// ============================================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int totalIncome = 4666000;
  int totalExpense = 4449209;

  final List<TransactionItem> transactions = [
    TransactionItem(
      title: 'Dari workshop',
      amount: 50000,
      isIncome: true,
      date: DateTime(2026, 9, 3, 14, 37),
    ),
    TransactionItem(
      title: 'Print',
      amount: 1000,
      isIncome: false,
      date: DateTime(2026, 9, 3, 14, 38),
    ),
    TransactionItem(
      title: 'Kuota sebulan',
      amount: 105000,
      isIncome: false,
      date: DateTime(2026, 9, 3, 13, 45),
    ),
    TransactionItem(
      title: 'Bensin mas',
      amount: 20000,
      isIncome: false,
      date: DateTime(2026, 9, 3, 13, 44),
    ),
    TransactionItem(
      title: 'Bensin fulltank',
      amount: 33000,
      isIncome: false,
      date: DateTime(2026, 9, 3, 13, 43),
    ),
    TransactionItem(
      title: 'Stempel',
      amount: 85000,
      isIncome: false,
      date: DateTime(2026, 9, 3, 10, 0),
    ),
  ];

  int get balance => totalIncome - totalExpense;

  void addIncome(int amount, String description) {
    setState(() {
      totalIncome += amount;
      transactions.insert(
        0,
        TransactionItem(
          title: description,
          amount: amount,
          isIncome: true,
        ),
      );
    });
  }

  void addExpense(int amount, String description) {
    setState(() {
      totalExpense += amount;
      transactions.insert(
        0,
        TransactionItem(
          title: description,
          amount: amount,
          isIncome: false,
        ),
      );
    });
  }

  String formatRupiah(int number) {
    final String value = number.toString();
    String result = '';
    int count = 0;

    for (int i = value.length - 1; i >= 0; i--) {
      result = value[i] + result;
      count++;

      if (count % 3 == 0 && i != 0) {
        result = '.$result';
      }
    }

    return 'Rp$result';
  }

  String formatDate(DateTime date) {
    final days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];

    final dayName = days[date.weekday - 1];
    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year;

    return '$dayName, $day $month $year';
  }

  String formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      // ========================================================
      // APP BAR - NAVY
      // ========================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'FINOTE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Catatan keuanganmu',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
          ),
        ],
      ),

      // ========================================================
      // DRAWER / MENU - NAVY
      // ========================================================

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 180,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF1A237E),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 45,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'FINOTE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Catatan keuanganmu',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.dashboard_outlined,
                color: Color(0xFF1A237E),
              ),
              title: const Text(
                'Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.arrow_downward,
                color: Colors.green,
              ),
              title: const Text(
                'Pemasukan',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                'Catat uang yang kamu terima',
              ),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PemasukanScreen(
                      onSave: addIncome,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.arrow_upward,
                color: Colors.red,
              ),
              title: const Text(
                'Pengeluaran',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                'Catat uang yang kamu keluarkan',
              ),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PengeluaranScreen(
                      onSave: addExpense,
                    ),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.settings_outlined,
              ),
              title: const Text(
                'Pengaturan',
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Halo! 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Berikut ringkasan keuanganmu',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // ==================================================
            // SALDO - NAVY
            // ==================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SALDO',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatRupiah(balance),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Saldo saat ini',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ==================================================
            // PEMASUKAN & PENGELUARAN
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: _summaryCard(
                    title: 'Uang Masuk',
                    amount: formatRupiah(totalIncome),
                    icon: Icons.arrow_downward,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _summaryCard(
                    title: 'Uang Keluar',
                    amount: formatRupiah(totalExpense),
                    icon: Icons.arrow_upward,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // ==================================================
            // RINGKASAN
            // ==================================================

            const Text(
              'RINGKASAN KEUANGAN',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  _summaryRow(
                    'Masuk',
                    formatRupiah(totalIncome),
                    Colors.green,
                  ),
                  const Divider(height: 25),
                  _summaryRow(
                    'Keluar',
                    formatRupiah(totalExpense),
                    Colors.red,
                  ),
                  const Divider(height: 25),
                  _summaryRow(
                    'Saldo',
                    formatRupiah(balance),
                    const Color(0xFF1A237E),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // ==================================================
            // TRANSAKSI TERBARU - DIPISAH PEMASUKAN & PENGELUARAN
            // ==================================================

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TRANSAKSI TERBARU',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Lihat Semua',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),

            // ==== LIST TRANSAKSI DIPISAH ====
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length > 6 ? 6 : transactions.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                final transaction = transactions[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==========================================
                        // BARIS 1: TANGGAL (KIRI) & SALDO (KANAN)
                        // ==========================================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  formatDate(transaction.date),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            // Saldo di kanan
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Saldo ${formatRupiah(balance)}',
                                style: TextStyle(
                                  color: const Color(0xFF1A237E),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // ==========================================
                        // BARIS 2: JUDUL & WAKTU
                        // ==========================================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transaction.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              formatTime(transaction.date),
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // ==========================================
                        // BARIS 3: NOMINAL (WARNA SESUAI JENIS)
                        // ==========================================
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: transaction.isIncome
                                ? Colors.green.withValues(alpha: 0.08)
                                : Colors.red.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                transaction.isIncome ? 'Pemasukan' : 'Pengeluaran',
                                style: TextStyle(
                                  color: transaction.isIncome
                                      ? Colors.green[700]
                                      : Colors.red[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${transaction.isIncome ? '+' : '-'} ${formatRupiah(transaction.amount)}',
                                style: TextStyle(
                                  color: transaction.isIncome
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 25),

            // ==================================================
            // TOMBOL TRANSAKSI
            // ==================================================

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PemasukanScreen(
                            onSave: addIncome,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Tambah Pemasukan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PengeluaranScreen(
                            onSave: addExpense,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.remove),
                    label: const Text('Tambah Pengeluaran'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.12),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            amount,
            style: TextStyle(
              color: color,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String title, String amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// HALAMAN PEMASUKAN
// ============================================================

class PemasukanScreen extends StatefulWidget {
  final Function(int amount, String description) onSave;

  const PemasukanScreen({
    super.key,
    required this.onSave,
  });

  @override
  State<PemasukanScreen> createState() => _PemasukanScreenState();
}

class _PemasukanScreenState extends State<PemasukanScreen> {
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nominalController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void save() {
    final String nominalText =
        nominalController.text.replaceAll('.', '').replaceAll(',', '');
    final int? nominal = int.tryParse(nominalText);
    final String description = descriptionController.text.trim();

    if (nominal == null || nominal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nominal yang benar.'),
        ),
      );
      return;
    }

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan keterangan transaksi.'),
        ),
      );
      return;
    }

    widget.onSave(nominal, description);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pemasukan'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah Pemasukan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan uang yang kamu terima.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nominal',
                hintText: 'Contoh: 50000',
                prefixText: 'Rp ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Keterangan',
                hintText: 'Contoh: Gaji, bonus, jual barang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: save,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Pemasukan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// HALAMAN PENGELUARAN
// ============================================================

class PengeluaranScreen extends StatefulWidget {
  final Function(int amount, String description) onSave;

  const PengeluaranScreen({
    super.key,
    required this.onSave,
  });

  @override
  State<PengeluaranScreen> createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {
  final TextEditingController nominalController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nominalController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void save() {
    final String nominalText =
        nominalController.text.replaceAll('.', '').replaceAll(',', '');
    final int? nominal = int.tryParse(nominalText);
    final String description = descriptionController.text.trim();

    if (nominal == null || nominal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nominal yang benar.'),
        ),
      );
      return;
    }

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan keterangan transaksi.'),
        ),
      );
      return;
    }

    widget.onSave(nominal, description);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengeluaran'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tambah Pengeluaran',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Masukkan uang yang kamu keluarkan.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nominal',
                hintText: 'Contoh: 50000',
                prefixText: 'Rp ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Keterangan',
                hintText: 'Contoh: bensin, makan, pulsa',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: save,
                icon: const Icon(Icons.save),
                label: const Text('Simpan Pengeluaran'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}