import '../../domain/entities/monthly_summary.dart';

enum SummaryStatus { initial, loading, success, error }

class SummaryState {
  final SummaryStatus status;
  final List<MonthlySummary> historicalSummaries;
  final String? errorMessage;

  const SummaryState({
    this.status = SummaryStatus.initial,
    this.historicalSummaries = const [],
    this.errorMessage,
  });

  SummaryState copyWith({
    SummaryStatus? status,
    List<MonthlySummary>? historicalSummaries,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SummaryState(
      status: status ?? this.status,
      historicalSummaries: historicalSummaries ?? this.historicalSummaries,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
