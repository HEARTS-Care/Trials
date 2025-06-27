import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;
  final LoadingType type;
  final double size;
  final Color? color;

  const LoadingIndicator({
    super.key,
    this.message,
    this.type = LoadingType.circular,
    this.size = 40.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLoader(),
          if (message != null) ...[
            const SizedBox(height: AppTheme.spacingM),
            Text(
              message!,
              style: AppTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoader() {
    final loaderColor = color ?? AppTheme.primaryColor;

    switch (type) {
      case LoadingType.circular:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: loaderColor,
            strokeWidth: 3,
          ),
        );
      case LoadingType.linear:
        return SizedBox(
          width: size * 2,
          child: LinearProgressIndicator(
            color: loaderColor,
            backgroundColor: loaderColor.withOpacity(0.2),
          ),
        );
      case LoadingType.dots:
        return _buildDotsLoader(loaderColor);
      case LoadingType.pulse:
        return _buildPulseLoader(loaderColor);
    }
  }

  Widget _buildDotsLoader(Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 600 + (index * 200)),
          builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: size * 0.3,
              height: size * 0.3,
              decoration: BoxDecoration(
                color: color.withOpacity(value),
                shape: BoxShape.circle,
              ),
            );
          },
          onEnd: () {
            // Restart animation
          },
        );
      }),
    );
  }

  Widget _buildPulseLoader(Color color) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.2),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: size * 0.6,
                height: size * 0.6,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum LoadingType {
  circular,
  linear,
  dots,
  pulse,
}

// Full screen loading overlay
class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  final LoadingType type;
  final Color? backgroundColor;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.type = LoadingType.circular,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: backgroundColor ?? Colors.black.withOpacity(0.5),
            child: LoadingIndicator(
              message: message,
              type: type,
            ),
          ),
      ],
    );
  }
}

// Loading button
class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonStyle? style;
  final String? loadingText;

  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.child,
    this.style,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: isLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingS),
                Text(loadingText ?? 'Loading...'),
              ],
            )
          : child,
    );
  }
}
