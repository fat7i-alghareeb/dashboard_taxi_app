import 'package:image_picker/image_picker.dart';

import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/kyc/presentation/states/kyc_bloc.dart';

class KycUploadSlotWidget extends StatefulWidget {
  const KycUploadSlotWidget({
    super.key,
    required this.type,
    required this.label,
    this.fileUrl,
    required this.isUploading,
  });

  final String type; // DriversLicense, NationalId, VehicleRegistration, Insurance
  final String label; // Localized label
  final String? fileUrl; // Current uploaded image URL
  final bool isUploading; // Whether this specific slot is uploading

  @override
  State<KycUploadSlotWidget> createState() => _KycUploadSlotWidgetState();
}

class _KycUploadSlotWidgetState extends State<KycUploadSlotWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final KycBloc bloc = context.read<KycBloc>();

    // Show beautiful premium choice dialog
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: context.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.lg.r)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: REdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.s16w600.copyWith(color: context.onSurface),
              ),
              AppSpacing.md.verticalSpace,
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.camera,
                  color: context.primary,
                  size: 20.r,
                ),
                title: Text(
                  'Camera',
                  style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
                ),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              const Divider(),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.image,
                  color: context.primary,
                  size: 20.r,
                ),
                title: Text(
                  'Gallery',
                  style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
                ),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );

    if (source == null) return;

    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70, // Compress to ensure light payloads
      );
      if (pickedFile != null) {
        bloc.add(
          KycEvent.uploadDocumentRequested(
            type: widget.type,
            filePath: pickedFile.path,
          ),
        );
      }
    } catch (e) {
      assert(() {
        debugPrint('Image pick error: $e');
        return true;
      }());
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.fileUrl != null && widget.fileUrl!.isNotEmpty;

    return GestureDetector(
      onTap: widget.isUploading ? null : () => _pickImage(context),
      child: Stack(
        children: [
          Container(
            height: 110.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.primary.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(AppRadii.md.r),
              border: Border.all(
                color: hasImage
                    ? AppColors.success.withValues(alpha: 0.3)
                    : context.primary.withValues(alpha: 0.15),
                width: 1.2,
              ),
            ),
            child: hasImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadii.md.r),
                    child: AppImageViewer.network(
                      widget.fileUrl!,
                      height: 110.h,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.cloudArrowUp,
                        size: 24.r,
                        color: context.primary.withValues(alpha: 0.6),
                      ),
                      AppSpacing.sm.verticalSpace,
                      Text(
                        widget.label,
                        style: AppTextStyles.s14w600.copyWith(
                          color: context.onSurface.withValues(alpha: 0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      AppSpacing.xs.verticalSpace,
                      Text(
                        AppStrings.tapToUpload,
                        style: AppTextStyles.s12w400.copyWith(
                          color: context.onSurface.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
          ),

          // Uploading overlay indicator
          if (widget.isUploading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(AppRadii.md.r),
                ),
                child: const Center(
                  child: LoadingDots(color: Colors.white),
                ),
              ),
            ),

          // Success checkmark overlay
          if (hasImage && !widget.isUploading)
            Positioned(
              top: 8.r,
              right: 8.r,
              child: Container(
                padding: REdgeInsets.all(AppSpacing.xs),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: FaIcon(
                  FontAwesomeIcons.circleCheck,
                  color: AppColors.success,
                  size: 18.r,
                ),
              ),
            ),
        ],
      ).animate().fadeIn(duration: AppDurations.normal),
    );
  }
}
