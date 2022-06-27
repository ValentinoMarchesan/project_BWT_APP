//class that defines a Step object
class Steps {
  final int day;
  final double? step;

  Steps(
    this.day, {
    required this.step,
  });

  static Steps empty() => Steps(0, step: 0.0);
  static Steps creation(int day, double? step) {
    if (step == null) {
      step = 0;
      day = day;
    }

    return Steps(day, step: step);
  }
}
