import 'package:flutter/material.dart';
import 'package:front_end/components/input_box_editing_pages.dart';
import 'package:intl/intl.dart';

class AddAttendancePage extends StatefulWidget {
  const AddAttendancePage({super.key});

  @override
  State<AddAttendancePage> createState() => _AddAttendancePageState();
}

class _AddAttendancePageState extends State<AddAttendancePage> {
  String? _selectedWorker;
  String? _selectedOvertime;
  String? _selectedPresent;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // Dummy List of 10+ Workers
  final List<String> _dummyWorkers = ["Vikash", "Akhil", "Rohit", "Mahip", "Simpoly", "Sultan", "Kheer", "Raju", "Sham", "Baburao", "Anuradha"];

  // --- SCROLLABLE WORKER NAME PICKER ---
  void _showPicker(String title, List<String> options, String? currentValue, Function(String) onSelect) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
        decoration: BoxDecoration(
          color: const Color(0xFF121212),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 25),
            // Title
            Text(
              title.toUpperCase(),
              style: const TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12),
            ),
            const SizedBox(height: 25),

            // --- SCROLLABLE LIST AREA ---
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InputBoxEditingPage(
                      padding: EdgeInsets.zero,
                      child: ListTile(
                        onTap: () {
                          onSelect(option);
                          Navigator.pop(context);
                        },
                        title: Text(
                          option,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        trailing: currentValue == option
                            ? const Icon(Icons.check_circle_rounded, color: Colors.greenAccent, size: 20)
                            : const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // --- DATE PICKER  ---
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

  // --- TIME PICKER ---
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(primary: Colors.white, onPrimary: Colors.black, surface: Color(0xFF161616)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
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
        title: const Text("@user_vikash", style: TextStyle(color: Colors.white, fontSize: 14)),
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
              "ADD ATTENDENCE",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22, letterSpacing: 1.2),
            ),
            const SizedBox(height: 35),

            // --- WORKER'S NAME DROPDOWN ---
            _buildDropdownSelector(
              hint: "Worker's Name",
              value: _selectedWorker,
              onTap: () => _showPicker("Select Worker", _dummyWorkers, _selectedWorker, (val) => setState(() => _selectedWorker = val)),
            ),
            const SizedBox(height: 20),

            // --- OVERTIME & PRESENT ROW ---
            Row(
              children: [
                Expanded(
                  child: _buildDropdownSelector(
                    hint: "Overtime",
                    value: _selectedOvertime,
                    onTap: () => _showPicker("Overtime Status", ["Yes", "No"], _selectedOvertime, (val) => setState(() => _selectedOvertime = val)),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildDropdownSelector(
                    hint: "Present",
                    value: _selectedPresent,
                    onTap: () => _showPicker("Attendance Status", ["Full Day", "Half Day", "Absent"], _selectedPresent, (val) => setState(() => _selectedPresent = val)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- DATE INPUT ---
            Custom3DInputField(hint: "Date", controller: _dateController, readOnly: true, onTap: () => _selectDate(context), suffixIcon: Icons.calendar_month_rounded),
            const SizedBox(height: 20),

            // --- DAY END TIME INPUT ---
            Custom3DInputField(hint: "Day End", controller: _timeController, readOnly: true, onTap: () => _selectTime(context), suffixIcon: Icons.access_time_rounded),

            const SizedBox(height: 45), // Maintained spacing before the button
            // --- ADD BUTTON ---
            InputBoxEditingPage(
              padding: EdgeInsets.zero,
              child: ElevatedButton(
                onPressed: () {
                  // Add logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
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

  // --- HELPER: 3D DROPDOWN SELECTOR ---
  Widget _buildDropdownSelector({required String hint, required String? value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: InputBoxEditingPage(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value ?? hint,
              style: TextStyle(color: value == null ? Colors.white38 : Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white38, size: 20),
          ],
        ),
      ),
    );
  }
}
