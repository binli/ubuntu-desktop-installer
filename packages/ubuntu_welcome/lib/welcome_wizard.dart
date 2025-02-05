import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ubuntu_desktop_installer/pages.dart';
import 'package:ubuntu_wizard/widgets.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

enum WelcomeStep {
  locale,
  timezone,
  identity,
}

class WelcomeRoutes {
  static const String initial = '/';
  static const String locale = '/locale';
  static const String timezone = '/timezone';
  static const String identity = '/identity';
}

class WelcomeWizard extends ConsumerStatefulWidget {
  const WelcomeWizard({super.key});

  @override
  ConsumerState<WelcomeWizard> createState() => _WelcomeWizardState();
}

class _WelcomeWizardState extends ConsumerState<WelcomeWizard> {
  late final WizardController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WizardController(
      routes: {
        // TODO: loading screen?
        WelcomeRoutes.initial: WizardRoute(
          builder: (_) => const SizedBox.shrink(),
        ),
        WelcomeRoutes.locale: WizardRoute(
          builder: (_) => const LocalePage(),
          userData: WelcomeStep.locale.index,
          onLoad: (_) => LocalePage.load(context, ref),
        ),
        WelcomeRoutes.timezone: WizardRoute(
          builder: (_) => const TimezonePage(),
          userData: WelcomeStep.timezone.index,
          onLoad: (_) => TimezonePage.load(context, ref),
        ),
        WelcomeRoutes.identity: WizardRoute(
          builder: (_) => const IdentityPage(),
          userData: WelcomeStep.identity.index,
          onLoad: (_) => IdentityPage.load(ref),
          onNext: (_) =>
              YaruWindow.of(context).close().then((_) => WelcomeRoutes.initial),
        ),
      },
    )..replace();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wizard(controller: _controller);
  }
}
