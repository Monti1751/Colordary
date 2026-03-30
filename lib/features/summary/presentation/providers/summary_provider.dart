import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import '../../domain/usecases/close_month_and_generate_summary_usecase.dart';
import '../../domain/usecases/get_monthly_statistics_usecase.dart';
import 'summary_state.dart';

class SummaryNotifier extends StateNotifier<SummaryState> {
  final GetMonthlyStatisticsUseCase _getStatsUseCase;
  final CloseMonthAndGenerateSummaryUseCase _closeMonthUseCase;

  SummaryNotifier({
    required GetMonthlyStatisticsUseCase getStatsUseCase,
    required CloseMonthAndGenerateSummaryUseCase closeMonthUseCase,
  })  : _getStatsUseCase = getStatsUseCase,
        _closeMonthUseCase = closeMonthUseCase,
        super(const SummaryState()) {
    loadHistoricalSummaries();
  }

  Future<void> loadHistoricalSummaries() async {
    state = state.copyWith(status: SummaryStatus.loading, clearError: true);
    final result = await _getStatsUseCase();
    result.fold(
      (l) => state = state.copyWith(status: SummaryStatus.error, errorMessage: l.message),
      (summaries) => state = state.copyWith(status: SummaryStatus.success, historicalSummaries: summaries),
    );
  }

  Future<bool> closeMonth(int year, int month) async {
    state = state.copyWith(status: SummaryStatus.loading, clearError: true);
    final result = await _closeMonthUseCase(year, month);
    
    return result.fold(
      (l) {
        state = state.copyWith(status: SummaryStatus.error, errorMessage: l.message);
        return false;
      },
      (_) {
        loadHistoricalSummaries();
        return true;
      },
    );
  }
}
