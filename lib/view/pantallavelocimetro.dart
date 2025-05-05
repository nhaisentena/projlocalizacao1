import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../viewmodel/gpsviewmodel.dart';
import '../model/posicion.dart';

class VelocimetroPantalla extends StatefulWidget {
  @override
  State<VelocimetroPantalla> createState() => _VelocimetroPantallaState();
}

class _VelocimetroPantallaState extends State<VelocimetroPantalla> {
  final GpsViewModel _viewModel = GpsViewModel();
  final NumberFormat _formatter = NumberFormat("#0.00", "es");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Velocímetro y Odómetro',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ValueListenableBuilder<PositionData>(
          valueListenable: _viewModel.datos,
          builder: (_, datos, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://static.vecteezy.com/system/resources/previews/009/385/477/non_2x/speedometer-clipart-design-illustration-free-png.png',
                  width: 120,
                  height: 120,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 80, color: Colors.red),
                ),
                SizedBox(height: 20),
                _panelDato("Velocidad", "${_formatter.format(datos.velocidad)} km/h"),
                SizedBox(height: 40),
                _panelDato("Distancia", "${_formatter.format(datos.distancia)} km"),
                SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: _viewModel.reiniciar,
                  icon: Icon(Icons.restart_alt, color: Colors.white),
                  label: Text(
                    "Reiniciar Odómetro",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _panelDato(String titulo, String valor) {
    return Column(
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[700]),
        ),
        SizedBox(height: 10),
        Text(
          valor,
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}
