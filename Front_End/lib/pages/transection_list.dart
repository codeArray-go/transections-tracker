import 'package:flutter/material.dart';

class TransectionList extends StatelessWidget {
  const TransectionList({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data Generation
    final List<Map<String, dynamic>> transactions = List.generate(25, (index) {
      bool isSalary = index % 3 == 0;
      return {
        "sr": index + 1,
        "name": index % 2 == 0 ? "User $index" : "Employee $index",
        "amount": isSalary ? 15000 : 500,
        "type": isSalary ? "Salery" : "Advance",
        "date": "${index + 1}/05/2026",
        "mop": index % 2 == 0 ? "UPI" : "Cash",
        "phone": "98765${100 + index}",
      };
    });

    int totalAdvance = transactions.where((t) => t['type'] == 'Advance').fold(0, (sum, item) => sum + (item['amount'] as int));

    int totalSalary = transactions.where((t) => t['type'] == 'Salary').fold(0, (sum, item) => sum + (item['amount'] as int));

    return Container(
      color: const Color(0xFF0D0D0D),
      child: SafeArea(
        child: Column(
          children: [
            // --- HEADER ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "TRANSACTIONS",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22, letterSpacing: 1.5, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Container(height: 2, width: 30, color: Colors.blueAccent),
                    ],
                  ),
                  // PDF Download Button
                  GestureDetector(
                    onTap: () {
                      // Logic for PDF download goes here
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.picture_as_pdf_rounded, color: Colors.redAccent, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "PDF",
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- DATA TABLE ---
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: DataTable(
                    columnSpacing: 40,
                    headingRowHeight: 50,
                    dataRowMaxHeight: 60,
                    horizontalMargin: 20,

                    // TABLE LINES
                    border: TableBorder.all(color: Colors.white24, width: 0.5),
                    headingTextStyle: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1),
                    columns: const [
                      DataColumn(label: Text('SR.')),
                      DataColumn(label: Text('NAME')),
                      DataColumn(label: Text('AMOUNT')),
                      DataColumn(label: Text('TYPE')),
                      DataColumn(label: Text('MOP')),
                      DataColumn(label: Text('PHONE')),
                      DataColumn(label: Text('DATE')),
                    ],
                    rows: transactions.map((data) {
                      bool isAdvance = data['type'] == "Advance";
                      return DataRow(
                        cells: [
                          DataCell(Text("${data['sr']}", style: const TextStyle(color: Colors.white60))),
                          DataCell(
                            Text(
                              data['name'],
                              style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.w500),
                            ),
                          ),
                          DataCell(
                            Text(
                              "₹${data['amount']}",
                              style: const TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: isAdvance ? Colors.orange.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                data['type'],
                                style: TextStyle(color: isAdvance ? Colors.orangeAccent : Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataCell(Text(data['mop'], style: const TextStyle(color: Colors.white60))),
                          DataCell(Text(data['phone'], style: const TextStyle(color: Colors.white60))),
                          DataCell(Text(data['date'], style: const TextStyle(color: Colors.white60, fontSize: 11))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // --- FOOTER ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                border: Border(top: BorderSide(color: Colors.white10)),
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 15, offset: const Offset(0, -5))],
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        "TOTAL",
                        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                  _buildFooterDivider(),
                  _buildTotalSection("ADVANCE", "₹$totalAdvance", Colors.orangeAccent),
                  _buildFooterDivider(),
                  _buildTotalSection("SALARY", "₹$totalSalary", Colors.greenAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- FOOTER HELPER ---
  Widget _buildFooterDivider() {
    return Container(height: 30, width: 1, color: Colors.white24);
  }

  Widget _buildTotalSection(String label, String value, Color color) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
