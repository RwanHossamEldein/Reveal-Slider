import 'package:animated_scanner/glow_bar.dart';
import 'package:animated_scanner/my_custom_clipper.dart';
import 'package:flutter/material.dart';

class RevealSlider extends StatefulWidget {
  final List<Widget> layers;
  final Axis direction;

  const RevealSlider({
    super.key,
    required this.layers,
    this.direction = Axis.vertical,
  });

  @override
  State<RevealSlider> createState() => _RevealSliderState();
}

class _RevealSliderState extends State<RevealSlider> {
  int _currentIndex = 0;
  final ValueNotifier<double> position = ValueNotifier<double>(0.0);
  bool _isInitialized = false;

  // true: Swipe Down/Right to reveal the next item
  // false: Swipe Up/Left to reveal the next item.
  bool _revealFromStart = true;

  @override
  void dispose() {
    position.dispose();
    super.dispose();
  }

  void _updatePosition(Offset localPosition, BoxConstraints constraints) {
    final totalSize = widget.direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;

    final currentTouch = widget.direction == Axis.horizontal
        ? localPosition.dx
        : localPosition.dy;

    position.value = currentTouch.clamp(0.0, totalSize);

    if (_revealFromStart) {
      if (position.value >= totalSize - 2.0) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.layers.length;
          _revealFromStart = false;
        });
      }
    } else {
      if (position.value <= 2.0) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.layers.length;
          _revealFromStart = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.direction == Axis.horizontal;

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (!_isInitialized) {
            position.value = 0.0;
            _isInitialized = true;
          }

          return Listener(
            onPointerMove: (event) =>
                _updatePosition(event.localPosition, constraints),
            onPointerHover: (event) =>
                _updatePosition(event.localPosition, constraints),
            child: ValueListenableBuilder<double>(
              valueListenable: position,
              builder: (context, currentPos, child) {
                final baseIndex = _currentIndex;
                final nextIndex = (_currentIndex + 1) % widget.layers.length;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    widget.layers[baseIndex],

                    ClipRect(
                      clipper: MyCustomClipper(
                        position: currentPos,
                        direction: widget.direction,
                        revealFromStart: _revealFromStart,
                      ),
                      child: widget.layers[nextIndex],
                    ),

                    if (isHorizontal)
                      Positioned(
                        left: currentPos - 1.5,
                        top: 0,
                        bottom: 0,
                        width: 3,
                        child: const GlowBar(),
                      )
                    else
                      Positioned(
                        top: currentPos - 1.5,
                        left: 0,
                        right: 0,
                        height: 3,
                        child: const GlowBar(),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
