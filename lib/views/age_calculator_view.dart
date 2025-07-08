import 'package:flutter/material.dart';
import '../viewmodels/age_viewmodel.dart';
import 'package:provider/provider.dart';

class AgeCalculatorView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Edad'),
      ),
      body: Consumer<AgeViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Ingresa tu fecha de nacimiento',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: 'Fecha (YYYY-MM-DD)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: viewModel.isLoading ? null : () => _calculateAge(context, viewModel),
                          child: viewModel.isLoading
                              ? CircularProgressIndicator()
                              : Text('Calcular Edad'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (viewModel.ageResult != null)
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Tu edad es:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${viewModel.ageResult!.years} años, ${viewModel.ageResult!.months} meses, ${viewModel.ageResult!.days} días',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _calculateAge(BuildContext context, AgeViewModel viewModel) {
    try {
      DateTime birthDate = DateTime.parse(_controller.text);
      viewModel.calculateAge(birthDate);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Formato de fecha inválido. Use YYYY-MM-DD'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
