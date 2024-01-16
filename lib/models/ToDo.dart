class ToDo {
  int id;
  String text;
  bool checked;

  ToDo(this.id, this.text, this.checked);

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      json['ID'] ?? 0,
      json['TEXT'] ?? '',
      json['CHECKED']==1?true : false,
    );
  }
}
