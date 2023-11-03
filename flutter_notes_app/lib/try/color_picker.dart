import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class MyColorPicker extends StatefulWidget {
  const MyColorPicker({super.key});

  @override
  State<MyColorPicker> createState() => _MyColorPickerState();
}

// class _MyColorPickerState extends State<MyColorPicker> {
//   Color currentColor = Colors.blue; // Inisialisasi warna default

//   void changeColor(Color color) {
//     setState(() {
//       currentColor = color;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Color Picker Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ColorPicker(
//               pickerColor: currentColor,
//               onColorChanged: changeColor,
//               pickerAreaHeightPercent: 0.8,
//             ),
//             Text(
//               'Selected Color: ${currentColor.toString()}',
//               style: TextStyle(color: currentColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _MyColorPickerState extends State<MyColorPicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ColorPickerDemo(),
    );
  }
}

class ColorPickerDemo extends StatefulWidget {
  @override
  _ColorPickerDemoState createState() => _ColorPickerDemoState();
}

class _ColorPickerDemoState extends State<ColorPickerDemo> {
  Color currentColor = Colors.blue; // Inisialisasi warna default

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
    });
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  Color hexStringToColor(String hexString) {
    // Hilangkan karakter "#" jika ada
    if (hexString.startsWith('#')) {
      hexString = hexString.substring(1);
    }

    // Periksa apakah string berisi tepat 6 karakter hex
    if (hexString.length != 6) {
      throw ArgumentError("String hex harus terdiri dari 6 karakter");
    }

    // Konversi string hex menjadi nilai RGB
    int colorValue = int.parse(hexString, radix: 16);

    // Buat objek Color dari nilai RGB
    return Color(
        colorValue | 0xFF000000); // Tambahkan alpha channel (100% opasitas)
  }

  void _showColorPicker() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ColorPicker(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                  pickerAreaHeightPercent: 0.55,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _showColorPicker(); // Panggil fungsi untuk menampilkan Color Picker
              },
              child: Text('Pilih Warna'),
            ),
            Text(
              'Selected Color: ${colorToHex(currentColor)}',
              style: TextStyle(color: currentColor),
            ),
            Container(
              height: 100,
              width: 100,
              color: hexStringToColor(
                colorToHex(currentColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
