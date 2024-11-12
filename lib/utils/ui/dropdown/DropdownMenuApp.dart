import 'package:flutter/material.dart';

import '../../../Themes/MyTheme.dart';

/// Flutter code sample for [DropdownMenu].



class DropdownClearText extends StatefulWidget {

  final List<String> items;
  final TextEditingController controller;
  final String label;

  const DropdownClearText({super.key, required this.items, required this.controller, required this.label});

  @override
  State<DropdownClearText> createState() => _DropdownClearTextState();

}

class _DropdownClearTextState extends State<DropdownClearText> {

  late List<String> items = <String>[''];
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    items = widget.items;
    dropdownValue = items.first;
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Alinea el texto a la izquierda
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: MyTheme.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5), // Espacio entre el texto y el input
          Container(
            decoration: BoxDecoration(
              color: MyTheme.lightGray, // Color del campo de entrada
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.only(left: 15),
            child: DropdownMenu(
              width: double.infinity,
              initialSelection: widget.items.first,
              onSelected: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              dropdownMenuEntries: widget.items.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
              controller: widget.controller,
              inputDecorationTheme: InputDecorationTheme(
                border: InputBorder.none,
                isCollapsed: true,

              ),

            ),
          ),
        ],
      ),
    );

    return DropdownMenu<String>(
      initialSelection: widget.items.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: widget.items.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}