import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_theme.dart';

class ErrorHandler {
  // Show success snackbar
  static void showSuccess(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Success',
      message,
      backgroundColor: AppTheme.successColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(AppTheme.spacingM),
      borderRadius: AppTheme.radiusM,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  // Show error snackbar
  static void showError(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Error',
      message,
      backgroundColor: AppTheme.errorColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
      margin: const EdgeInsets.all(AppTheme.spacingM),
      borderRadius: AppTheme.radiusM,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  // Show warning snackbar
  static void showWarning(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Warning',
      message,
      backgroundColor: AppTheme.warningColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(AppTheme.spacingM),
      borderRadius: AppTheme.radiusM,
      icon: const Icon(Icons.warning, color: Colors.white),
    );
  }

  // Show info snackbar
  static void showInfo(String message, {String? title}) {
    Get.snackbar(
      title ?? 'Info',
      message,
      backgroundColor: AppTheme.infoColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(AppTheme.spacingM),
      borderRadius: AppTheme.radiusM,
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }

  // Show confirmation dialog
  static Future<bool> showConfirmationDialog({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isDestructive ? AppTheme.errorColor : AppTheme.primaryColor,
            ),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  // Show error dialog
  static void showErrorDialog({
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onConfirm,
  }) {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: AppTheme.errorColor),
            const SizedBox(width: AppTheme.spacingS),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
              onConfirm?.call();
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  // Show loading dialog
  static void showLoadingDialog({String message = 'Loading...'}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: AppTheme.spacingM),
              Text(message),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  // Hide loading dialog
  static void hideLoadingDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  // Show bottom sheet
  static void showBottomSheet({
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppTheme.radiusL),
            topRight: Radius.circular(AppTheme.radiusL),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null) ...[
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: AppTheme.headline6,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
            Flexible(child: child),
          ],
        ),
      ),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  // Handle API errors
  static void handleApiError(dynamic error) {
    String message = 'An unexpected error occurred';

    if (error is String) {
      message = error;
    } else if (error.toString().contains('network')) {
      message = 'Network error. Please check your connection.';
    } else if (error.toString().contains('timeout')) {
      message = 'Request timeout. Please try again.';
    } else if (error.toString().contains('unauthorized')) {
      message = 'Unauthorized access. Please login again.';
    } else if (error.toString().contains('not found')) {
      message = 'Resource not found.';
    } else if (error.toString().contains('server')) {
      message = 'Server error. Please try again later.';
    }

    showError(message);
  }

  // Handle form validation errors
  static void handleValidationError(Map<String, String> errors) {
    if (errors.isEmpty) return;

    final firstError = errors.values.first;
    showError(firstError);
  }
}

// Error widget for displaying errors in UI
class ErrorWidget extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;
  final IconData? icon;

  const ErrorWidget({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(height: AppTheme.spacingM),
            if (title != null) ...[
              Text(
                title!,
                style: AppTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingS),
            ],
            Text(
              message,
              style: AppTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppTheme.spacingL),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Empty state widget
class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String? title;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionText;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 64,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(height: AppTheme.spacingM),
            if (title != null) ...[
              Text(
                title!,
                style: AppTheme.headline5,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingS),
            ],
            Text(
              message,
              style: AppTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
            if (onAction != null && actionText != null) ...[
              const SizedBox(height: AppTheme.spacingL),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Network error widget
class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NetworkErrorWidget({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: 'No Internet Connection',
      message: 'Please check your internet connection and try again.',
      icon: Icons.wifi_off,
      onRetry: onRetry,
    );
  }
}

// Server error widget
class ServerErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const ServerErrorWidget({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: 'Server Error',
      message: 'Something went wrong on our end. Please try again later.',
      icon: Icons.cloud_off,
      onRetry: onRetry,
    );
  }
}
