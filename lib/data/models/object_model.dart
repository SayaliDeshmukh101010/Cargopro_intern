class ApiObject {
  final String id;
  final String? name;
  final Map<String, dynamic>? data;

  ApiObject({
    required this.id,
    this.name,
    this.data,
  });

  factory ApiObject.fromJson(Map<String, dynamic> json) {
    return ApiObject(
      id: json['id'] ?? '',
      name: json['name'],
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'data': data,
    };
  }
}