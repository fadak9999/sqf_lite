
import 'package:flutter/material.dart';
import 'package:sqf_lite/sqflite2.dart';

class Home1 extends StatefulWidget {
  const Home1({super.key});

  @override
  State<Home1> createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  ///
  SqlDb2 sqlDb = SqlDb2();
  List<Map<String, dynamic>> _textsList = [];

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // تحميل البيانات من قاعدة البيانات
  void _loadData() async {
    List<Map<String, dynamic>> response = await sqlDb.readData("SELECT * FROM notes");
    setState(() {
      _textsList = response;
    });
  }

  // إضافة النصوص وحفظها في قاعدة البيانات
  void _addTexts() async {
    String text1 = _controller1.text;
    String text2 = _controller2.text;
    String text3 = _controller3.text;

    if (text1.isNotEmpty && text2.isNotEmpty && text3.isNotEmpty) {
      await sqlDb.insertData(
          "INSERT INTO notes (text1, text2, text3) VALUES (?, ?, ?)",[text1, text2, text3]);

      _loadData();// تحديث البيانات بعد الإضافة
      _controller1.clear();
      _controller2.clear();
      _controller3.clear();
    }
  }
////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(129, 1, 179, 161),
        title: const Text("Text Storage with Sqflite"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller1,
              decoration: const InputDecoration(labelText: 'Enter first text'),
            ),
            TextField(
              controller: _controller2,
              decoration: const InputDecoration(labelText: 'Enter second text'),
            ),
            TextField(
              controller: _controller3,
              decoration: const InputDecoration(labelText: 'Enter third text'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addTexts,
              child: const Text('Add Texts'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _textsList.length,
                itemBuilder: (context, index) {
                  final note = _textsList[index];
                  final id = note['id'];
                  return InkWell(
                    onLongPress: () async {
                      await sqlDb.deleteDataById(id);
                      _loadData(); // تحديث البيانات بعد الحذف
                    },
                    child: Card(
                      elevation: 10,
                      color: const Color.fromARGB(131, 95, 183, 158),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(note['text1'] ?? '', textAlign: TextAlign.center),
                            const SizedBox(height: 5),
                            Text(note['text2'] ?? '', textAlign: TextAlign.center),
                            const SizedBox(height: 5),
                            Text(note['text3'] ?? '', textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
