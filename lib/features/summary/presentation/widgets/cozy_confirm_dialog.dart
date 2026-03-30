import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';

class CozyConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CozyConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusL)),
      backgroundColor: theme.colorScheme.surface,
      elevation: AppDimensions.elevationMedium,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: AppDimensions.paddingM),
            Text(content, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center),
            const SizedBox(height: AppDimensions.paddingXL),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: onCancel,
                  child: Text('Cancelar', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                ),
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Eliminar y Cerrar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
