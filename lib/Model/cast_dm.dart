class CastDM {
  final String name;
  final String characterName;
  final String urlSmallImage;


  CastDM({
    required this.name,
    required this.characterName,
    required this.urlSmallImage,
  });

  factory CastDM.fromJson(Map<String, dynamic> json) {
    return CastDM(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      urlSmallImage: json['url_small_image'] ?? '',
    );
  }
}
