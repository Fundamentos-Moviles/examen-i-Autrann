import 'package:flutter/material.dart';
import 'util/constants.dart'; 

class MoreInfoScreen extends StatefulWidget {
  @override
  _MoreInfoScreenState createState() => _MoreInfoScreenState();
}

class _MoreInfoScreenState extends State<MoreInfoScreen> {
  List<List<int>> rows = [];
  int currentRowCount = 0, maxRectsPerRow = 12;

  void _addRectangle() => setState(() => currentRowCount < maxRectsPerRow ? currentRowCount++ : {rows.add(List.filled(maxRectsPerRow, 1)), currentRowCount = 1});

Widget _buildRow(int count, int rowIndex) => Row(
  children: List.generate(count, (i) {
    List<Color> scheme = [ [fondo3, fondo4], [blanco, negro], [errorR, letrasDif], [starsC, efectos]][rowIndex % 4]; //Si, reutilice los colores
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2), height: 100,
        color: scheme[i % 2], 
      ),
    );
  }),
);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: fondo,
    body: Column(
      children: [
        ElevatedButton(
          onPressed: _addRectangle,
          style: ElevatedButton.styleFrom(backgroundColor: botonesHome),
          child: Text('Iniciar sesion', style: TextStyle(color: blanco)),
        ),
        Expanded(
          child: ListView(
            children: [
              ...rows.asMap().entries.map((e) => _buildRow(maxRectsPerRow, e.key)),
              _buildRow(currentRowCount, rows.length)
            ],
          ),
        ),
      ],
    ),
  );
}
