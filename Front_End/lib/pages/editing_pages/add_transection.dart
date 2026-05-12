import 'package:flutter/material.dart';
import 'package:front_end/components/input_box_editing_pages.dart';
import 'package:intl/intl.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  String _paymentType = 'Salary';
  String? _selectedMode;
  DateTime? _selectedDate;

  final TextEditingController _dateController = TextEditingController();

  void _showModePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 25),
            const Text(
              "SELECT MODE",
              style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12),
            ),
            const SizedBox(height: 25),
            _buildModeOption("Online", Icons.language_rounded),
            const SizedBox(height: 15),
            _buildModeOption("Offline", Icons.payments_rounded),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildModeOption(String label, IconData icon) {
    return InputBoxEditingPage(
      padding: EdgeInsets.zero,
      child: ListTile(
        onTap: () {
          setState(() => _selectedMode = label);
          Navigator.pop(context);
        },
        leading: Icon(icon, color: Colors.white70),
        title: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 70,
        leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: CircleAvatar(backgroundImage: NetworkImage('https://placekitten.com/100/100')),
        ),
        title: const Text("@user_nalla", style: TextStyle(color: Colors.white, fontSize: 14)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "ADD TRANSACTION",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22, letterSpacing: 1.2),
            ),
            const SizedBox(height: 35),

            // --- PAYMENT TYPE ---
            const Text(
              "Payment Type",
              style: TextStyle(color: Colors.white54, fontSize: 13, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(children: [_buildRadioButton("Salary"), const SizedBox(width: 40), _buildRadioButton("Advance")]),
            const SizedBox(height: 30),

            // --- NAME INPUT ---
            const Custom3DInputField(
              customPrefix: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 10), child: Icon(Icons.person_outline_rounded)),
              hint: "Name",
            ),
            const SizedBox(height: 25),

            // --- AMOUNT & DATE ---
            Row(
              children: [
                Expanded(
                  child: Custom3DInputField(
                    hint: "Amount",
                    isNumber: true,
                    customPrefix: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "₹",
                            style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Container(height: 20, width: 1, color: Colors.white24),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Custom3DInputField(hint: "Date", controller: _dateController, readOnly: true, onTap: () => _selectDate(context), suffixIcon: Icons.calendar_month_rounded),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // --- MODE PICKER ---
            GestureDetector(
              onTap: _showModePicker,
              child: InputBoxEditingPage(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15), // Slimmer padding to match inputs
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedMode ?? "Mode of payment",
                      style: TextStyle(color: _selectedMode == null ? Colors.white38 : Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white38, size: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 45),

            // --- ADD BUTTON ---
            InputBoxEditingPage(
              padding: EdgeInsets.zero,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white12,
                  shadowColor: Colors.transparent,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text(
                  "ADD",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(String title) {
    bool isSelected = _paymentType == title;
    return GestureDetector(
      onTap: () => setState(() => _paymentType = title),
      child: Row(
        children: [
          Container(
            height: 22,
            width: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF121212),
              border: Border.all(color: isSelected ? Colors.white : Colors.white24, width: 2),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(primary: Colors.white, onPrimary: Colors.black, surface: Color(0xFF161616)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }
}
