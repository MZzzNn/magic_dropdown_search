part of '../magic_dropdown_search.dart';

class DropDownSearchDialog extends StatefulWidget {
  final Widget body;
  final double dropdownHeight;
  final GlobalKey<FormFieldState<String>> dropdownKey;
  final DropDownBoxDecoration? dropdownBoxDecoration;

  const DropDownSearchDialog({
    super.key,
    required this.body,
    required this.dropdownKey,
    this.dropdownBoxDecoration,
    required this.dropdownHeight,
  });

  static Future<String?> show(
    BuildContext context,
    Widget body,
    GlobalKey<FormFieldState<String>> dropdownKey,
    DropDownBoxDecoration? dropdownBoxDecoration,
    double dropdownHeight,
  ) async {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.05),
      builder: (context) {
        return DropDownSearchDialog(
            body: body,
            dropdownKey: dropdownKey,
            dropdownHeight: dropdownHeight,
            dropdownBoxDecoration: dropdownBoxDecoration);
      },
    );
  }

  @override
  State<DropDownSearchDialog> createState() => _DropDownSearchDialogState();
}

class _DropDownSearchDialogState extends State<DropDownSearchDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Offset _getPosition(BuildContext context) {
    RenderBox renderBox = widget.dropdownKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    return position;
  }

  Size _getSize(BuildContext context) {
    RenderBox renderBox = widget.dropdownKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size;
  }

  double _getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double _getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  @override
  Widget build(BuildContext context) {
    final position = _getPosition(context);
    final size = _getSize(context);
    final screenHeight = _getScreenHeight(context);
    final keyboardHeight = _getKeyboardHeight(context);
    final availableSpaceBelow = screenHeight - position.dy - size.height - keyboardHeight;

    bool showAbove = availableSpaceBelow < widget.dropdownHeight;

    return Stack(
      children: [
        Positioned(
          top: showAbove ? position.dy - widget.dropdownHeight : position.dy + 30,
          left: position.dx,
          child: Material(
            color: widget.dropdownBoxDecoration?.color ??
                Theme.of(context).scaffoldBackgroundColor,
            elevation: widget.dropdownBoxDecoration?.elevation ?? 5,
            shape: widget.dropdownBoxDecoration?.shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                      color: Color.fromRGBO(42, 140, 255, 0.1)),
                ),
            shadowColor: widget.dropdownBoxDecoration?.shadowColor,
            child: FadeTransition(
              opacity: _animation,
              child: SizeTransition(
                sizeFactor: _animation,
                axisAlignment: 0.0,
                child: Container(
                  width: size.width,
                  height: widget.dropdownHeight,
                  padding: const EdgeInsets.all(10),
                  child: widget.body,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DropDownBoxDecoration {
  ShapeBorder? shape;
  double? elevation;
  Color? color;
  Color? shadowColor;

  DropDownBoxDecoration({
    this.shape,
    this.elevation,
    this.color,
    this.shadowColor,
  });
}
