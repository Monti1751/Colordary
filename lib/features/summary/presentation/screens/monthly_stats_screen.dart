import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/enums/emotion.dart';
import '../../../diary/presentation/providers/diary_provider.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../../settings/presentation/providers/settings_state.dart';
import '../providers/summary_provider.dart';
import '../providers/summary_state.dart'; 
import '../../../../core/providers/dependency_providers.dart';
import '../widgets/cozy_confirm_dialog.dart';
import 'package:colordary/l10n/app_localizations.dart';

class MonthlyStatsScreen extends ConsumerWidget {
  const MonthlyStatsScreen({super.key});

  IconData _getEmotionIcon(Emotion emotion) {
    switch (emotion) {
      case Emotion.angry: return Icons.sentiment_very_dissatisfied;
      case Emotion.sad: return Icons.sentiment_dissatisfied;
      case Emotion.neutral: return Icons.sentiment_neutral;
      case Emotion.relaxed: return Icons.sentiment_satisfied;
      case Emotion.happy: return Icons.sentiment_very_satisfied_outlined;
    }
  }

  String _getEmotionName(Emotion emotion, AppLocalizations loc) {
    switch (emotion) {
      case Emotion.angry: return loc.emotionAngry;
      case Emotion.sad: return loc.emotionSad;
      case Emotion.neutral: return loc.emotionNeutral;
      case Emotion.relaxed: return loc.emotionRelaxed;
      case Emotion.happy: return loc.emotionHappy;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final diaryState = ref.watch(diaryNotifierProvider);
    final settingsState = ref.watch(settingsNotifierProvider);
    final summaryState = ref.watch(summaryNotifierProvider);
    final loc = AppLocalizations.of(context)!;

    final now = DateTime.now();
    final palette = settingsState.currentPalette;

    final Map<Emotion, int> currentMonthCounts = { for (var e in Emotion.values) e: 0 };
    for (var entry in diaryState.monthlyEntries) {
      currentMonthCounts[entry.emotion] = (currentMonthCounts[entry.emotion] ?? 0) + 1;
    }
    
    final int totalEntries = currentMonthCounts.values.fold(0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.statsTitle, style: theme.textTheme.titleLarge),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: summaryState.status == SummaryStatus.loading 
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingL, horizontal: AppDimensions.paddingM),
                        child: Column(
                           children: [
                            Text(loc.statsHeader, style: theme.textTheme.titleLarge),
                            const SizedBox(height: AppDimensions.paddingXL),
                            SizedBox(
                              height: 220,
                              child: totalEntries == 0 
                                  ? Center(child: Text(loc.statsNoData, style: theme.textTheme.bodyMedium))
                                  : PieChart(
                                      PieChartData(
                                        sectionsSpace: 6,
                                        centerSpaceRadius: 50,
                                        sections: Emotion.values.map((emotion) {
                                          final value = currentMonthCounts[emotion]!.toDouble();
                                          return PieChartSectionData(
                                            color: palette[emotion.index],
                                            value: value,
                                            title: value > 0 ? value.toInt().toString() : '',
                                            radius: value > 0 ? 55 : 0, 
                                            titleStyle: TextStyle(
                                              fontSize: (16 * settingsState.fontSizeMultiplier).toDouble(), 
                                              fontWeight: FontWeight.bold, 
                                              color: Colors.white
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: AppDimensions.paddingXL),
                            
                            Wrap(
                              spacing: AppDimensions.paddingM,
                              runSpacing: AppDimensions.paddingM,
                              alignment: WrapAlignment.center,
                              children: Emotion.values.map((emotion) {
                                final count = currentMonthCounts[emotion]!;
                                if (count == 0) return const SizedBox.shrink();
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 16, height: 16,
                                      decoration: BoxDecoration(
                                        color: palette[emotion.index],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    if (settingsState.isColorBlindMode) ...[
                                      const SizedBox(width: AppDimensions.paddingXS),
                                      Icon(_getEmotionIcon(emotion), size: 16, color: theme.textTheme.bodyMedium?.color),
                                    ],
                                    const SizedBox(width: AppDimensions.paddingS),
                                    Text('${_getEmotionName(emotion, loc)} ($count)', style: theme.textTheme.bodyMedium),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingL),
                    
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusL)),
                            ),
                            onPressed: () async {
                              final exportUsecase = ref.read(exportMonthDataUseCaseProvider);
                              
                              final Map<Emotion, String> emotionTranslations = {
                                Emotion.angry: loc.emotionAngry,
                                Emotion.sad: loc.emotionSad,
                                Emotion.neutral: loc.emotionNeutral,
                                Emotion.relaxed: loc.emotionRelaxed,
                                Emotion.happy: loc.emotionHappy,
                              };

                              final result = await exportUsecase(
                                year: now.year, 
                                month: now.month,
                                dateLabel: loc.exportDate,
                                emotionLabel: loc.exportEmotion,
                                reflectionLabel: loc.exportReflection,
                                emotionNames: emotionTranslations,
                              );

                              result.fold(
                                (f) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(f.message))),
                                (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(loc.successSaved))),
                              );
                            },
                            icon: const Icon(Icons.share_rounded),
                            label: Text(loc.exportLabel),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.paddingM),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                               backgroundColor: theme.colorScheme.primary,
                               foregroundColor: Colors.white,
                               padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusL)),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => CozyConfirmDialog(
                                  title: loc.closeMonthTitle,
                                  content: loc.closeMonthContent,
                                  onCancel: () => Navigator.pop(context),
                                  onConfirm: () async {
                                    Navigator.pop(context); 
                                    final success = await ref.read(summaryNotifierProvider.notifier).closeMonth(now.year, now.month);
                                    if (success && context.mounted) {
                                      ref.read(diaryNotifierProvider.notifier).loadMonth(now.year, now.month);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(loc.closeMonthSuccess)),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                            icon: const Icon(Icons.auto_delete_rounded),
                            label: Text(loc.closeMonthLabel),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppDimensions.paddingXL),
                    Text(loc.historyTitle, style: theme.textTheme.titleLarge),
                    const SizedBox(height: AppDimensions.paddingM),
                    
                    if (summaryState.historicalSummaries.isEmpty)
                      Text(loc.historyNoData, style: theme.textTheme.bodyMedium)
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: summaryState.historicalSummaries.length,
                        itemBuilder: (context, index) {
                          final summary = summaryState.historicalSummaries[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
                            child: ListTile(
                              leading: Icon(Icons.bar_chart, color: theme.colorScheme.secondary),
                              title: Text('${summary.month.toString().padLeft(2, '0')}/${summary.year}', style: theme.textTheme.titleLarge),
                              subtitle: Text(loc.historyTotalEvents(summary.emotionCounts.values.fold<int>(0, (a, b) => a + b)), style: theme.textTheme.bodyMedium),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
