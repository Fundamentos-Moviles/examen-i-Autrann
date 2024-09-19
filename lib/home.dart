import 'package:flutter/material.dart';
import 'util/constants.dart';
import 'more_info.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> listaDinamica = List.from(listaExamen);

  void _navigateToMoreInfo() => Navigator.push(
      context, MaterialPageRoute(builder: (_) => MoreInfoScreen()));

  void _handleDelete(int id, int index) {
    [10, 15, 20, 23].contains(id) ? _showSnackBar('No se puede eliminar el ID: $id') : setState(() {
            listaDinamica.removeAt(index + 1);
            _showSnackBar('Elemento con ID: $id eliminado');
          });
  }

  void _showSnackBar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: fondo,
        appBar: _customAppBar(),
        body: _buildBody(),
        bottomNavigationBar: BottomAppBar(
          color: fondo2,
          child: SizedBox(
            height: 35,
            child: Center(
              child: Text( 'SEGUNDA VISTA: MONTES AUTRAN LUIS FERNANDO',
                style: TextStyle(color: titulos, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );

  PreferredSize _customAppBar() => PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            color: blanco,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [BoxShadow(color: blanco.withOpacity(0.3), spreadRadius: 5, blurRadius: 15, offset: Offset(0, 5))],
          ),
          child: AppBar(
            backgroundColor: transparente,
            elevation: 0,
            title: Text('Notificaciones de actividades', style: TextStyle(color: titulos, fontWeight: FontWeight.bold, fontSize: 20)),
            centerTitle: true,
          ),
        ),
      );

  Widget _buildBody() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: listaDinamica.length - 1,
          itemBuilder: (context, index) {
            int id = 10 + index;
            var data = listaDinamica[index + 1].split(' # ');
            var showButtons = index % 2 == 1;
            return _buildRow(id, data[2], data[3], int.parse(data[4]), showButtons, index);
          },
        ),
      );

  Widget _buildRow(int id, String title, String description, int stars, bool showButtons, int index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCard(
                onTap: showButtons ? null : _navigateToMoreInfo,
                child: _buildCardContent(id, title, description, _buildStarRating(stars)),
              ),
              if (showButtons) ...[
                SizedBox(width: 10),
                _buildCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _button(Icons.edit, 'Ver más', _navigateToMoreInfo),
                      SizedBox(height: 10),
                      _button(Icons.delete, 'Borrar', () => _handleDelete(id, index)),
                    ],
                  ),
                  flex: 1,
                ),
              ]
            ],
          ),
        ),
      );

  Widget _button(IconData icon, String label, VoidCallback onPressed) => ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: blanco),
        label: Text(label, style: TextStyle(color: blanco)),
        style: ElevatedButton.styleFrom(backgroundColor: botonesHome, minimumSize: Size(double.infinity, 40)),
      );

  Widget _buildStarRating(int stars) => Row(
        children: List.generate(5, (index) => Icon(index < stars ? Icons.star : Icons.star_border, color: starsC)),
      );

  Widget _buildCardContent(int id, String title, String description, Widget stars) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$id', style: TextStyle(fontSize: 24, color: fondo)),
                SizedBox(height: 8),
                Text(title, style: TextStyle(fontSize: 16, color: negro)),
                Text('Nota: $description', style: TextStyle(fontSize: 14, color: letrasDif)),
                SizedBox(height: 10),
                stars,
              ],
            ),
          ),
          Positioned(top: 8, right: 8, child: Icon(Icons.eco, color: efectos)),
        ],
      );

  Widget _buildCard({required Widget child, GestureTapCallback? onTap, int flex = 3}) => Expanded(
        flex: flex,
        child: GestureDetector(onTap: onTap, child: Card(color: blanco, child: child)),
      );
}
