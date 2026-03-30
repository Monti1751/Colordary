import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:colordary/l10n/app_localizations.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/enums/emotion.dart';
import '../../../../core/providers/dependency_providers.dart';
import '../providers/diary_provider.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../../settings/presentation/providers/settings_state.dart';
import 'emotion_selector_bottom_sheet.dart';
import 'read_only_entry_dialog.dart';

class MonthGridWidget extends ConsumerWidget {
  const MonthGridWidget({super.key});

  IconData _getEmotionIcon(Emotion emotion) {
    switch (emotion) {
      case Emotion.angry: return Icons.sentiment_very_dissatisfied;
      case Emotion.sad: return Icons.sentiment_dissatisfied;
      case Emotion.neutral: return Icons.sentiment_neutral;
      case Emotion.relaxed: return Icons.sentiment_satisfied;
      case Emotion.happy: return Icons.sentiment_very_satisfied_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diaryState = ref.watch(diaryNotifierProvider);
    final settingsState = ref.watch(settingsNotifierProvider);
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday; // 1 = Monday, ..., 7 = Sunday
    
    // Offset for the first day of the week (assuming localized week start or Monday)
    // Flutter's DateTime.weekday is 1 (Mon) to 7 (Sun)
    final offset = firstWeekday - 1; 

    final palette = settingsState.currentPalette;
    final locale = Localizations.localeOf(context).languageCode;
    final monthName = DateFormat.MMMM(locale).format(now);
    
    // Localized weekdays (starts with Sun, shift to Mon)
    final weekdays = DateFormat.EEEE(locale).dateSymbols.SHORTWEEKDAYS;
    final shiftedWeekdays = [...weekdays.skip(1), weekdays.first];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM, vertical: AppDimensions.paddingS),
          child: Text(
            "${monthName[0].toUpperCase()}${monthName.substring(1)} ${now.year}",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: AppDimensions.paddingS),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: shiftedWeekdays.map((w) => SizedBox(
            width: (MediaQuery.of(context).size.width - AppDimensions.paddingL * 2) / 7,
            child: Center(
              child: Text(
                w[0].toUpperCase(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary.withOpacity(0.7),
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: AppDimensions.paddingS),
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: AppDimensions.paddingS,
                mainAxisSpacing: AppDimensions.paddingS,
                childAspectRatio: 1.0, 
              ),
              itemCount: daysInMonth + offset,
              itemBuilder: (context, index) {
                if (index < offset) return const SizedBox.shrink();
                
                final day = index - offset + 1;
                final cellDate = DateTime(now.year, now.month, day);
            final todayDate = DateTime(now.year, now.month, now.day);
            
            final isFuture = cellDate.isAfter(todayDate);
            final isToday = cellDate.isAtSameMomentAs(todayDate);
            
            final entry = diaryState.monthlyEntries.where((e) => e.date.day == day).firstOrNull;
            
            Color bgColor = theme.cardTheme.color ?? theme.colorScheme.surface;
            Widget? innerContent;

            if (entry != null) {
              bgColor = palette[entry.emotion.index];
              if (settingsState.isColorBlindMode) {
                innerContent = Center(
                  child: Icon(
                    _getEmotionIcon(entry.emotion),
                    color: Colors.white.withOpacity(0.9),
                    size: AppDimensions.iconM,
                  ),
                );
              }
            } else if (isFuture) {
              bgColor = theme.scaffoldBackgroundColor.withOpacity(0.5); // Desvanecido
            } else if (isToday) {
               innerContent = Center(
                  child: Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.5),
                      shape: BoxShape.circle,
                    )
                  )
               );
            } else {
               bgColor = theme.cardTheme.color!.withOpacity(0.4); 
            }

            return GestureDetector(
              onTap: () {
                if (isFuture) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(loc.errorPastDate), 
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
                    ),
                  );
                } else if (isToday) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => EmotionSelectorBottomSheet(existingEntry: entry, date: cellDate),
                  );
                } else {
                  if (entry != null) {
                    showDialog(
                      context: context,
                      builder: (_) => ReadOnlyEntryDialog(entry: entry),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(loc.errorPastDate), 
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                  boxShadow: isToday && entry == null
                      ? [BoxShadow(color: theme.colorScheme.primary.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)]
                      : theme.cardTheme.shadowColor != null 
                        ? [BoxShadow(color: theme.cardTheme.shadowColor!, blurRadius: 15, offset: const Offset(0, 4))] 
                        : null,
                  border: isToday ? Border.all(color: theme.colorScheme.primary.withOpacity(0.5), width: 1.5) : null,
                ),
                child: Stack(
                  children: [
                    if (innerContent != null) innerContent!,
                    Positioned(
                      top: AppDimensions.paddingXS,
                      left: AppDimensions.paddingS,
                      child: Text(
                        day.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: (entry != null && !settingsState.isColorBlindMode) 
                              ? Colors.white.withOpacity(0.9) 
                              : (settingsState.isColorBlindMode && entry != null) 
                                ? Colors.white 
                                : theme.textTheme.bodyMedium?.color,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ); // GestureDetector
          }, // itemBuilder
        ); // GridView.builder
      }, // LayoutBuilder builder
    ), // LayoutBuilder
  ], // Column children
); // Column
  }
}
