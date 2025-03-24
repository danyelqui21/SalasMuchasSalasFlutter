import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wdevproject/Themes/MyTheme.dart';

class InputPassword extends StatefulWidget {
  final TextEditingController controller;
  final bool initialShowPassword;

  const InputPassword({super.key, required this.controller, this.initialShowPassword = false});

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  late bool showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = widget.initialShowPassword; // Inicializa el estado de la contraseña
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
            "Contraseña",
            style: TextStyle(
              color: MyTheme.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 5), // Espacio entre el texto y el input
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.only(left: 0),
            child: TextField(
              controller: widget.controller,
              // Asigna el controlador
              maxLength: 20,
              obscureText: !showPassword,
              // Cambia la visibilidad de la contraseña
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Ingresa tu contraseña', // Cambié aquí el texto a 'Ingresa tu contraseña'
                hintStyle: TextStyle(color: MyTheme.hintTextColor),
                counterText: '',
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
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility,
                    color: MyTheme.primaryColor // Puedes ajustar el color aquí
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword; // Alterna la visibilidad de la contraseña
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
