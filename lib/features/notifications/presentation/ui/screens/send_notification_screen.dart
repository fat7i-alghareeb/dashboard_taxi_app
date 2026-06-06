import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:dashboardtaxi/common/widgets/show_overlay.dart';
import 'package:dashboardtaxi/features/notifications/constants/notification_forms.dart';
import 'package:dashboardtaxi/features/notifications/data/params/broadcast_notification_params.dart';
import 'package:dashboardtaxi/features/notifications/domain/facade/notification_facade.dart';
import 'package:dashboardtaxi/features/notifications/presentation/states/send_notification_bloc.dart';

class SendNotificationScreen extends StatelessWidget {
  const SendNotificationScreen({super.key});

  static const String pagePath = '/send-notification';
  static const String pageName = 'SendNotificationScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SendNotificationBloc(getIt<NotificationFacade>()),
      child: const _SendNotificationBody(),
    );
  }
}

class _SendNotificationBody extends StatefulWidget {
  const _SendNotificationBody();

  @override
  State<_SendNotificationBody> createState() => _SendNotificationBodyState();
}

class _SendNotificationBodyState extends State<_SendNotificationBody> {
  final _form = NotificationForms.broadcastFormGroup();

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_form.invalid) {
      _form.markAllAsTouched();
      return;
    }

    final params = BroadcastNotificationParams(
      title: (_form.control(NotificationForms.titleField).value as String)
          .trim(),
      body: (_form.control(NotificationForms.bodyField).value as String).trim(),
    );

    context.read<SendNotificationBloc>().add(SendNotificationSubmitted(params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendNotificationBloc, SendNotificationState>(
      listenWhen: (prev, curr) => prev.submitStatus != curr.submitStatus,
      listener: (context, state) {
        if (state.submitStatus.isSuccess) {
          showSuccessOverlay(context, AppStrings.sendNotificationSuccess);
          _form.reset();
        } else if (state.submitStatus.isFailed) {
          showErrorOverlay(
            context,
            state.submitStatus.errorMessage ??
                AppStrings.sendNotificationFailed,
          );
        }
      },
      child: ReactiveForm(
        formGroup: _form,
        child: AppScaffold.appBar(
          appBarConfig: AppScaffoldAppBarConfig(
            title: AppStrings.sendNotificationTitle,
            subtitle: AppStrings.sendNotificationSubtitle,
          ),
          child: SingleChildScrollView(
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.lg,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppReactiveTextField.text(
                  formControlName: NotificationForms.titleField,
                  title: AppStrings.sendNotificationFieldTitle,
                  hintText: AppStrings.sendNotificationFieldTitleHint,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.lg.verticalSpace,
                AppReactiveTextField.text(
                  formControlName: NotificationForms.bodyField,
                  title: AppStrings.sendNotificationFieldBody,
                  hintText: AppStrings.sendNotificationFieldBodyHint,
                  minLines: 4,
                  maxLines: 8,
                ),
                AppSpacing.sm.verticalSpace,
                Text(
                  AppStrings.sendNotificationAudienceNote,
                  style: AppTextStyles.s12w400.copyWith(
                    color: context.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                AppSpacing.xl.verticalSpace,
                BlocBuilder<SendNotificationBloc, SendNotificationState>(
                  builder: (context, state) {
                    return ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return AppButton.primary(
                          isActive: form.valid,
                          isLoading: state.submitStatus.isLoading,
                          layout: const AppButtonLayout(height: 52),
                          onTap: () => _submit(context),
                          child: AppButtonChild.label(
                            AppStrings.sendNotificationSubmit,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
