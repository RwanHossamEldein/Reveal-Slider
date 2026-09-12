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

  final List<Map<String, String>> _characters = [
    {
      'name': 'Batman 🦇',
      'image': 'assets/batman.jpg',
    },
    {
      'name': 'Spider-Man 🕷️',
      'image': 'assets/spiderman.jpg',
    },
    {
      'name': 'Detective Conan 🔍',
      'image': 'assets/conan.jpg',
    },
    {
      'name': 'Squidward (Shafiq) 🐙',
      'image': 'assets/shafiq.jpg',
    },
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
              _direction == Axis.vertical ? Icons.swap_vert : Icons.swap_horiz,
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
          // 1. RevealSlider with 4 character image layers
          RevealSlider(
            direction: _direction,
            onLayerChanged: (index) {
              setState(() {
                _currentLayer = index;
              });
            },
            layers: _characters.map((item) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                  ),
                  // Dark gradient overlay at bottom for readability
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),

          // 2. Overlay Layer indicator & character name at the bottom
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _characters[_currentLayer]['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _characters.length,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
