import 'package:flutter/material.dart';
import 'package:vforms/components/button.dart';
import 'package:vforms/screens/onboarding/initialize_screen.dart';
import 'package:vforms/screens/onboarding/welcome_screen.dart';
import 'package:vforms/screens/onboarding/login_screen.dart';
import 'package:vforms/schema/screens.dart';
import 'package:vforms/services/model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.model});

  final Model model;

  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Screens currentScreen = Screens.welcome;
  double progress = 0.0;
  bool startModelDownload = false;
  String downloadButtonText = 'Download Models (200 MB)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VForms',
          style: TextStyle(
            color: Color(0xFF4687E1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: createScreen(currentScreen)),
              createButton(context, currentScreen),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> downloadAction(BuildContext context) async {
    if (widget.model.isModelInstalled) {
      // Model has downloaded

      Navigator.pushReplacementNamed(context, '/app');
    } else {
      // Model is yet to be downloaded

      try {
        await widget.model.installModel(
          (progress) => setState(() {
            startModelDownload = true;
            this.progress = progress.toDouble() / 100;
          }),
        );

        // Update the button label to guide the user to finish the setup
        setState(() {
          downloadButtonText = 'Finish Setup';
        });
      } catch (e) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occured while downloading the models'),
          ),
        );
      } finally {
        setState(() {
          startModelDownload = false;
        });
      }
    }
  }

  Widget createButton(BuildContext context, Screens screen) {
    switch (screen) {
      case Screens.welcome:
        return Button(
          text: 'Let\'s Get Started',
          onPressed: () {
            switchScreen(Screens.login);
          },
          icon: Icons.arrow_forward,
        );
      case Screens.login:
        return Button(
          text: 'Skip for now',
          onPressed: () {
            switchScreen(Screens.initialize);
          },
          icon: Icons.arrow_forward,
        );
      case Screens.initialize:
        return Button(
          text: downloadButtonText,
          onPressed: startModelDownload
              ? null
              : () async {
                  await downloadAction(context);
                },
          icon: Icons.download,
        );
    }
  }

  Widget createScreen(Screens screen) {
    switch (screen) {
      case Screens.welcome:
        return WelcomeScreen();
      case Screens.login:
        return LoginScreen();
      case Screens.initialize:
        return InitializeScreen(
          progress: progress,
          startModelDownload: startModelDownload,
        );
    }
  }

  void switchScreen(Screens screen) {
    setState(() {
      currentScreen = screen;
    });
  }
}
