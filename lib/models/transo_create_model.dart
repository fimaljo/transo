class TransoCreateModel implements Comparable {
  final int id;
  final String title;
  final String target;
  final String currentStatus;
  final String totalDays;

  const TransoCreateModel(
      this.id, this.title, this.target, this.currentStatus, this.totalDays);
  TransoCreateModel.fromRow(Map<String, Object?> row)
      : id = row['ID'] as int,
        title = row['TITLE'] as String,
        target = row['TARGET'] as String,
        currentStatus = row['CURRENT_STATUS'] as String,
        totalDays = row['TOTAL_DAYS'] as String;
  @override
  int compareTo(covariant TransoCreateModel other) => id.compareTo(other.id);
  @override
  bool operator ==(covariant TransoCreateModel other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
  @override
  String toString() => 'TransoCreateModel, id = $id,title : $title';
}
