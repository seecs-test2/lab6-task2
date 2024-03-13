import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SavedSuggestionsScreen()),
            );
          },
          child: Text("Go to Saved Suggestions"),
        ),
      ),
    );
  }
}

class SavedSuggestionsScreen extends StatefulWidget {
  @override
  _SavedSuggestionsScreenState createState() => _SavedSuggestionsScreenState();
}

class _SavedSuggestionsScreenState extends State<SavedSuggestionsScreen> {
  List<String> savedSuggestions = [
    "Mango",
    "Apple",
    "Banana",
    "Orange",
    "Gaddapes",
    "Grapes",
    "Pineapple",
    "Papaya",
    "Watermelon",
    "Kiwi",
    "DragonFruit",
    "Jammun",
    "Loocat",
    "Pomegranate",
    "Guava",
    "Cherry",
    "Strawberry",
    "Blueberry",
    "Raspberry",
    "Blackberry",
    "Cranberry",
    "Gooseberry",
    "Apricot",
    "Peach",
    "Plum",
    "Pear",
    "Lychee",
    "Lemon",
    "Lime",
    "Coconut",
    "Pineapple",
    "Papaya"
  ];

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Suggestions"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              if (selectedItems.isNotEmpty) {
                _showConfirmationDialog();
              } else {
                _showSnackBar("No Item Selected");
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: savedSuggestions.length,
        itemBuilder: (context, index) {
          final item = savedSuggestions[index];
          final isSelected = selectedItems.contains(item);

          return ListTile(
            title: Text(item),
            trailing: isSelected ? Icon(Icons.check) : null,
            onTap: () {
              _toggleItemSelection(item);
            },
          );
        },
      ),
    );
  }

  void _toggleItemSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Selected Items?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to remove the selected items from the list?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Remove the selected items from the list
                setState(() {
                  savedSuggestions
                      .removeWhere((item) => selectedItems.contains(item));
                  selectedItems.clear();
                });

                // Set the state of the removed items to "unselected" in the Startup Name Generator list
                // Add your logic here to update the state in the Startup Name Generator list

                // Dismiss the dialog and navigate back to the home screen
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                // Dismiss the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
