class Event {
  final DateTime date;
  final String dis;
  final String ictimi;

  Event(this.date, this.dis, this.ictimi)
      : assert(date != null),
        assert(dis != null);
}
