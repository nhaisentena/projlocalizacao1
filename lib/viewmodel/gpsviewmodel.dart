import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../model/posicion.dart';

class GpsViewModel extends ChangeNotifier {
  double _velocidad = 0.0;
  double _distanciaTotal = 0.0;
  Position? _ultimaPosicion;
  late Stream<Position> _streamPosiciones;

  final ValueNotifier<PositionData> datos = ValueNotifier(PositionData(velocidad: 0, distancia: 0));

  GpsViewModel() {
    _inicializar();
  }

  Future<void> _inicializar() async {
    final habilitado = await Geolocator.isLocationServiceEnabled();
    if (!habilitado) return;

    LocationPermission permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }

    if (permiso == LocationPermission.whileInUse || permiso == LocationPermission.always) {
      _streamPosiciones = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 5,
        ),
      );

      _streamPosiciones.listen((nuevaPosicion) {
        _actualizarDatos(nuevaPosicion);
      });
    }
  }

  void _actualizarDatos(Position nuevaPosicion) {
    if (_ultimaPosicion != null) {
      double distancia = Geolocator.distanceBetween(
        _ultimaPosicion!.latitude,
        _ultimaPosicion!.longitude,
        nuevaPosicion.latitude,
        nuevaPosicion.longitude,
      );
      _distanciaTotal += distancia / 1000;
    }

    _velocidad = nuevaPosicion.speed * 3.6;
    _ultimaPosicion = nuevaPosicion;

    datos.value = PositionData(
      velocidad: _velocidad,
      distancia: _distanciaTotal,
    );
  }

  void reiniciar() {
    _velocidad = 0.0;
    _distanciaTotal = 0.0;
    _ultimaPosicion = null;
    datos.value = PositionData(velocidad: 0, distancia: 0);
    notifyListeners();
  }
}
