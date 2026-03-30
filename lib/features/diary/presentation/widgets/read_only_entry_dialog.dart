import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/providers/dependency_providers.dart';
import '../../domain/entities/daily_entry.dart';
import '../../../settings/presentation/providers/settings_provider.dart';

class ReadOnlyEntryDialog extends ConsumerWidget {
  final DailyEntry entry;

  const ReadOnlyEntryDialog({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settingsState = ref.watch(settingsNotifierProvider);
    final emotionColor = settingsState.currentPalette[entry.emotion.index];

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusXL)),
      backgroundColor: theme.colorScheme.surface,
      elevation: AppDimensions.elevationSoft,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             // Emotional Header
             Container(
               height: 60,
               decoration: BoxDecoration(
                 color: emotionColor,
                 borderRadius: BorderRadius.circular(AppDimensions.radiusM),
               ),
             ),
             const SizedBox(height: AppDimensions.paddingM),
             Text(
               "${entry.date.day.toString().padLeft(2, '0')}/${entry.date.month.toString().padLeft(2, '0')}/${entry.date.year}",
               style: theme.textTheme.titleLarge,
               textAlign: TextAlign.center,
             ),
             const SizedBox(height: AppDimensions.paddingL),
             Text(
               entry.content,
               style: theme.textTheme.bodyLarge,
             ),
             const SizedBox(height: AppDimensions.paddingXL),
             TextButton(
               onPressed: () => Navigator.pop(context),
               child: Text('Cerrar', style: TextStyle(color: theme.colorScheme.primary)),
             )
          ],
        ),
      ),
    );
  }
}
