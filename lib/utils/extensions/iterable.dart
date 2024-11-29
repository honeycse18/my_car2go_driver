extension IterableExtension<E> on Iterable<E> {
  bool everyIndexed(bool Function(int index, E element) test) {
    for (final (int index, E element) in indexed) {
      if (!test(index, element)) return false;
    }
    return true;
  }
}
