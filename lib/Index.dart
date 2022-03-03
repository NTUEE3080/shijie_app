import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

void main() => runApp(const AutocompleteExampleApp());

class AutocompleteExampleApp extends StatelessWidget {
  const AutocompleteExampleApp({Key? key}) : super(key: key);

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
              child: IndexAutoComplete(),
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: IndexAutoComplete(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

@immutable
class User2 {
  // data
  final String time;
  final String index;

  // constructor
  const User2({
    required this.time,
    required this.index,
  });

  // behaviour
  @override
  String toString() {
    return '$index, $time';
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is User2 && other.index == index && other.time == time;
  }

  @override
  int get hashCode => hashValues(time, index);
}

class IndexAutoComplete extends StatelessWidget {
  IndexAutoComplete({Key? key}) : super(key: key);

  static const List<User2> _userOptions = <User2>[
    User2(index: '12345', time: '1330 - 1530'),
    User2(index: '12346', time: '1030 - 1230'),
    User2(index: '13456', time: '0930 - 1130'),
    User2(index: '12566', time: '1430 - 1630'),
    User2(index: '64646', time: '1330 - 1530'),
    User2(index: '64035', time: '0830 - 1030'),
    User2(index: '87218', time: '0930 - 1030'),
    User2(index: '78854', time: '0930 - 1030'),
    User2(index: '36548', time: '1530 - 1700'),
  ];

  final TextEditingController _typeAheadController2 = TextEditingController();

  // how to convert a single option (User) into display string
  static String _displayStringForOption(User2 option) =>
      "${option.index} : ${option.time}"; //string interpolation

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: false,
        controller: this._typeAheadController2,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.normal),
        decoration: InputDecoration(
            labelText: "Please enter index code or 24 hour time eg. 1300 for 1pm",
            suffix: GestureDetector(
                onTap: () {
                  this._typeAheadController2.clear();
                },
                child: Icon(Icons.delete_outline)),
            border: OutlineInputBorder()),
      ),
      suggestionsCallback: (pattern /* user input */) async {
        // return await BackendService.getSuggestions(pattern);
        return _userOptions.where(
                (x) => x.toString().toLowerCase().contains(pattern.toLowerCase()));
      },
      itemBuilder: (context, User2 suggestion) {
        return ListTile(
          leading: Icon(Icons.book),
          title: Text(suggestion.index),
          subtitle: Text(suggestion.time),
          // isThreeLine: true,
        );
      },
      onSuggestionSelected: (User2 suggestion) {
        this._typeAheadController2.text =
        "${suggestion.index} : ${suggestion.time}";
        // input open new dropdown
      },

    );
  }}
//2nd dropdown