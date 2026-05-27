import 'package:dashboardtaxi/common/imports/imports.dart';

class RootMapLoadingSection extends StatelessWidget {
  const RootMapLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          const AppShimmer(child: SizedBox.expand()),
          Align(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const MainLoadingProgress(),
                AppSpacing.lg.verticalSpace,
                Text(
                  AppStrings.rootMapInitializing,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.s16w600.copyWith(
                    color: context.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
