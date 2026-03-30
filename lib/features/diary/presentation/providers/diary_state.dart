import '../../domain/entities/daily_entry.dart';

enum DiaryStatus { initial, loading, success, error }

class DiaryState {
  final DiaryStatus status;
  final List<DailyEntry> monthlyEntries;
  final String? errorMessage;

  const DiaryState({
    this.status = DiaryStatus.initial,
    this.monthlyEntries = const [],
    this.errorMessage,
  });

  DiaryState copyWith({
    DiaryStatus? status,
    List<DailyEntry>? monthlyEntries,
    String? errorMessage,
    bool clearError = false, 
  }) {
    return DiaryState(
      status: status ?? this.status,
      monthlyEntries: monthlyEntries ?? this.monthlyEntries,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
