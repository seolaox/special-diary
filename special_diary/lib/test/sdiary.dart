import 'dart:typed_data';

class Sdiary {
  final int? id;
  final String title;
  final String content;
  final String? weathericon; // Nullable로 변경
  final double lat;
  final double lng;
  final Uint8List image;
  final DateTime? actiondate; // Nullable로 변경

  Sdiary({
    this.id,
    required this.title,
    required this.content,
    this.weathericon, // Nullable로 변경
    required this.lat,
    required this.lng,
    required this.image,
    this.actiondate,
  });

  Sdiary.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        content = res['content'],
        weathericon = res['weathericon'], // Nullable로 변경
        lat = res['lat'],
        lng = res['lng'],
        image = res['image'],
        actiondate = res['actiondate'] != null ? DateTime.parse(res['actiondate']) : null;
}
