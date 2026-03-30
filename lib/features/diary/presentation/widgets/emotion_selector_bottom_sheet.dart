import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colordary/l10n/app_localizations.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/enums/emotion.dart';
import '../../../../core/providers/dependency_providers.dart';
import '../../domain/entities/daily_entry.dart';
import '../providers/diary_provider.dart';
import '../../../settings/presentation/providers/settings_provider.dart';

class EmotionSelectorBottomSheet extends ConsumerStatefulWidget {
  final DailyEntry? existingEntry;
  final DateTime date;

  const EmotionSelectorBottomSheet({super.key, this.existingEntry, required this.date});

  @override
  ConsumerState<EmotionSelectorBottomSheet> createState() => _EmotionSelectorBottomSheetState();
}

class _EmotionSelectorBottomSheetState extends ConsumerState<EmotionSelectorBottomSheet> {
  late Emotion _selectedEmotion;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _selectedEmotion = widget.existingEntry?.emotion ?? Emotion.relaxed;
    _textController = TextEditingController(text: widget.existingEntry?.content ?? '');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final settingsState = ref.watch(settingsNotifierProvider);
    final palette = settingsState.currentPalette;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppDimensions.radiusXL)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppDimensions.paddingL,
        AppDimensions.paddingL,
        AppDimensions.paddingL,
        AppDimensions.paddingL + bottomInset,
      ),
      child: SingleChildScrollView(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Container(
               width: 40,
               height: 4,
               margin: const EdgeInsets.only(bottom: AppDimensions.paddingL),
               decoration: BoxDecoration(
                 color: theme.dividerColor,
                 borderRadius: BorderRadius.circular(AppDimensions.radiusS)
               ),
             ),
             Text(loc.selectEmotion, style: theme.textTheme.titleLarge),
             const SizedBox(height: AppDimensions.paddingL),
             
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: Emotion.values.map((emotion) {
                final isSelected = _selectedEmotion == emotion;
                final color = palette[emotion.index];
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _selectedEmotion = emotion),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: isSelected ? 60 : 50,
                        width: isSelected ? 60 : 50,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected ? Border.all(color: theme.colorScheme.onSurface, width: 3) : null,
                          boxShadow: isSelected 
                              ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, spreadRadius: 2)] 
                              : null,
                        ),
                        child: settingsState.isColorBlindMode ? Icon(
                          _getIconForEmotion(emotion), 
                          color: Colors.white,
                        ) : null,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingXS),
                    Text(
                      _getEmotionName(emotion, loc),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 10,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
             
             const SizedBox(height: AppDimensions.paddingXL),
             
             TextField(
               controller: _textController,
               maxLines: 4,
               decoration: InputDecoration(
                 hintText: loc.dailyEntryHint,
               ),
             ),
             
             const SizedBox(height: AppDimensions.paddingXL),
             
             SizedBox(
               width: double.infinity,
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: palette[_selectedEmotion.index],
                 ),
                 onPressed: () async {
                    if (_textController.text.trim().isEmpty) return;
                    
                    await ref.read(diaryNotifierProvider.notifier).saveEntry(
                      widget.date,
                      _selectedEmotion,
                      _textController.text.trim(),
                      id: widget.existingEntry?.id,
                    );
                    
                    if (mounted) Navigator.pop(context);
                 },
                 child: Text(loc.save),
               ),
             ),
           ],
         ),
      ),
    );
  }
  
  IconData _getIconForEmotion(Emotion e) {
    if(e == Emotion.angry) return Icons.sentiment_very_dissatisfied;
    if(e == Emotion.sad) return Icons.sentiment_dissatisfied;
    if(e == Emotion.neutral) return Icons.sentiment_neutral;
    if(e == Emotion.relaxed) return Icons.sentiment_satisfied;
    return Icons.sentiment_very_satisfied_outlined;
  }

  String _getEmotionName(Emotion e, AppLocalizations loc) {
    switch (e) {
      case Emotion.angry: return loc.emotionAngry;
      case Emotion.sad: return loc.emotionSad;
      case Emotion.neutral: return loc.emotionNeutral;
      case Emotion.relaxed: return loc.emotionRelaxed;
      case Emotion.happy: return loc.emotionHappy;
    }
  }
}
