import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wdevproject/Themes/MyTheme.dart';

class SimpleInput extends StatefulWidget {

  final TextEditingController controller;
  final String label;
  final String placeholder;

  SimpleInput({
    Key? key,
    required this.controller,
    required this.label,
    required this.placeholder}) : super(key: key);

  @override
  _SimpleInput createState() => _SimpleInput();
}

class _SimpleInput extends State<SimpleInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinea el texto a la izquierda
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: MyTheme.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 5), // Espacio entre el texto y el input
            Container(
              decoration: BoxDecoration(
                color: MyTheme.lightGray, // Color del campo de entrada
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                controller: widget.controller, // Asigna el controlador
                maxLength: 20,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(color: MyTheme.hintTextColor),
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 6),
                )
              ),
            )
        ],
      ),
    );
  }
}
