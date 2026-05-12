import 'package:flutter/material.dart';

class AttendanceList extends StatelessWidget {
  const AttendanceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Column(
        children: [
          // --- PROFILE HEADER SECTION ---
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Top Black Banner
              Container(height: 140, width: double.infinity, color: Colors.black),
              // Profile Information
              Positioned(
                top: 70,
                child: Column(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color(0xFFC4C4C4),
                      child: Icon(Icons.person_outline_rounded, size: 60, color: Colors.blueGrey[900]),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "worker_rohit",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "+91 9341859302",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              // Stats: Overtime & Present
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_buildStatItem("Total Overtime", "10 Hrs"), _buildStatItem("Total Present", "20")]),
                ),
              ),
            ],
          ),

          // Spacer for the overlapping profile info
          const SizedBox(height: 130),

          // --- TRANSACTIONS TITLE ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "TRANSECTIONS",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.1),
                ),
                Icon(Icons.file_download_outlined, color: Colors.grey[400]),
              ],
            ),
          ),

          const Divider(color: Colors.white12, thickness: 1),

          // --- TRANSACTION LIST ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const Text(
                  "MONTH",
                  style: TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildTransactionTile(
                  title: "Advance",
                  date: "01/3/2026",
                  amount: "150",
                  iconPath: Icons.wallet_giftcard_rounded,
                  // Use actual asset image here
                  iconColor: Colors.greenAccent,
                ),
                _buildTransactionTile(
                  title: "Salery",
                  date: "10/4/2026",
                  amount: "10,000",
                  iconPath: Icons.monetization_on_rounded,
                  // Use actual asset image here
                  iconColor: Colors.orangeAccent,
                ),
              ],
            ),
          ),

          // --- FOOTER TOTAL ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            decoration: const BoxDecoration(
              color: Color(0xFF262626),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total transections:",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "₹ 50,000",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
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
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTransactionTile({required String title, required String date, required String amount, required IconData iconPath, required Color iconColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                child: Icon(iconPath, color: iconColor),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(date, style: const TextStyle(color: Colors.white38, fontSize: 12)),
                  ],
                ),
              ),
              Text(
                "₹ $amount",
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(color: Colors.white10, height: 1),
        ],
      ),
    );
  }
}
