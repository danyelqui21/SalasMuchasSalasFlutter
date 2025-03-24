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
            "Correo electrónico",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: MyTheme.textColor,
            ),
          ),
          SizedBox(height: 6), // Espacio entre el texto y el input
          TextField(
            controller: _phoneController,
            //inputFormatters: [maskFormatter],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'email@example.mx',
              hintStyle: TextStyle(color: MyTheme.hintTextColor),
              filled: true,
              fillColor: MyTheme.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.black, width: 1), // Borde negro más grueso cuando está enfocado
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 0.5), // Borde gris cuando está habilitado
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey, width: 1), // Borde gris por defecto
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10), // Ajustar altura y espacio con los bordes
            ),
            style: TextStyle(fontSize: 16),
          )

        ],
      ),
    );
  }
}
