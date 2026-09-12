import 'package:flutter/material.dart';
import 'package:reveal_slider/reveal_slider.dart';

void main() {
  runApp(const RevealSliderExampleApp());
}

class RevealSliderExampleApp extends StatelessWidget {
  const RevealSliderExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reveal Slider Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ExampleHomePage(),
    );
  }
}

class ExampleHomePage extends StatefulWidget {
  const ExampleHomePage({super.key});

  @override
  State<ExampleHomePage> createState() => _ExampleHomePageState();
}

class _ExampleHomePageState extends State<ExampleHomePage> {
  int _currentLayer = 0;
  Axis _direction = Axis.vertical;

  final List<Color> _colors = [
    const Color(0xFF1E1E2C),
    const Color(0xFF2D142C),
    const Color(0xFF0F3460),
    const Color(0xFF1B262C),
  ];

  final List<String> _titles = [
    'Cyber City 🌃',
    'Neon Sunset 🌅',
    'Deep Ocean 🌊',
    'Space Odyssey 🚀',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Reveal Slider Demo'),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Toggle Direction',
            icon: Icon(
              _direction == Axis.vertical
                  ? Icons.swap_vert
                  : Icons.swap_horiz,
            ),
            onPressed: () {
              setState(() {
                _direction = _direction == Axis.vertical
                    ? Axis.horizontal
                    : Axis.vertical;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. RevealSlider with 4 styled layers
          RevealSlider(
            direction: _direction,
            onLayerChanged: (index) {
              setState(() {
                _currentLayer = index;
              });
            },
            layers: List.generate(
              _titles.length,
              (index) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _colors[index],
                      _colors[(index + 1) % _colors.length],
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _titles[index],
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Layer ${index + 1} of ${_titles.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 2. Overlay Layer indicator at the bottom
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _titles.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentLayer == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentLayer == index
                          ? Colors.cyanAccent
                          : Colors.white30,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

