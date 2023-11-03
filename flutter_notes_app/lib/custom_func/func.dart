import 'package:flutter/material.dart';

class CustomFunc {
  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  static Color hexStringToColor(String hexString) {
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
}
