import 'package:examen1_malf_/home.dart';
import 'package:flutter/material.dart';
import 'util/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  String error = '';



  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(children: [
      Positioned.fill(child: Container(color: fondo, child: CustomPaint(painter: _CustomPainter()))),
      Center(child: LayoutBuilder(
        builder: (context, constraints) => Container(padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: blanco.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          width: constraints.maxWidth * 0.7,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('Bienvenido a tu primer EXAMEN',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: titulos),
              textAlign: TextAlign.center),
            SizedBox(height: 20),
            _buildTextField('Correo/Usuario', userController),
            SizedBox(height: 20),
            _buildTextField('Contraseña', passController, obscureText: true),
            SizedBox(height: 20),
            if (error.isNotEmpty) Text(error, style: TextStyle(color: errorR)),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(backgroundColor: botones, padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.2, vertical: 15)),
              child: Text('Iniciar Sesión', style: TextStyle(color: blanco))
            ),
            SizedBox(height: 10),
            Text('Mi primer examen, ¿estará sencillo?', style: TextStyle(color: blanco))
          ])
        )
      ))
    ])
  );

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) => TextField( obscureText: obscureText, controller: controller,
    decoration: InputDecoration(filled: true, fillColor: blanco, border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: negro),
      ),
      labelText: label,
    ),
    onSubmitted: (value) {
      if (label == 'Contraseña') _login();
    },
  );

  void _login() {
    setState(() {
      error = userController.text.isEmpty || passController.text.isEmpty ? 'Datos incompletos' : userController.text != 'test' ? 'Usuario incorrecto' : passController.text != 'FDM1' ? 'Contraseña incorrecta' : '';
      if (error.isEmpty) Navigator.push( context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }
}

class _CustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint(), colors = [fondo, fondo2, fondo3, fondo4];
    for (int row = 0; row < 3; row++)
      for (int col = 0; col < 4; col++)
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(col * (size.width / 4), row * (size.height / 3), size.width / 4, size.height / 3),
            Radius.circular(20),
          ),
          paint..color = colors[(row + col) % colors.length]
        );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}