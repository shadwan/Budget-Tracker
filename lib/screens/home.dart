import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/home_page.dart';
import '../pages/profile_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  List<Widget> pages = const [
    HomePage(),
    ProfilePage(),
  ];

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: IconButton(
              icon: const Icon(Icons.attach_money),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddBudgetDialog(
                      budgetToAdd: (budget) {},
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}

class AddBudgetDialog extends StatefulWidget {
  final Function(double) budgetToAdd;
  const AddBudgetDialog({super.key, required this.budgetToAdd});

  @override
  State<AddBudgetDialog> createState() => _AddBudgetDialogState();
}

class _AddBudgetDialogState extends State<AddBudgetDialog> {
  final TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Add a budget",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(hintText: "Budget in \$"),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                if (amountController.text.isNotEmpty) {
                  widget.budgetToAdd(double.parse(amountController.text));
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    ));
  }
}
