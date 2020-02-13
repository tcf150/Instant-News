class Source {
  final String name;

  Source(this.name);

  Source.fromJson(Map<String, dynamic> json)
    : name = json["name"];
}