class TODOmodel {
  String title;
  bool isCompleted;

  TODOmodel({required this.title, required this.isCompleted});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
