import 'package:flutter/material.dart';
import '../viewmodels/weather_viewmodel.dart';
import 'package:provider/provider.dart';

class WeatherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<WeatherViewModel>(context, listen: false).loadWeatherData();
            },
          ),
        ],
      ),
      body: Consumer<WeatherViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (viewModel.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text(viewModel.error),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadWeatherData(),
                    child: Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.weatherList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No hay datos disponibles'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadWeatherData(),
                    child: Text('Cargar Datos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: viewModel.weatherList.length,
            itemBuilder: (context, index) {
              final weather = viewModel.weatherList[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: Icon(
                    Icons.location_city,
                    color: Colors.blue[700],
                    size: 40,
                  ),
                  title: Text(
                    weather.city,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    weather.description,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${weather.temperature.toStringAsFixed(1)}°C',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
