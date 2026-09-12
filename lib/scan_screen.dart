import 'package:animated_scanner/glow_bar.dart';
import 'package:animated_scanner/my_custom_clipper.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  final List<Widget> layers; // قائمة بالصور أو الـ Widgets (3 أو أكثر)
  final Axis direction; // اتجاه المسح (أفقي أو رأسي)

  const ScanScreen({
    super.key,
    required this.layers,
    this.direction = Axis.horizontal,
  });

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  // رقم الصورة الأساسية الحالية
  int _currentIndex = 0;
  // موضع الخط الفاصل الحالي على الشاشة
  final ValueNotifier<double> position = ValueNotifier<double>(0.0);
  bool _isInitialized = false;

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

    // تحريك الخط بين بداية ونهاية الشاشة
    position.value = currentTouch.clamp(0.0, totalSize);

    // إذا وصل الخط لنهاية السحبة بالكامل (100% من الشاشة)
    if (position.value >= totalSize - 2.0) {
      // نقلب للصورة التالية لتصبح هي الأساسية
      _currentIndex = (_currentIndex + 1) % widget.layers.length;
      position.value = 0.0; // إعادة الخط للبداية للسحبة التالية
    }
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.direction == Axis.horizontal;

    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final totalSize = isHorizontal
              ? constraints.maxWidth
              : constraints.maxHeight;

          if (!_isInitialized) {
            position.value = totalSize / 2;
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

                    // 2️⃣ الصورة التالية (تنكشف بسلاسة مع حركة السحب من 0 إلى 100%)
                    ClipRect(
                      clipper: MyCustomClipper(
                        position: currentPos,
                        direction: widget.direction,
                      ),
                      child: widget.layers[nextIndex],
                    ),

                    // 3️⃣ الخط المتوهج المطابق لموضع الكشف
                    if (isHorizontal)
                      Positioned(
                        left: currentPos - 1.5,
                        top: 0,
                        bottom: 0,
                        width: 3,
                        child: GlowBar(),
                      )
                    else
                      Positioned(
                        top: currentPos - 1.5,
                        left: 0,
                        right: 0,
                        height: 3,
                        child: GlowBar(),
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
