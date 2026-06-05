import 'package:sabalpara_family/sabalpara_family.dart';

class UnknownScreen extends StatelessWidget {
  static const String routeName = "/unknown";

  const UnknownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text(context.l10n?.pageNotFound ?? "", style: styleW700S22),
      ),
    );
  }
}
