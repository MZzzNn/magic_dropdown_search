import 'package:flutter/material.dart';
import 'package:magic_dropdown_search/magic_dropdown_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Magic Dropdown Search Example'),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: MagicDropdownSearch(
                  // label: 'Search',
                  onChanged: (value) {
                    print('Selected value: $value');
                  },
                  onChangedSearch: (searchTerm) async {
                    // Replace this with your own search logic
                    return ['Item1', 'Item2', 'Item3'];
                  },
                  dropdownItems:const  ['Item1', 'Item2', 'Item3'],
                  // hint: 'Select an item',
                  hintSearch: 'Search items',
                  initValue: 'Item1',
                  // buttonWidth: 200,
                  itemHeight: 50,
                  dropdownHeight: 200,
                  // buttonHeight: 50,
                  buttonDecoration: const InputDecoration(
                    hintText: 'Select an item',
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    labelStyle: TextStyle(color: Colors.blue),
                    errorStyle: TextStyle(color: Colors.red),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Expanded(
                child: MagicDropdownSearch(
                  // label: 'Search',
                  onChanged: (value) {
                    print('Selected value: $value');
                  },
                  onChangedSearch: (searchTerm) async {
                    // Replace this with your own search logic
                    return ['Item1', 'Item2', 'Item3'];
                  },
                  dropdownItems:const  ['Item1', 'Item2', 'Item3'],
                  // hint: 'Select an item',
                  hintSearch: 'Search items',
                  initValue: 'Item1',
                  // buttonWidth: 200,
                  itemHeight: 50,
                  dropdownHeight: 200,
                  // buttonHeight: 50,
                  searchDecoration: const InputDecoration(
                    hintText: 'Search',
                    labelText: 'Search',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.search),
                    labelStyle: TextStyle(color: Colors.blue),
                    errorStyle: TextStyle(color: Colors.red),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  buttonDecoration: const InputDecoration(
                    hintText: 'Select an item',
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    labelStyle: TextStyle(color: Colors.blue),
                    errorStyle: TextStyle(color: Colors.red),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}