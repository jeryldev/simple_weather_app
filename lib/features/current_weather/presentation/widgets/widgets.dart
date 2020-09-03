export './current_weather_controls.dart';
export './loading_widget.dart';
export './current_weather_feature_section.dart';
export './current_weather_card.dart';

extension CapExtension on String {
  //first letter only
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  //all letter in string
  String get allInCaps => this.toUpperCase();
  //first letter for each word in a string
  String get titleCase => this
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}
