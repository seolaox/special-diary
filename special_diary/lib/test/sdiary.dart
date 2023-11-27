import 'dart:typed_data';

class Sdiary {
  final int? id;
  final String title;
  final String content;
  final String? weathericon;
  final double lat;
  final double lng;
  final Uint8List image;
  final DateTime? actiondate;
  final String? eventdate; 

  Sdiary({
    this.id,
    required this.title,
    required this.content,
    this.weathericon,
    required this.lat,
    required this.lng,
    required this.image,
    this.actiondate,
    this.eventdate,
  });

  Sdiary.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        content = res['content'],
        weathericon = res['weathericon'],
        lat = res['lat'],
        lng = res['lng'],
        image = res['image'],
        actiondate = res['actiondate'] != null ? DateTime.parse(res['actiondate']) : null,
        eventdate = res['eventdate']; 
}


