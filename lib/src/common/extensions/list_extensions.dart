extension GenericdListExtensions<T> on List<T> {
  void addIfNotExist(T value) {
    if (!this.contains(value)) {
      this.add(value);
    }
  }
}
