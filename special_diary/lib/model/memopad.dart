
class MemoPad {
  final int? id;
  final String memo;
  final DateTime? memoinsertdate; // Nullable로 변경

  MemoPad({
    this.id,
    required this.memo,
    this.memoinsertdate,
  });

  MemoPad.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        memo = res['memo'],
        memoinsertdate = res['memoinsertdate'] != null ? DateTime.parse(res['memoinsertdate']) : null;
}