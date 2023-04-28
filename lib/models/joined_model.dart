class BaseTableWithDetails {
  final int id;
  final String title;
  final String target;
  final String currentStatus;
  final String totalDays;
  final List<DetailsTable> details;

  BaseTableWithDetails({required this.id, required this.title, required this.target, required this.currentStatus, required this.totalDays, required this.details});
}

class DetailsTable {
  final int id;
  final String currentStatus;
  final String day;
  final String imagePath;
  final int transoId;

  DetailsTable({required this.id, required this.currentStatus, required this.day, required this.imagePath, required this.transoId});
}
