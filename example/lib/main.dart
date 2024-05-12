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
        ),
        body: Center(
          child: MagicDropdownSearch(
            label: 'Search',
            onChanged: (value) {
              print('Selected value: $value');
            },
            onChangedSearch: (searchTerm) async {
              // Replace this with your own search logic
              return ['Item1', 'Item2', 'Item3'];
            },
            dropdownItems:const  ['Item1', 'Item2', 'Item3'],
            hint: 'Select an item',
            hintSearch: 'Search items',
            initValue: 'Item1',
            buttonWidth: 200,
            itemHeight: 50,
            dropdownHeight: 300,
            buttonHeight: 50,
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}