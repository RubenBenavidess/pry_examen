import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/age_viewmodel.dart';
import 'viewmodels/triangle_viewmodel.dart';
import 'viewmodels/weather_viewmodel.dart';
import 'views/age_calculator_view.dart';
import 'views/triangle_view.dart';
import 'views/weather_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AgeViewModel()),
        ChangeNotifierProvider(create: (_) => TriangleViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ],
      child: MaterialApp(
        title: 'Mi Aplicación Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            elevation: 4,
          ),
        ),
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AgeCalculatorView(),
    TriangleClassifierView(),
    WeatherView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            label: 'Edad',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_history),
            label: 'Triángulo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'Clima',
          ),
        ], 
      ),
    );
  }
}
