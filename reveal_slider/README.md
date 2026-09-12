# Reveal Slider

A highly customizable, futuristic, and smooth **multi-layer reveal slider & scanner** widget for Flutter. Transition smoothly between multiple layers or compare widgets with an interactive glowing scanner line.

---

##  Features

-  **Multi-Layer Support**: Transition endlessly through $N$ number of layers (not just 2 images!).
-  **Any Widget as a Layer**: Works with Images, Videos, Custom Cards, Lottie animations, or any Flutter Widget.
-  **Futuristic Glowing Divider**: Built-in sleek neon glow scanner bar with full support for custom divider widgets.
-  **Bi-Directional**: Supports both `Axis.vertical` and `Axis.horizontal` transitions.
-  **Multi-Platform**: Butter-smooth 60/120 FPS performance on Mobile (iOS & Android), Web, and Desktop (Windows, macOS, Linux).
-  **Reactive Callbacks**: Notifies your State Management when the active layer changes via `onLayerChanged`.

---

## 🚀 Getting Started

Add `reveal_slider` to your `pubspec.yaml` dependencies:

```bash
flutter pub add reveal_slider
```

or manually:

```yaml
dependencies:
  reveal_slider: ^0.0.1
```

Then import it in your Dart code:

```dart
import 'package:reveal_slider/reveal_slider.dart';
```

---

##  Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:reveal_slider/reveal_slider.dart';

class SimpleRevealPage extends StatelessWidget {
  const SimpleRevealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: RevealSlider(
        direction: Axis.vertical,
        onLayerChanged: (index) {
          debugPrint('Active layer is now: $index');
        },
        layers: [
          Image.asset('assets/images/layer1.jpg', fit: BoxFit.cover),
          Image.asset('assets/images/layer2.jpg', fit: BoxFit.cover),
          Container(
            color: Colors.deepPurple,
            child: const Center(
              child: Text(
                'Custom Widget Layer',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

### Custom Divider / Handle Example

You can replace the glowing scanner line with your own custom handle widget:

```dart
RevealSlider(
  direction: Axis.horizontal,
  customDivider: Container(
    color: Colors.redAccent,
    child: const Icon(Icons.compare_arrows, color: Colors.white),
  ),
  layers: [
    Image.asset('assets/images/before.jpg', fit: BoxFit.cover),
    Image.asset('assets/images/after.jpg', fit: BoxFit.cover),
  ],
)
```

---

## ⚙️ Properties

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `layers` | `List<Widget>` | **Required** | List of widgets/layers to reveal (minimum 2 layers). |
| `direction` | `Axis` | `Axis.vertical` | The transition axis (`Axis.vertical` or `Axis.horizontal`). |
| `customDivider` | `Widget?` | `null` | Optional custom widget to replace the default `RevealGlowBar`. |
| `onLayerChanged`| `ValueChanged<int>?` | `null` | Callback triggered whenever a layer transition completes. |

---

## 🛠️ Contributing

Contributions, issues, and feature requests are welcome!
Feel free to check the [issues page](https://github.com/RwanHossamEldein/Reveal-Slider/issues).

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

