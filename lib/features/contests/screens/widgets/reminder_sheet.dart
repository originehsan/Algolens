import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:algolens/core/constants/app_strings.dart';
import 'package:algolens/core/helpers/snackbar_helper.dart';
import 'package:algolens/core/router/app_router.dart';
import 'package:algolens/core/theme/app_colors.dart';
import 'package:algolens/core/theme/app_text_styles.dart';
import 'package:algolens/features/contests/data/models/contest_model.dart';
import 'package:algolens/features/contests/data/models/reminder_selection_state.dart';
import 'package:algolens/features/contests/providers/reminder_sheet_provider.dart';
import 'package:go_router/go_router.dart';

/// Pure view — reads ReminderSelectionState from
/// reminderSheetProvider and renders it. Contains zero business
/// logic: no diffing, no time math, no persistence calls. Every
/// interaction delegates to ReminderSheetNotifier.
class ReminderSheet extends ConsumerStatefulWidget {
  const ReminderSheet({super.key, required this.contest});

  final ContestModel contest;

  @override
  ConsumerState<ReminderSheet> createState() => _ReminderSheetState();
}

class _ReminderSheetState extends ConsumerState<ReminderSheet> {
  @override
  void initState() {
    super.initState();
    // Start the 20s re-validation tick once, when the sheet opens.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(reminderSheetProvider(widget.contest).notifier)
          .startLiveValidation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(reminderSheetProvider(widget.contest));

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: AppColors.bgCenter,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: AppColors.glassBorder, width: 1.0),
      ),
      child: state.isLive
          ? const _LiveState()
          : _PickerState(contest: widget.contest),
    );
  }
}

// ── Drag handle — shared by both states ─────────────────

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 36.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: AppColors.textHint,
          borderRadius: BorderRadius.circular(2.r),
        ),
      ),
    );
  }
}

// ── Live contest — nothing to schedule ───────────────────

class _LiveState extends StatelessWidget {
  const _LiveState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _DragHandle(),
        Gap(24.h),
        Icon(Icons.timer_off_outlined, color: AppColors.textMuted, size: 36.r),
        Gap(12.h),
        Text(
          'Contest already started',
          style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary),
        ),
        Gap(4.h),
        Text(
          'Reminders can only be set before a contest begins.',
          style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          textAlign: TextAlign.center,
        ),
        Gap(20.h),
      ],
    );
  }
}

// ── Normal picker state ──────────────────────────────────

class _PickerState extends ConsumerWidget {
  const _PickerState({required this.contest});
  final ContestModel contest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(reminderSheetProvider(contest));
    final notifier = ref.read(reminderSheetProvider(contest).notifier);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _DragHandle(),
        Gap(20.h),

        Text(AppStrings.setReminder, style: AppTextStyles.h3),
        Gap(4.h),
        Text(
          contest.name,
          style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        Gap(24.h),

        Text(AppStrings.howEarly, style: AppTextStyles.label),
        Gap(4.h),
        Text(
          'Choose up to ${ReminderSelectionState.maxReminders} reminder times',
          style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
        ),
        Gap(14.h),

        ...ReminderSelectionState.presetMinutes.map((minutes) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _ReminderOptionTile(
              label: minutes < 60
                  ? '$minutes min before'
                  : '${minutes ~/ 60}hr before',
              isChecked: state.selectedMinutes.contains(minutes),
              isEnabled: state.isPresetSelectable(minutes),
              disabledReason: !state.isPresetValid(minutes)
                  ? 'Too late for this option'
                  : null,
              onTap: () => notifier.togglePreset(minutes),
            ),
          );
        }),

        _CustomOptionTile(
          customMinutes: state.customMinutes,
          isChecked: state.customMinutes != null &&
              state.selectedMinutes.contains(state.customMinutes),
          canPick: state.canPickCustom,
          stepMinutes: state.customSliderDivisionStep,
          maxMinutes: state.customSliderMaxMinutes,
          onPick: (minutes) => notifier.setCustom(minutes),
          onRemove: notifier.removeCustom,
        ),
        Gap(24.h),

        _PremiumTile(
          onTap: () {
            Navigator.pop(context);
            context.pushNamed(RouteNames.settings);
          },
        ),

        // ── Save button — only visible when there's a real diff ──
        if (state.hasPendingChanges) ...[
          Gap(28.h),
          GestureDetector(
            onTap: !state.isSaving
                ? () => _handleSave(context, notifier, state)
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: state.isSaving
                    ? SizedBox(
                        width: 20.r,
                        height: 20.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(AppStrings.setReminder, style: AppTextStyles.button),
              ),
            ),
          ),
        ],

        if (state.hasAnySaved) ...[
          Gap(12.h),
          Center(
            child: GestureDetector(
              onTap: !state.isSaving
                  ? () => _handleRemoveAll(context, notifier)
                  : null,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  AppStrings.removeReminder,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.danger.withValues(alpha: 0.80),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _handleSave(
    BuildContext context,
    ReminderSheetNotifier notifier,
    ReminderSelectionState state,
  ) async {
    final wasEmpty = state.selectedMinutes.isEmpty;
    final saved = await notifier.save();
    HapticFeedback.lightImpact();
    if (context.mounted && saved) {
      Navigator.pop(context);
      SnackbarHelper.success(
        context,
        wasEmpty ? AppStrings.reminderRemoved : AppStrings.reminderSaved,
      );
    }
  }

  Future<void> _handleRemoveAll(
    BuildContext context,
    ReminderSheetNotifier notifier,
  ) async {
    await notifier.removeAll();
    HapticFeedback.lightImpact();
    if (context.mounted) {
      Navigator.pop(context);
      SnackbarHelper.info(context, AppStrings.reminderRemoved);
    }
  }
}

// ── Preset / checkbox-style option tile ──────────────────

class _ReminderOptionTile extends StatelessWidget {
  const _ReminderOptionTile({
    required this.label,
    required this.isChecked,
    required this.isEnabled,
    required this.onTap,
    this.disabledReason,
  });

  final String label;
  final bool isChecked;
  final bool isEnabled;
  final VoidCallback onTap;
  final String? disabledReason;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isChecked
              ? AppColors.primary.withValues(alpha: 0.10)
              : Colors.white.withValues(alpha: isEnabled ? 0.04 : 0.02),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isChecked
                ? AppColors.primary.withValues(alpha: 0.35)
                : Colors.white.withValues(alpha: 0.08),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.notifications_outlined,
              color: isChecked
                  ? AppColors.primary
                  : (isEnabled ? AppColors.textMuted : AppColors.textHint),
              size: 20.r,
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isEnabled
                          ? (isChecked
                              ? AppColors.textPrimary
                              : AppColors.textSecondary)
                          : AppColors.textHint,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (disabledReason != null && !isEnabled)
                    Text(
                      disabledReason!,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: 22.r,
              height: 22.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isChecked ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isChecked ? AppColors.primary : AppColors.textHint,
                  width: 1.5,
                ),
              ),
              child: isChecked
                  ? Icon(Icons.check_rounded, size: 12.r, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Custom time option ───────────────────────────────────

class _CustomOptionTile extends StatelessWidget {
  const _CustomOptionTile({
    required this.customMinutes,
    required this.isChecked,
    required this.canPick,
    required this.stepMinutes,
    required this.maxMinutes,
    required this.onPick,
    required this.onRemove,
  });

  final int? customMinutes;
  final bool isChecked;
  final bool canPick;
  final int stepMinutes;
  final int maxMinutes;
  final ValueChanged<int> onPick;
  final VoidCallback onRemove;

  String get _label {
    if (customMinutes == null) return 'Custom time';
    final m = customMinutes!;
    return m < 60
        ? '$m min before (custom)'
        : '${m ~/ 60}hr ${m % 60}m before (custom)';
  }

  Future<void> _openPicker(BuildContext context) async {
    final picked = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _CustomMinutesPicker(
        maxMinutes: maxMinutes,
        stepMinutes: stepMinutes,
      ),
    );
    if (picked != null) onPick(picked);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = customMinutes != null;
    final disabled = !canPick && !hasValue;

    return GestureDetector(
      onTap: disabled ? null : () => _openPicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isChecked
              ? AppColors.primary.withValues(alpha: 0.10)
              : Colors.white.withValues(alpha: disabled ? 0.02 : 0.04),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isChecked
                ? AppColors.primary.withValues(alpha: 0.35)
                : Colors.white.withValues(alpha: 0.08),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.edit_calendar_outlined,
              color: isChecked
                  ? AppColors.primary
                  : (disabled ? AppColors.textHint : AppColors.textMuted),
              size: 20.r,
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _label,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: disabled
                          ? AppColors.textHint
                          : (isChecked
                              ? AppColors.textPrimary
                              : AppColors.textSecondary),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (disabled)
                    Text(
                      'Needs at least 3hr before start',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                ],
              ),
            ),
            if (hasValue)
              GestureDetector(
                onTap: onRemove,
                child: Icon(Icons.close_rounded,
                    size: 18.r, color: AppColors.textMuted),
              )
            else
              Icon(Icons.chevron_right_rounded,
                  size: 20.r, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

// ── Custom minutes picker bottom sheet ───────────────────

class _CustomMinutesPicker extends StatefulWidget {
  const _CustomMinutesPicker({
    required this.maxMinutes,
    required this.stepMinutes,
  });

  /// Already clamped by the caller to min(12hr, timeUntilStart).
  final int maxMinutes;
  final int stepMinutes;

  @override
  State<_CustomMinutesPicker> createState() => _CustomMinutesPickerState();
}

class _CustomMinutesPickerState extends State<_CustomMinutesPicker> {
  static const _fixedMin = ReminderSelectionState.customMinMinutes;

  late int _value = _snapToStep(((_fixedMin + widget.maxMinutes) / 2).round());

  int _snapToStep(int raw) {
    final snapped = (raw / widget.stepMinutes).round() * widget.stepMinutes;
    return snapped.clamp(_fixedMin, widget.maxMinutes);
  }

  int get _divisions => ((widget.maxMinutes - _fixedMin) / widget.stepMinutes)
      .floor()
      .clamp(1, 200);

  String get _formatted {
    final h = _value ~/ 60;
    final m = _value % 60;
    return m == 0 ? '${h}hr before' : '${h}hr ${m}m before';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: AppColors.bgCenter,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(color: AppColors.glassBorder, width: 1.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _DragHandle(),
          Gap(20.h),
          Text('Custom reminder time', style: AppTextStyles.h4),
          Gap(4.h),
          Text(
            'Between 3hr and ${(widget.maxMinutes / 60).toStringAsFixed(0)}hr before',
            style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
          ),
          Gap(20.h),
          Text(
            _formatted,
            style: AppTextStyles.h2.copyWith(color: AppColors.primary),
          ),
          Gap(16.h),
          Slider(
            value: _value.toDouble(),
            min: _fixedMin.toDouble(),
            max: widget.maxMinutes.toDouble(),
            divisions: _divisions,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.primary.withValues(alpha: 0.15),
            onChanged: (v) => setState(() => _value = _snapToStep(v.round())),
          ),
          _HourTickLabels(
            minMinutes: _fixedMin,
            maxMinutes: widget.maxMinutes,
          ),
          Gap(24.h),
          GestureDetector(
            onTap: () => Navigator.pop(context, _value),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: Text('Confirm', style: AppTextStyles.button),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Premium locked tile ───────────────────────────────────

// -- Hour tick labels beneath the custom slider -----------

class _HourTickLabels extends StatelessWidget {
  const _HourTickLabels({
    required this.minMinutes,
    required this.maxMinutes,
  });
  final int minMinutes;
  final int maxMinutes;
  @override
  Widget build(BuildContext context) {
    final minHour = (minMinutes / 60).ceil();
    final maxHour = (maxMinutes / 60).floor();
    final hours = [for (var h = minHour; h <= maxHour; h++) h];
    if (hours.length < 2) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: hours.map((h) {
          return Text(
            '$h',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textHint,
              fontSize: 9.sp,
            ),
          );
        }).toList(),
      ),
    );
  }
}
class _PremiumTile extends StatelessWidget {
  const _PremiumTile({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.warning.withValues(alpha: 0.25),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.phone_in_talk_outlined,
              color: AppColors.warning.withValues(alpha: 0.70),
              size: 20.r,
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.agentCall,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          AppStrings.premium,
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.warning,
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppStrings.agentCallSub,
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.lock_outline_rounded,
              color: AppColors.warning.withValues(alpha: 0.60),
              size: 16.r,
            ),
          ],
        ),
      ),
    );
  }
}
