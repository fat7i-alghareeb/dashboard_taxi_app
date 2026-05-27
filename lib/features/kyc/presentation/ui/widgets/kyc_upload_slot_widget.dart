import 'package:image_picker/image_picker.dart';
import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/features/kyc/presentation/states/kyc_bloc.dart';
import 'package:dashboardtaxi/features/kyc/presentation/ui/widgets/kyc_image_source_sheet.dart';

class KycUploadSlotWidget extends StatefulWidget {
  const KycUploadSlotWidget({
    super.key,
    required this.type,
    required this.label,
    this.fileUrl,
    required this.isUploading,
  });

  final String type;
  final String label;
  final String? fileUrl;
  final bool isUploading;

  @override
  State<KycUploadSlotWidget> createState() => _KycUploadSlotWidgetState();
}

class _KycUploadSlotWidgetState extends State<KycUploadSlotWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(BuildContext context) async {
    final KycBloc bloc = context.read<KycBloc>();

    final source = await KycImageSourceSheet.show(context, title: widget.label);
    if (source == null || !mounted) return;

    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
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
      printC('KycUploadSlot: image pick error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.fileUrl != null && widget.fileUrl!.isNotEmpty;
    final borderColor = hasImage
        ? AppColors.success.withValues(alpha: 0.40)
        : context.onSurface.withValues(alpha: 0.10);

    return GestureDetector(
      onTap: widget.isUploading ? null : () => _pickImage(context),
      child: Stack(
        children: [
          Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.surface,
              borderRadius: BorderRadius.circular(AppRadii.lg.r),
              border: Border.all(color: borderColor),
            ),
            child: hasImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadii.lg.r),
                    child: AppImageViewer.network(
                      widget.fileUrl!,
                      height: 120.h,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 32.r,
                        width: 32.r,
                        decoration: BoxDecoration(
                          color: context.primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(AppRadii.sm.r),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.cloudArrowUp,
                            size: 14.r,
                            color: context.primary,
                          ),
                        ),
                      ),
                      AppSpacing.sm.verticalSpace,
                      Padding(
                        padding: REdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                        child: Text(
                          widget.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.s12w500.copyWith(
                            color: context.onSurface,
                          ),
                        ),
                      ),
                      AppSpacing.xs.verticalSpace,
                      Text(
                        AppStrings.tapToUpload,
                        style: AppTextStyles.s11w500.copyWith(
                          color: context.onSurface.withValues(alpha: 0.45),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
          ),
          if (widget.isUploading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: context.surface.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(AppRadii.lg.r),
                ),
                child: Center(child: LoadingDots(color: context.primary)),
              ),
            ),
          if (hasImage && !widget.isUploading)
            Positioned(
              top: 8.r,
              right: 8.r,
              child: Container(
                padding: REdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: context.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.40),
                  ),
                ),
                child: FaIcon(
                  FontAwesomeIcons.check,
                  color: AppColors.success,
                  size: 10.r,
                ),
              ),
            ),
        ],
      ).animate().fadeIn(duration: 240.ms),
    );
  }
}
