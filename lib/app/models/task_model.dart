class TaskModel {
  final int id;
  final String description;
  final DateTime dateTime;
  final bool finish;
  TaskModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finish,
  });

  factory TaskModel.loadFromDb(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'] ?? '',
      description: task['descricao'] ?? '',
      dateTime: DateTime.parse(task['data_hora'] ?? ''),
      finish: task['finalizado'] == 1,
    );
  }

  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    bool? finish,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      finish: finish ?? this.finish,
    );
  }
}
