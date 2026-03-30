import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:colordary/l10n/app_localizations.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/providers/dependency_providers.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  final Widget child;
  const AuthWrapper({super.key, required this.child});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  bool _isAuthenticated = false;
  bool _hasChecked = false;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final settingsRepo = ref.read(settingsRepositoryProvider);
    // Verificamos si en Preferencias el usuario habilitó el bloqueo
    final isAuthRequired = settingsRepo.getAuthEnabled();

    if (!isAuthRequired) {
      if (mounted) setState(() { _isAuthenticated = true; _hasChecked = true; });
      return;
    }

    final authService = ref.read(localAuthServiceProvider);
    final isAvailable = await authService.isBiometricsAvailable();
    
    // Si el teléfono no soporta bloqueos, le dejamos pasar o prevenimos? Lo lógico es prevenir que lo enciendan, así que aquí pasa seguro.
    if (!isAvailable) {
      if (mounted) setState(() { _isAuthenticated = true; _hasChecked = true; });
      return; 
    }

    final loc = AppLocalizations.of(context);
    final success = await authService.authenticate(loc?.biometricReason ?? "Protege tu refugio");
    if (mounted) {
      setState(() { 
        _isAuthenticated = success; 
        _hasChecked = true; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasChecked) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    if (_isAuthenticated) return widget.child;

    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_rounded, size: 80, color: theme.colorScheme.primary.withOpacity(0.5)),
            const SizedBox(height: AppDimensions.paddingL),
            Text(loc.authTitle, style: theme.textTheme.displayLarge),
            const SizedBox(height: AppDimensions.paddingM),
            Text(
              loc.authSubtitle,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingXL),
            ElevatedButton.icon(
              onPressed: _checkAuth,
              icon: const Icon(Icons.fingerprint),
              label: Text(loc.save.contains('Guardar') ? "Desbloquear" : "Unlock"),
            ),
          ],
        ),
      ),
    );
  }
}
