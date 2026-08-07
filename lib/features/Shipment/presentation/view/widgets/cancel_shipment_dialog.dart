import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/cancel_shipment_cubit.dart';
import 'package:driver_application/features/Shipment/presentation/manager/cubit/cancel_shipment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelShipmentDialog extends StatefulWidget {
  const CancelShipmentDialog({
    super.key,
    required this.shipmentId,
    required this.cancelCubit,
  });

  final int shipmentId;

  /// Pass the already-created cubit so the dialog can emit on the same
  /// instance that the parent BlocConsumer is listening to.
  final CancelShipmentCubit cancelCubit;

  @override
  State<CancelShipmentDialog> createState() => _CancelShipmentDialogState();
}

class _CancelShipmentDialogState extends State<CancelShipmentDialog> {
  final TextEditingController _commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.cancelCubit,
      child: BlocConsumer<CancelShipmentCubit, CancelShipmentState>(
        listener: (context, state) {
          if (state is CancelShipmentSuccess || state is CancelShipmentFailure) {
            // Close dialog after success or failure — parent listener handles
            // SnackBar / navigation.
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          final bool isLoading = state is CancelShipmentLoading;
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header ──────────────────────────────────────────────
                    Row(
                      children: [
                        const Icon(
                          Icons.cancel_outlined,
                          color: AppColors.failedColor,
                          size: 26,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'إلغاء الشحنة',
                          style: AppTextStyle.semiBold16.copyWith(
                            color: AppColors.failedColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 12),

                    // ── Instruction ─────────────────────────────────────────
                    Text(
                      'يرجى ذكر سبب إلغاء الشحنة',
                      style: AppTextStyle.medium14.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // ── Comment field ────────────────────────────────────────
                    TextFormField(
                      controller: _commentController,
                      maxLines: 4,
                      minLines: 3,
                      enabled: !isLoading,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: 'اكتب سبب الإلغاء هنا...',
                        hintStyle: AppTextStyle.medium14.copyWith(
                          color: Colors.black38,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.primaryColor,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.failedColor,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.failedColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'يجب كتابة سبب الإلغاء';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // ── Action buttons ───────────────────────────────────────
                    Row(
                      children: [
                        // Dismiss
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isLoading
                                ? null
                                : () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: AppColors.primaryColor,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              'تراجع',
                              style: AppTextStyle.medium14.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Confirm cancel
                        Expanded(
                          child: TextButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      widget.cancelCubit.cancelShipment(
                                        id: widget.shipmentId,
                                        comment: _commentController.text.trim(),
                                      );
                                    }
                                  },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.failedColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'تأكيد الإلغاء',
                                    style: AppTextStyle.medium14.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
