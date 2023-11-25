import 'dart:typed_data';

class Privacy {
  final int? id;
  final String name;
  final double lat;
  final double lng;
  final Uint8List image;
  final String eventdate;
  final String title;
  final String content;
  final DateTime? actiondate; // Nullable로 변경

  Privacy({
    this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.image,
    required this.eventdate,
    required this.title,
    required this.content,
    this.actiondate,
  });

  Privacy.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        name = res['name'],
        lat = res['lat'],
        lng = res['lng'],
        image = res['image'],
        eventdate = res['eventdate'],
        title = res['title'],
        content = res['content'],
        actiondate = res['actiondate'] != null ? DateTime.parse(res['actiondate']) : null;
}