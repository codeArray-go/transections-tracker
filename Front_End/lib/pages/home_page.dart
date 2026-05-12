import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Deep dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://placekitten.com/100/100'), // Placeholder for user image
          ),
        ),
        title: const Text("@user_vikash", style: TextStyle(color: Colors.white, fontSize: 14)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "DASHBOARD",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
            ),
            const SizedBox(height: 20),

            // --- Financial Report Card ---
            _buildChartCard(),

            const SizedBox(height: 20),

            // --- Payment Stats Cards ---
            _buildStatCard(title: "MAX PAYMENT", amount: "₹ 50,000", date: "30 April"),
            const SizedBox(height: 15),
            _buildStatCard(title: "MIN PAYMENT", amount: "₹ 5000", date: "10 April"),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF222222), borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "REPORT - May",
                style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.chevron_right, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 30),
          // Placeholder for the graph lines seen in image_9ddedd.png
          SizedBox(
            height: 150,
            child: CustomPaint(size: Size.infinite, painter: ChartPlaceholderPainter()),
          ),
          const Text("days", style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String amount, required String date}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF222222), borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white54),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(date, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

// Custom Painter to recreate the "finance/days" axis look from image_9ddedd.png
class ChartPlaceholderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    // Y-Axis
    path.moveTo(size.width * 0.2, 0);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    // X-Axis
    path.lineTo(size.width * 0.8, size.height * 0.8);

    canvas.drawPath(path, paint);

    // Axis labels "finance" rotated
    const textStyle = TextStyle(color: Colors.white70, fontSize: 10);
    final textPainter = TextPainter(
      text: const TextSpan(text: 'finance', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.save();
    canvas.translate(size.width * 0.15, size.height * 0.4);
    canvas.rotate(-1.5708); // Rotate 90 degrees
    textPainter.paint(canvas, Offset(-textPainter.width / 2, 0));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
