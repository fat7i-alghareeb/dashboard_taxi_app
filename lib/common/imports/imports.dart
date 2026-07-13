// lib/common/import/imports.dart

library;

// Dart core (safe & common)
export 'dart:async';
export 'dart:math';

export 'package:easy_localization/easy_localization.dart' hide TextDirection;
// Flutter (UI layer)
export 'package:flutter/material.dart';
export 'package:flutter/widgets.dart';
export 'package:flutter_animate/flutter_animate.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:reactive_forms/reactive_forms.dart';
export 'package:go_router/go_router.dart';

export '../../core/injection/injectable.dart';
export "../../core/theme/app_colors.dart";
export "../../core/theme/app_text_styles.dart";
export "../../core/utils/bloc_status.dart";
export "../../core/utils/result.dart";
export "../../core/utils/status_builder.dart";
// Design system
export '../../utils/constants/design_constants.dart';
export '../../utils/extensions/context_extensions.dart';
export '../../utils/extensions/date_time_extensions.dart';
export '../../utils/extensions/enum_extensions.dart';
export '../../utils/extensions/iterable_extensions.dart';
export "../../utils/extensions/reactive_forms_extensions.dart";
export '../../utils/extensions/string_extensions.dart';
export '../../utils/extensions/text_direction_extensions.dart';
export '../../utils/extensions/theme_extensions.dart';
// Extensions (UI-safe only)
export '../../utils/extensions/widget_extensions.dart';
//assets
export '../../utils/gen/assets.gen.dart';
// AppStrings
export "../../utils/helpers/app_strings.dart";
export "../../utils/helpers/build_svg_icon.dart";
// helpers
export "../../utils/helpers/colored_print.dart";
export "../../utils/helpers/input_formatters.dart";
export "../widgets/app_bottom_sheet.dart";
export "../widgets/app_card_info_row.dart";
export "../widgets/app_dialog.dart";
export "../widgets/app_icon_source.dart";
export "../widgets/app_image_viewer.dart";
export "../widgets/app_shimmer.dart";
// widgets
export "../widgets/button/app_button.dart";
export "../widgets/button/app_button_child.dart";
export "../widgets/button/app_button_variants.dart";
export "../widgets/chips/app_filter_chip_item.dart";
export "../widgets/chips/app_filter_chip_wrap.dart";
export "../widgets/empty_state_widget.dart";
export "../widgets/failed_state_widget.dart";
export "../widgets/headers/app_screen_header.dart";
export "../widgets/shimmer/app_list_shimmer.dart";
export "../widgets/status_badge/app_status_badge.dart";
export "../widgets/form/app_reactive_text_field.dart";
export "../widgets/form/app_reactive_validation_messages.dart";
export "../widgets/full_screen_image_screen.dart";
export "../widgets/custom_scaffold/app_scaffold.dart";
export "../widgets/loading_dots.dart";
export "../widgets/main_loading_progress.dart";
