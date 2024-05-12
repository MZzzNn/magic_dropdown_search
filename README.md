# Magic Dropdown Search

Magic Dropdown Search is a Flutter package that provides a dropdown search functionality with dynamic data from an API.

## Description

This package allows you to create a dropdown search with select feature. It is designed to be easy to use and customizable to fit your needs. The package is built with Dart and uses Flutter framework.

## Installation

To use this package, add `magic_dropdown_search` as a [dependency in your pubspec.yaml file](https://flutter.dev/docs/development/packages-and-plugins/using-packages).

```yaml
dependencies:
  magic_dropdown_search: ^0.0.1
```

## Usage

Here is a basic example of how to use `magic_dropdown_search` package:


```dart
import 'package:flutter/material.dart';
import 'package:magic_dropdown_search/magic_dropdown_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Magic Dropdown Search Example'),
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
            dropdownItems: ['Item1', 'Item2', 'Item3'],
            hint: 'Select an item',
            hintSearch: 'Search items',
            initValue: 'Item1',
            buttonWidth: 200,
            itemHeight: 50,
            dropdownHeight: 300,
            buttonHeight: 50,
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
```

## Features

- Dynamic data 
- Search functionality within the dropdown
- Loading Data from API
- Essential customization options


## Contribution

Contributions of any kind are more than welcome! Feel free to fork and improve magic_dropdown_search in any way you want, make a pull request, or open an issue.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.



