import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/app/theme/app_colors.dart';

enum _ToastType { added, removed }

class AppToast {
  static OverlayEntry? _current;

  static void showAdded(BuildContext context, String message) => _show(context, message, _ToastType.added);

  static void showRemoved(BuildContext context, String message) => _show(context, message, _ToastType.removed);

  static void _show(BuildContext context, String message, _ToastType type) {
    _current?.remove();
    _current = null;

    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder:
          (_) => _ToastWidget(
            message: message,
            type: type,
            colors: context.appColors,
            onDismissed: () {
              entry.remove();
              if (_current == entry) _current = null;
            },
          ),
    );

    _current = entry;
    overlay.insert(entry);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final _ToastType type;
  final AppColors colors;
  final VoidCallback onDismissed;

  const _ToastWidget({required this.message, required this.type, required this.colors, required this.onDismissed});

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      reverseDuration: const Duration(milliseconds: 220),
    );

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) {
        _controller.reverse().then((_) {
          if (mounted) widget.onDismissed();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAdded = widget.type == _ToastType.added;
    final dotColor = isAdded ? widget.colors.aliveColor : widget.colors.favouriteColor;

    return Positioned(
      bottom: 100.h,
      left: 0,
      right: 0,
      child: SafeArea(
        child: FadeTransition(
          opacity: _opacity,
          child: SlideTransition(
            position: _slide,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: widget.colors.titleText,
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: .18), blurRadius: 20.r, offset: Offset(0, 6.h)),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7.r,
                      height: 7.r,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: dotColor.withValues(alpha: .5), blurRadius: 6, spreadRadius: 1)],
                      ),
                    ),
                    SizedBox(width: 9.w),
                    Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: widget.colors.cardBackground,
                        letterSpacing: 0.1,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
