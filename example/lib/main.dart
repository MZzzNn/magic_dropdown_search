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
          child: Column(
            children: [
              MagicDropdownSearch(
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
                dropdownBoxDecoration: DropDownBoxDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.blue,
                      width: 1,
                    ),
                  ),
                ),
              ),
              Spacer(),
              MagicDropdownSearch(
                // label: 'Search',
                onChanged: (value) {
                  print('Selected value: $value');
                },
                onChangedSearch: (searchTerm) async {
                  // Replace this with your own search logic
                  return ['Item1 sssssssssssss', 'Item2', 'Item3'];
                },
                dropdownItems:const  ['Item1 sssssssssssss', 'Item2', 'Item3'],
                // hint: 'Select an item',
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
                itemBuilder: (item, isSelected) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red.withOpacity(0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        if (isSelected) ...[
                          const Icon(
                            Icons.check,
                            size: 16,
                            color: Color(0xff111111),
                          ),
                          const SizedBox(width: 7.5),
                        ],
                        Expanded(
                          child: Text(
                            item,
                            maxLines: 3,
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: const Color(0xff111111), fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                buttonDecoration: const InputDecoration(
                  hintText: 'Select an item',
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  labelStyle: TextStyle(color: Colors.blue),
                  errorStyle: TextStyle(color: Colors.red),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}