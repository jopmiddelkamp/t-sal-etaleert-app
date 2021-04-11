extension GenericdIterableExtensions<T> on Iterable<T> {
  Iterable<T> skipLast() {
    return this.take(this.length - 1);
  }

  Map<TKey, T> toLookupMap<TKey>(
    TKey Function(T e) keyBuilder,
  ) {
    return Map<TKey, T>.fromIterable(
      this,
      key: (e) => keyBuilder(e),
      value: (e) => e,
    );
  }
}
