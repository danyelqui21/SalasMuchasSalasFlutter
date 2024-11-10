import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:wdevproject/Themes/MyTheme.dart';

class SimpleInputPhone extends StatefulWidget {
  @override
  _SimplePhoneInputState createState() => _SimplePhoneInputState();
}

class _SimplePhoneInputState extends State<SimpleInputPhone> {
  final TextEditingController _phoneController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    mask: '(###) ###-####', // Define la máscara
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Número de teléfono",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyTheme.textColor,
            ),
          ),
          SizedBox(height: 5), // Espacio entre el texto y el input
          TextField(
            controller: _phoneController,
            inputFormatters: [maskFormatter],
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: '(XXX) XXX-XXXX',
              hintStyle: TextStyle(color: MyTheme.hintTextColor),
              filled: true,
              fillColor: MyTheme.lightGray,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 21),
            ),
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
