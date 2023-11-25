import 'dart:typed_data';

class SpecialDiary {
  final int? id;
  final double lat;
  final double lng;
  final Uint8List image;
  final String eventdate;
  final String title;
  final String content;
  final DateTime? actiondate; // Nullable로 변경

  SpecialDiary({
    this.id,
    required this.lat,
    required this.lng,
    required this.image,
    required this.eventdate,
    required this.title,
    required this.content,
    this.actiondate,
  });

  SpecialDiary.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        lat = res['lat'],
        lng = res['lng'],
        image = res['image'],
        eventdate = res['eventdate'],
        title = res['title'],
        content = res['content'],
        actiondate = res['actiondate'] != null ? DateTime.parse(res['actiondate']) : null;
}