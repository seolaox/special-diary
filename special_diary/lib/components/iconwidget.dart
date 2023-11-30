import 'package:flutter/material.dart';

enum IconType {
  Sunny,
  WaterDrop,
  Cloud,
  Air,
  AcUnit,
}

class IconWidget extends StatelessWidget {
  final String iconString;

  const IconWidget({required this.iconString});

  @override
  Widget build(BuildContext context) {
    return getIconWidget(iconString);
  }

  // 저장된 아이콘 값을 기반으로 아이콘 위젯을 반환
  Widget getIconWidget(String iconString) {
    print('Icon String: $iconString');
    switch (iconString.toLowerCase()) {
      case 'sunny':
        return Icon(
          Icons.sunny,
          color: Colors.amber[400],
        );
      case 'waterdrop':
        return Icon(Icons.water_drop, color: Colors.blue[300]);
      case 'cloud':
        return Icon(
          Icons.cloud,
          color: Colors.grey[400],
        );
      case 'air':
        return Icon(
          Icons.air,
          color: Colors.blueGrey[200],
        );
      case 'acunit':
        return Icon(
          Icons.ac_unit,
          color: Colors.blue[100],
        );
      default:
        return Icon(Icons.error);
    }
  }



  IconType getIconTypeFromString(String iconString) {
    switch (iconString) {
      case 'Sunny':
        return IconType.Sunny;
      case 'WaterDrop':
        return IconType.WaterDrop;
      case 'Cloud':
        return IconType.Cloud;
      case 'Air':
        return IconType.Air;
      case 'AcUnit':
        return IconType.AcUnit;
      default:
        return IconType.Sunny;
    }
  }
}
