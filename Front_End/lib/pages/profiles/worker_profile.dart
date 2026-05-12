import 'package:flutter/material.dart';

class WorkerProfilePage extends StatefulWidget {
  const WorkerProfilePage({super.key});

  @override
  State<WorkerProfilePage> createState() => _WorkerProfilePageState();
}

class _WorkerProfilePageState extends State<WorkerProfilePage> {
  // --- DUMMY DATA FOR DIFFERENT MONTHS ---
  final List<String> _months = ["February 2026", "March 2026", "April 2026", "May 2026"];
  int _currentMonthIndex = 2; // Default to April 2026

  final Map<String, Map<String, dynamic>> _monthlyData = {
    "February 2026": {
      "overtime": "5 Hrs",
      "present": "18",
      "transactions": [
        {"title": "Salary", "date": "10/2/2026", "amount": "10,000", "type": "salary"},
      ],
      "total": "10,000",
    },
    "March 2026": {
      "overtime": "12 Hrs",
      "present": "22",
      "transactions": [
        {"title": "Advance", "date": "01/3/2026", "amount": "150", "type": "advance"},
        {"title": "Advance", "date": "15/3/2026", "amount": "2,000", "type": "advance"},
        {"title": "Salary", "date": "10/3/2026", "amount": "10,000", "type": "salary"},
      ],
      "total": "12,150",
    },
    "April 2026": {
      "overtime": "10 Hrs",
      "present": "20",
      "transactions": [
        {"title": "Advance", "date": "01/4/2026", "amount": "150", "type": "advance"},
        {"title": "Salary", "date": "10/4/2026", "amount": "10,000", "type": "salary"},
      ],
      "total": "10,150",
    },
    "May 2026": {
      "overtime": "20 Hrs",
      "present": "25",
      "transactions": [
        {"title": "Advance", "date": "05/5/2026", "amount": "5,000", "type": "advance"},
        {"title": "Salary", "date": "10/5/2026", "amount": "15,000", "type": "salary"},
      ],
      "total": "20,000",
    },
  };

  void _changeMonth(int direction) {
    setState(() {
      _currentMonthIndex += direction;
      // Loop around if out of bounds
      if (_currentMonthIndex < 0) {
        _currentMonthIndex = _months.length - 1;
      } else if (_currentMonthIndex >= _months.length) {
        _currentMonthIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String currentMonth = _months[_currentMonthIndex];
    Map<String, dynamic> currentData = _monthlyData[currentMonth]!;
    List<Map<String, dynamic>> transactions = currentData["transactions"];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Deep matte black background
      body: Column(
        children: [
          // --- SCROLLABLE CONTENT ---
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- PROFILE HEADER SECTION ---
                  _buildProfileHeader(currentData["overtime"], currentData["present"]),

                  const SizedBox(height: 20),

                  // --- TRANSACTIONS TITLE ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "TRANSACTIONS",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                        ),
                        _build3DIconButton(Icons.file_download_outlined, onTap: () {}),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- DYNAMIC MONTH SELECTOR ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _build3DIconButton(Icons.chevron_left_rounded, onTap: () => _changeMonth(-1)),
                        _build3DContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(
                            currentMonth.toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                          ),
                        ),
                        _build3DIconButton(Icons.chevron_right_rounded, onTap: () => _changeMonth(1)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- TRANSACTION LIST ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: transactions.map((tx) {
                        bool isAdvance = tx["type"] == "advance";
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildTransactionCard(
                            title: tx["title"],
                            date: tx["date"],
                            amount: tx["amount"],
                            icon: isAdvance ? Icons.payments_rounded : Icons.monetization_on_rounded,
                            iconColor: isAdvance ? Colors.greenAccent : Colors.orangeAccent,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // --- STICKY FOOTER ---
          _buildStickyFooter(currentData["total"]),
        ],
      ),
    );
  }

  // ==========================================
  // WIDGET BUILDERS
  // ==========================================

  Widget _buildProfileHeader(String overtime, String present) {
    return SizedBox(
      height: 330,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // 1. Dark Top Banner
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF1A1A1A), Color(0xFF0F0F0F)]),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 20, offset: const Offset(0, 10))],
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),

          // 2. Back Button
          Positioned(top: 50, left: 20, child: _build3DIconButton(Icons.arrow_back_ios_new_rounded, onTap: () {})),

          // 3. Stats: Overtime & Present (Updates dynamically)
          Positioned(
            top: 155,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildStatItem("Total Overtime", overtime), _buildStatItem("Total Present", present)]),
            ),
          ),

          // 4. Circular Avatar
          Positioned(
            top: 110,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Color(0xFF0A0A0A), shape: BoxShape.circle),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFC4C4C4),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.8), blurRadius: 15, offset: const Offset(0, 8))],
                ),
                child: Icon(Icons.person_outline_rounded, size: 50, color: Colors.blueGrey[900]),
              ),
            ),
          ),

          // 5. Worker Name & Phone
          const Positioned(
            top: 240,
            child: Column(
              children: [
                Text(
                  "worker_rohit",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  "+91 9341859302",
                  style: TextStyle(color: Colors.white54, fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget _buildTransactionCard({required String title, required String date, required String amount, required IconData icon, required Color iconColor}) {
    return _build3DContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: iconColor.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Text(
            "₹ $amount",
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyFooter(String totalAmount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.8), blurRadius: 20, offset: const Offset(0, -5)),
          BoxShadow(color: Colors.white.withValues(alpha: 0.02), blurRadius: 1, offset: const Offset(0, -1)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total transactions:",
              style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              "₹ $totalAmount",
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  // --- REUSABLE 3D COMPONENTS ---

  Widget _build3DIconButton(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.6), offset: const Offset(3, 3), blurRadius: 6),
            BoxShadow(color: Colors.white.withValues(alpha: 0.04), offset: const Offset(-1, -1), blurRadius: 4),
          ],
          border: Border.all(color: Colors.white.withValues(alpha: 0.02)),
        ),
        child: Icon(icon, color: Colors.white70, size: 20),
      ),
    );
  }

  Widget _build3DContainer({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1E1E1E), Color(0xFF121212)]),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.6), offset: const Offset(5, 5), blurRadius: 10),
          BoxShadow(color: Colors.white.withValues(alpha: 0.03), offset: const Offset(-2, -2), blurRadius: 8),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.02), width: 1),
      ),
      child: child,
    );
  }
}
