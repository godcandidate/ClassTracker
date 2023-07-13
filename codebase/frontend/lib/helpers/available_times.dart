class Time {
  final h;
  final m;
  Time(this.h, this.m);

  factory Time.fromString(String string) {
    var splits = string.split(":");
    var h = splits.first;
    var m = splits.last;
    return Time(h, m);
  }

  Time addDuration(Time b) {
    int sh = int.parse(h.toString());
    int sm = int.parse(m.toString());
    int eh = int.parse(b.h.toString());
    int em = int.parse(b.m.toString());
    int sum = (sm + em);
    int res = sum ~/ 60;
    sh += res + eh;
    var minutes = (sum % 60).toString().padLeft(2, '0');
    return Time(sh, minutes);
  }

  Time subtractTime(Time b) {
    int sh = int.parse(h.toString());
    int sm = int.parse(m.toString());
    int eh = int.parse(b.h.toString());
    int em = int.parse(b.m.toString());
    if (em > sm) {
      sm += 60;
      sh -= 1;
    }
    print('sh: $sh sm: $sm, eh: $eh em: $em');

    int dm = sm - em;
    int dh = sh - eh;
    return Time(dh, dm);
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Time && o.h == h && o.m == m;
  }

  bool operator <(Time o) {
    return int.parse('$h${m.toString().padLeft(2, '0')}') <
        int.parse('${o.h}${o.m.toString().padLeft(2, '0')}');
  }

  @override
  toString() {
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
  }

  @override
  int get hashCode => h.hashCode ^ m.hashCode;
}

class TimeRange {
  Time start;
  final Time end;
  TimeRange(this.start, this.end);
  static List<TimeRange> timeRanges = [];

  static add(Time start, Time end) {
    timeRanges.add(TimeRange(start, end));
  }

  static sort() {
    timeRanges.sort((a, b) {
      return int.parse(a.start.h.toString() + a.start.m.toString()).compareTo(
        int.parse(b.start.h.toString() + b.start.m.toString()),
      );
    });
  }

  Time difference() {
    return end.subtractTime(start);
  }

  @override
  toString() {
    return '${start.h}:${start.m} - ${end.h}:${end.m}';
  }
}
