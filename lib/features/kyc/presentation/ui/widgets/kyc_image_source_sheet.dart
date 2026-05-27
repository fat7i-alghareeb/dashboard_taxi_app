import 'package:image_picker/image_picker.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/kyc/presentation/ui/widgets/kyc_image_source_row_widget.dart';

/// Flat bottom-sheet for picking image source (camera vs gallery).
class KycImageSourceSheet extends StatelessWidget {
  const KycImageSourceSheet({super.key, required this.title});

  final String title;

  static Future<ImageSource?> show(
    BuildContext context, {
    required String title,
  }) {
    return AppBottomSheet.show<ImageSource>(
      context,
      sheet: AppBottomSheet.basic(
        title: AppStrings.imageSourceTitle,
        child: KycImageSourceSheet(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyles.s14w500.copyWith(
            color: context.onSurface.withValues(alpha: 0.60),
          ),
        ),
        AppSpacing.lg.verticalSpace,
        KycImageSourceRowWidget(
          icon: FontAwesomeIcons.camera,
          label: AppStrings.imageSourceCamera,
          onTap: () => Navigator.of(context).pop(ImageSource.camera),
        ),
        AppSpacing.sm.verticalSpace,
        KycImageSourceRowWidget(
          icon: FontAwesomeIcons.image,
          label: AppStrings.imageSourceGallery,
          onTap: () => Navigator.of(context).pop(ImageSource.gallery),
        ),
      ],
    );
  }
}
