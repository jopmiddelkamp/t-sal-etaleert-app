extension ListExtensions on List {
  void addIfNotExist(Object value) {
    if (!this.contains(value)) {
      this.add(value);
    }
  }
}
