import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'dropdown_2.dart';

void main() => runApp(AutocompleteExampleApp());

class AutocompleteExampleApp extends StatelessWidget {
  AutocompleteExampleApp({Key? key}) : super(key: key);
  final TextEditingController  moduleTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Course and Index Selection'),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              //child: Center( // to change alignment, otherwise default at the top
              child: ModuleAutoComplete(moduleTextController),
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Center(
              child: IndexAutoComplete(),
            ),
            )
          ],
        ),
        floatingActionButton: Visibility(
          visible: true,
          child: FloatingActionButton (
            onPressed: (){},
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          )
        ),
      ),
    );
  }
}

@immutable
class User {
  // data
  final String name;
  final String code;

  // constructor
  const User({
    required this.name,
    required this.code,
  });

  // behaviour
  @override
  String toString() {
    return '$code, $name';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User && other.code == code && other.name == name;
  }

  @override
  int get hashCode => hashValues(name, code);
}

class ModuleAutoComplete extends StatelessWidget {
  ModuleAutoComplete(this._typeAheadController, {Key? key}) : super(key: key);

  static const List<User> _userOptions = <User>[
    User(code: 'EE1003', name: 'Introduction to Materials'),
    User(code: 'EE3015', name: 'Power Systems and Conversion'),
    User(code: 'EE2001', name: 'Circuit Analysis and Design'),
    User(code: 'EE3080', name: 'Design and Innovation Project'),
    User(code: 'EE3010', name: 'Electrical and Device'),
    User(code: 'EE2002', name: 'Analog Electronic'),
    User(code: 'EE2003', name: 'Semiconductor Fundamental'),
    User(code: 'EE2008', name: 'Data Structure and Algorithm'),
    User(code: 'EE2007', name: 'Engineering Math 2'),
    User(code: 'PH1012', name: 'Physics A'),
  ];

  TextEditingController _typeAheadController;

  // how to convert a single option (User) into display string
  static String _displayStringForOption(User option) =>
      "${option.code} : ${option.name}"; //string interpolation




  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: true,
        controller: this._typeAheadController,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.normal),
        decoration: InputDecoration(
            labelText: "Please enter module code or name: ",
            suffix: GestureDetector(
                onTap: (){
                  this._typeAheadController.clear();
                },
                child: Icon(Icons.delete_outline)),
            border: OutlineInputBorder()),
      ),
      suggestionsCallback: (pattern /* user input */) async {
        // return await BackendService.getSuggestions(pattern);
        return _userOptions.where(
            (x) => x.toString().toLowerCase().contains(pattern.toLowerCase()));
      },
      itemBuilder: (context, User suggestion) {
        return ListTile(
          leading: Icon(Icons.school),
          title: Text(suggestion.code),
          subtitle: Text(suggestion.name),
          // isThreeLine: true,
        );
      },
      onSuggestionSelected: (User suggestion) {
        this._typeAheadController.text =
            "${suggestion.code} : ${suggestion.name}";
        // input open new dropdown
      },
    //1st dropdown
    );






    // return Autocomplete<User>(
    //     //   // what function is used to display the string
    //     //   displayStringForOption: _displayStringForOption,
    //     //
    //     //
    //     //
    //     //   // how to build the LIST of options
    //     //   optionsBuilder: (TextEditingValue textEditingValue) {
    //     //     if (textEditingValue.text == '') {
    //     //       return const Iterable<User>.empty(); // empty list
    //     //     }
    //     //     return _userOptions.where((User option) {
    //     //       return option
    //     //           .toString()
    //     //           .toLowerCase() //change List to lower case
    //     //           .contains(textEditingValue.text
    //     //               .toLowerCase()); // change input to lowercase
    //     //       //therefore, when both input and list is lowercase, no need worry about problems of caps when searching
    //     //     });
    //     //   },
    //     //
    //     //   // what to do on selection
    //     //   onSelected: (User selection) {
    //     //     // set some stateto the selected value
    //     //     debugPrint('You just selected ${_displayStringForOption(selection)}');
    //     //   },
    //     // );
  }
}

