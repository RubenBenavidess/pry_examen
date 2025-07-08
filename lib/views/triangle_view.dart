import 'package:flutter/material.dart';
import '../viewmodels/triangle_viewmodel.dart';
import 'package:provider/provider.dart';

class TriangleClassifierView extends StatelessWidget {
  final TextEditingController _side1Controller = TextEditingController();
  final TextEditingController _side2Controller = TextEditingController();
  final TextEditingController _side3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clasificador de Triángulos'),
      ),
      body: Consumer<TriangleViewModel>(
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
                          'Ingresa los 3 lados del triángulo',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _side1Controller,
                          decoration: InputDecoration(
                            labelText: 'Lado 1',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.straighten),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _side2Controller,
                          decoration: InputDecoration(
                            labelText: 'Lado 2',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.straighten),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _side3Controller,
                          decoration: InputDecoration(
                            labelText: 'Lado 3',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.straighten),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: viewModel.isLoading ? null : () => _classifyTriangle(context, viewModel),
                          child: viewModel.isLoading
                              ? CircularProgressIndicator()
                              : Text('Clasificar Triángulo'),
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
                if (viewModel.triangle != null)
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Resultado:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            viewModel.getTriangleTypeText(viewModel.triangle!.type),
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

    void _classifyTriangle(BuildContext context, TriangleViewModel viewModel) {
    try {
      double side1 = double.parse(_side1Controller.text);
      double side2 = double.parse(_side2Controller.text);
      double side3 = double.parse(_side3Controller.text);

      if (side1 <= 0 || side2 <= 0 || side3 <= 0) {
        throw Exception('Los lados deben ser positivos');
      }

      viewModel.classifyTriangle(side1, side2, side3);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor ingresa números válidos y positivos'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
